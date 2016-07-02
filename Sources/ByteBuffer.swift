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