////
////  ByteBuffer.swift
////  swift-pg
////
////  Created by Haris Amin on 7/1/16.
////
////
//
//import Foundation
//
//enum ByteOrder : Int {
//    case BigEndian
//    case LittleEndian
//}
//
////@property (nonatomic, strong) NSMutableData *data;
////@property (nonatomic, assign) int capacity;
////@property (nonatomic, assign) ByteOrder byteOrder;
//
//class ByteBuffer {
//    var data: NSMutableData
//    var capacity: Int
//    var byteOrder: ByteOrder
//    
//    convenience init(order: ByteOrder) {
//        var buffer: ByteBuffer = ByteBuffer()
//        buffer.byteOrder = order
////        return buffer
//    }
//    
//    init() {
//        super.init()
//        self.data = NSMutableData.data()
//    }
//    
////    func setOrder(order: ByteOrder) {
////        self.byteOrder = order
////    }
//    
//    func put(b: Byte) {
//        self.data.appendBytes(b, length: sizeof())
//    }
//    
//    func putByteBuffer(bb: ByteBuffer) {
//        self.data.append(bb.convertNSData())
//    }
//    
//    func putData(data: NSData) {
//        self.data.append(data)
//    }
//    
//    func putShort(d: Int8) {
//        var temp: Int8 = d
//        if self.byteOrder == .BigEndian {
//            temp = CFSwapInt16HostToBig(d)
//        }
//        self.data.appendBytes(temp, length: sizeof())
//    }
//    
//    func putFloat(f: Float) {
//        var temp: Float = f
//        if self.byteOrder == .BigEndian {
//            temp = CFSwapInt16HostToBig(f)
//        }
//        self.data.appendBytes(temp, length: sizeof())
//    }
//    
//    func putInt(i: Int) {
//        var temp: Int = i
//        if self.byteOrder == .BigEndian {
//            temp = CFSwapInt16HostToBig(i)
//        }
//        self.data.appendBytes(&temp, length: sizeof())
//    }
//    
//    func get(index: Int) -> Byte {
//        var byte: Character = Character(self.data.bytes)
//        return byte[index]
//    }
//    
//    func getFloat(index: Int) -> Float {
//        var temp: Float = 0
//        var buffer: ByteBuffer = ByteBuffer()
//        buffer.putData(self.data.subdataWithRange(NSMakeRange(index, sizeof())))
//        buffer.convertNSData().getBytes(&temp, length: sizeof())
//        return temp
//    }
//    
//    func getInt(index: Int) -> Int {
//        var temp: Int
//        self.data.getBytes(&temp, range: NSMakeRange(index, sizeof()))
//        return temp
//    }
//    
//    func convertNSData() -> NSData {
//        return self.data
//    }
//    
//}


//
//  ByteBuffer.swift
//  mpush-client
//
//  Created by OHUN on 16/6/3.
//  Copyright © 2016年 OHUN. All rights reserved.
//

import Foundation

final class ByteBuffer {
    
    var buffer:NSMutableData
    lazy var readIndex = 0;
    
    init(data:[UInt8], index:Int=0){
        self.buffer = NSMutableData(bytes: data, length:data.count);
        self.readIndex = index;
    }
    
    init(data:NSData, index:Int=0){
        self.buffer = NSMutableData(data: data);
        self.readIndex = index;
    }
    
    init(buffer:NSMutableData = NSMutableData()){
        self.buffer = buffer;
    }
    
    func encodeByte( data:inout Int8) {
        buffer.append(&data, length:1)
    }
    
    func encodeInt16(data:Int16) {
        var d = data.bigEndian
        buffer.append(&d, length: 4)
    }
    
    func encodeInt32(data:Int32) {
        var d = data.bigEndian
        buffer.append(&d, length: 4)
    }
    
    func encodeInt64(data:Int64) {
        var d = data.bigEndian
        buffer.append(&d, length: 8)
    }
    
    func encodeByte( data:inout UInt8) {
        buffer.append(&data, length:1)
    }
    
    func encodeInt16(data:UInt16) {
        var d = data.bigEndian
        buffer.append(&d, length: 4)
    }
    
    func encodeInt32(data:UInt32) {
        var d = data.bigEndian
        buffer.append(&d, length: 4)
    }
    
    func encodeInt64(data:UInt64) {
        var d = data.bigEndian
        buffer.append(&d, length: 8)
    }
    
//    func encodeString(data:String?) {
//        if let s = data {
//            encodeBytes(Array(s.utf8))
//        }else{
////            encodeBytes([UInt8](repeating:0, count: 0))
//            encodeBytes(data: [UInt8](repeating:0, count: 0))
//        }
//    }
    
    func encodeBytes(data:[UInt8]?) {
        if let b = data {
            var len:UInt16 = UInt16(b.count).bigEndian
            buffer.append(&len, length: 2)
            if(len > 0) {
                buffer.append(b, length: b.count)
            }
        }else{
            var len:UInt16 = 0
            buffer.append(&len, length: 2)
        }
    }
    
    func encodeBytes(data:[Int8]?) {
        if let b = data {
            var len:UInt16 = UInt16(b.count).bigEndian
            buffer.append(&len, length: 2)
            if(len > 0) {
                buffer.append(b, length: b.count)
            }
        }else{
            var len:UInt16 = 0
            buffer.append(&len, length: 2)
        }
    }
    
    func decodeByte() -> Int8 {
        var data:Int8 = 0
        buffer.getBytes(&data, range: NSRange(location: readIndex, length: 1))
        readIndex += 1
        return data;
    }
    
    func decodeInt16() -> Int16 {
        var data:Int16 = 0
        buffer.getBytes(&data, range: NSRange(location: readIndex, length: 2))
        readIndex += 2
        return data.bigEndian;
    }
    
    func decodeInt() -> Int32 {
        var data:Int32 = 0;
        buffer.getBytes(&data, range: NSRange(location: readIndex, length: 4))
        readIndex += 4
        return data.bigEndian;
    }
    
    func decodeInt64() -> Int64 {
        var data:Int64 = 0;
        buffer.getBytes(&data, range: NSRange(location: readIndex, length: 8))
        readIndex += 8
        return data.bigEndian;
    }
    
    func decodeString() -> String? {
        if let data = decodeData() {
            return String(data: data, encoding: NSUTF8StringEncoding)
        }
        return nil;
    }
    
    func decodeData() -> NSData? {
        let length = Int(decodeInt16());
        if(length > 0){
            let data =  buffer.subdata(with: NSRange(location: readIndex, length: length));
            readIndex += length;
            return data;
        }
        return nil;
    }
    
    func decodeBytes() -> [Int8]? {
        let length = Int(decodeInt16());
        if(length > 0){
            var data = [Int8](repeating:0, count: length)
            buffer.getBytes(&data, range: NSRange(location: readIndex, length: length))
            readIndex += length
            return data;
        }
        return nil;
    }
    
    func decodeStringForBytes(stringLength:Int) -> String? {
        if stringLength > 0 {
            let data =  buffer.subdata(with: NSRange(location: readIndex, length: stringLength));
            readIndex += stringLength;
            return String(data: data, encoding: NSUTF8StringEncoding)
        }
        return nil
    }
}
