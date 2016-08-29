//
//  BackendMessage.swift
//  swift-pg
//
//  Created by Haris Amin on 7/4/16.
//
//

import Foundation

/// Array of bytes, little-endian representation. Don't use if not necessary.
/// I found this method slow
//func arrayOfBytes<T>(value:T, length:Int? = nil) -> Array<UInt8> {
//    let totalBytes = length ?? MemoryLayout<T>.size
//    
//    var valuePointer = UnsafeMutablePointer<T>.allocate(capacity: 1)
//    valuePointer.pointee = value
//    
////    let bytesPointer = UnsafeMutablePointer<UInt8>(valuePointer)
//    let bytesPointer = UnsafeMutablePointer<UInt8>.withMemoryRebound(valuePointer)
//    var bytes = Array<UInt8>(repeating: 0, count: totalBytes)
//    for j in 0..<min(MemoryLayout<T>.size,totalBytes) {
//        bytes[totalBytes - 1 - j] = (bytesPointer + j).pointee
//    }
//    
//    valuePointer.deinitialize()
//    valuePointer.deallocate(capacity: 1)
//    
//    return bytes
//}

struct FieldInfo {
    let field:String
    let tableId:Int32 // Object ID of the parent table, or 0 if not part of a table
    let columnId:Int16 // Attribute number of the column, or 0 if not part of a table
    let typeId:Int32 // Object ID of the data type
    let type:PGType // Corresponding PGType to typeId
    let typeSize:Int16 // data type size; negative = variable-width.  see pg_type.typlen
    let typeModifier:Int32 // type modifier; see pg_attribute.atttypmod
    let formatCode:Int16 // ormat code for the field; 0 = text; 1 = binary.  0 means unknown when responding to a Describe
}


public enum BackendMessageType: String {
    case Authentication = "R"
    case RowDescription = "T"
    case DataRow = "D"
    case CommandCompletion = "C"
    case ReadyForQuery = "Z"
    case ErrorResponse = "E"
    case ParameterStatus = "S"
    case BackendKeyData = "K"
}

struct BackendMessage {
    let messageType:BackendMessageType
    let buffer:ByteBuffer
    var parsedResult:Any?

    init(buffer:ByteBuffer, type:String) {
        self.buffer = buffer
        self.messageType = BackendMessageType(rawValue: type)!
    }

    private mutating func parse() {
        switch messageType {
        case .RowDescription:
            parseRowDescription()
            break
        case .DataRow:
            parseDataRow()
            break
        default:
            break
        }
    }


    // Mark - Parses the raw buffer into BackendMessages
    static func parseRawBuffer(data:NSData) -> ([BackendMessage], ByteBuffer?) {
        var objects:[BackendMessage] = []
        var ptr = 0
        let length = data.length

        var partialMessage:ByteBuffer?

//        let bytes:[UInt8] = data.byteArray
//        data.bytes
//        let bytes = data.withUnsafeBytes {
//            [UInt8](UnsafeBufferPointer(start: $0, count: data.count))
//        }
        
        let count = data.length / MemoryLayout<UInt8>.size
        // create an array of Uint8
        var bytes = [UInt8](repeating: 0, count: count)
        // copy bytes into array
        data.getBytes(&bytes, length:count * MemoryLayout<UInt8>.size)
        
        
        while ptr < length {
            let startingPtr = ptr
            if (length < ptr + 5) {
                //            objects.partialMessage = null;
                //            objects.partialMessage = new Buffer(length - ptr);
                //            rawBuffer.copy(objects.partialMessage, 0, ptr); // short circuit if we are at the last message of the chunk.
                partialMessage = nil
                let objByteSlice = bytes[0..<ptr]
                let objByteArray = Array(objByteSlice)
                partialMessage = ByteBuffer(data: objByteArray)
                break;
            }

            let type = String(UnicodeScalar( bytes[ptr] ))
            ptr += 1

            var dataLength:Int32 = 0;
            data.getBytes(&dataLength, range: NSRange(location: startingPtr + 1, length: 4))
            let objLength = dataLength.bigEndian

            ptr += MemoryLayout<Int32>.size // should be 4

            // If the remaining object is less than the detected length, then stop processing:
            if length < (ptr + objLength - 4) {
                //            objects.partialMessage = null;
                //            objects.partialMessage = new Buffer((length - ptr) + 5);
                //            rawBuffer.copy(objects.partialMessage, 0, ptr - 5); // short circuit if we are at the last message of the chunk.
                partialMessage = nil
                let objByteSlice = bytes[0..<(ptr - 5)]
                let objByteArray = Array(objByteSlice)
                partialMessage = ByteBuffer(data: objByteArray)
                break; // short circuit if we are at the last message of the chunk.
            }

            let objByteSlice = bytes[startingPtr..<Int(startingPtr + objLength)]
            let objByteArray = Array(objByteSlice)
            let buffer = ByteBuffer(data: objByteArray)

            var backendMessage = BackendMessage(buffer: buffer, type: type)
            backendMessage.parse()
            objects.append(backendMessage)
            ptr = startingPtr + Int(objLength) + 1
        }

        return (objects, partialMessage)
    }
}

extension BackendMessage {

    /** Row Description Frame **

    'T' | int32 Len | int16 numfields
    +
    str col  | int32 tableoid | int16 colno | int32 typeoid | int16 typelen | int32 typmod | int16 format
    */
    mutating func parseRowDescription() {

        // Offset ident 'T' byte and int32 frame length Bytes
        buffer.readIndex = 1 // Skip 'T' byte

        let rowDescriptionLength = Int(buffer.decodeInt())

        let numberOfFields = buffer.decodeInt16()

        print("Row description Length: \(rowDescriptionLength)")

        print("Number of fields: \(numberOfFields)")

        var fields:[FieldInfo] = []

        for _ in 0..<numberOfFields {
            var strLength = 0
            var nameBytes:[Int8] = []

            var continueParsingName = true

            while continueParsingName {
                let curVal = buffer.decodeByte()
                if curVal == 0 {
                    continueParsingName = false
                } else {
                    nameBytes.append(curVal)
                    strLength += 1
                }
            }

            var fieldName = ""

            for byte in nameBytes {
                fieldName.append(UnicodeScalar(Int(byte))!.description)
            }
            print(fieldName)

            let tableId = buffer.decodeInt()
            let columnId = buffer.decodeInt16()
            let typeId = buffer.decodeInt()
            let type = PGType(rawValue: Int(typeId))!
            let typeSize = buffer.decodeInt16()
            let typeModifier = buffer.decodeInt()

            // Note: This might be a hack? Last byte might be missing a null terminator??!?!
            if (buffer.readIndex + 2) > buffer.buffer.length  {
                buffer.readIndex = buffer.buffer.length - 2
            }

            let formatCode = buffer.decodeInt16()


            let field = FieldInfo(
                field: fieldName,
                tableId: tableId,
                columnId: columnId,
                typeId: typeId,
                type: type,
                typeSize: typeSize,
                typeModifier: typeModifier,
                formatCode: formatCode
            )

            fields.append(field)
        }

        print(fields)
        self.parsedResult = fields
        buffer.readIndex = 0 // reset buffer index
    }


    /** Data Row Frame **

     'D' | int32 Len | int16 number of columns
     +
     (for each field)
     int32 value length  | str string value
     */
    mutating func parseDataRow() {
        buffer.readIndex = 1 // Skip 'D' byte

//        let foo = String(UnicodeScalar( buffer.buffer.byteArray[0] ))
//        print(foo)

        let _ = buffer.decodeInt()
        let numColumns = buffer.decodeInt16()

        var row:[Any?] = []

        for _ in 0..<numColumns {

            // Note: This might be a hack? Last byte might be missing a null terminator??!?!
            if (buffer.readIndex + 4) > buffer.buffer.length  {
                buffer.readIndex = buffer.buffer.length - 4
            }

            let columnValueLength = buffer.decodeInt()

            if columnValueLength >= 0 {
                // Note: This might be a hack? Last byte might be missing a null terminator??!?!
                if (buffer.readIndex + Int(columnValueLength)) > buffer.buffer.length  {
                    buffer.readIndex = buffer.buffer.length - Int(columnValueLength)
                }

                let value = buffer.decodeStringForBytes(stringLength: Int(columnValueLength))
                print("val: \(value)")
                row.append(value)
            } else {
                row.append(nil)
            }
        }
        self.parsedResult = row
        buffer.readIndex = 0 // reset buffer index
    }
}
