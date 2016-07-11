//
//  BackendMessage.swift
//  swift-pg
//
//  Created by Haris Amin on 7/4/16.
//
//

import Foundation

public enum BackendMessageType: String {
    case Authentication = "R"
    case RowDescription = "T"
    case DataRow = "D"
    case CommandCompletion = "C"
    case ReadyForQuery = "Z"
}

struct BackendMessage {
    let messageType:BackendMessageType
    let buffer:ByteBuffer
    
    init(buffer:ByteBuffer, type:String) {
        self.buffer = buffer
        self.messageType = BackendMessageType(rawValue: type)!
    }
    
}

func parseRawBuffer(data:NSData) -> ([BackendMessage], ByteBuffer?) {
    var objects:[BackendMessage] = []
    var ptr = 0
    let length = data.length
    
    var partialMessage:ByteBuffer?
    
    let bytes:[UInt8] = data.byteArray
    
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

        ptr += sizeof(Int32) // should be 4
        
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
        
        let backendMessage = BackendMessage(buffer: buffer, type: type)
        objects.append(backendMessage)
        ptr = startingPtr + Int(objLength) + 1
    }
    
    return (objects, partialMessage)
}

///*
// * The purpose of this module is to parse messages (Buffer) and return a formatted object array.
// */
//
///*  Parses out the first character and the length of each message in the
// *  raw data stream, and returns an array of objects.
// *  type: Type Character
// *  length: original length of the message (includes 4 bytes for length value)
// *  data: Buffer containing remainder of message.
// */
//exports.Parse = function (rawBuffer) {
//    var objects = {messages: [], partialMessage: null},
//    obj,
//    ptr,
//    length = rawBuffer.length;
//    for (ptr = 0; ptr < length; ptr) {
//        obj = {};
//        // If the remaining buffer is too short to read type & length, then stop processing.
//        if (length < ptr + 5) {
//            objects.partialMessage = null;
//            objects.partialMessage = new Buffer(length - ptr);
//            rawBuffer.copy(objects.partialMessage, 0, ptr); // short circuit if we are at the last message of the chunk.
//            break;
//        }
//        obj.type = rawBuffer.toString('ascii', ptr, ptr + 1);
//        ptr += 1;
//        obj.objLength = rawBuffer.readInt32BE(ptr);
//        ptr += 4;
//        
//        // If the remaining object is less than the detected length, then stop processing:
//        if (length < ptr + obj.objLength - 4) {
//            objects.partialMessage = null;
//            objects.partialMessage = new Buffer((length - ptr) + 5);
//            rawBuffer.copy(objects.partialMessage, 0, ptr - 5); // short circuit if we are at the last message of the chunk.
//            break; // short circuit if we are at the last message of the chunk.
//        }
//        obj.data = new Buffer(obj.objLength - 4);
//        rawBuffer.copy(obj.data, 0, ptr, ptr + obj.data.length);
//        ptr += obj.data.length;
//        
//        objects.messages.push(obj);
//        
//    }
//    return objects; // array for the connection to loop through
//};