//
//  NSData+Bytes.swift
//  swift-pg
//
//  Created by Haris Amin on 7/10/16.
//
//

import Foundation

public extension NSMutableData {
    
    func appendInt32(value : Int32) {
        var val = value.bigEndian
        self.append(&val, length: MemoryLayout.size(ofValue: val))
    }
    
    func appendInt16(value : Int16) {
        var val = value.bigEndian
        self.append(&val, length: MemoryLayout.size(ofValue: val))
    }
    
    func appendInt8(value : Int8) {
        var val = value
        self.append(&val, length: MemoryLayout.size(ofValue: val))
    }
    
    func appendString(value : String) {
        value.withCString {
            self.append($0, length: Int(strlen($0)) + 1)
        }
    }
    
    func appendStringWithoutTerminator(value : String) {
        self.append(value, length: Int(strlen(value)) )
    }
}


public extension NSData {
    public func firstASCIIByte() -> String {
        var bytes = [UInt8](repeating: 0, count: 1)
        getBytes(&bytes, length: 1)
        return String(UnicodeScalar( bytes[0] ))
    }
    
    public func ASCIIByteAtIndex(index: Int) -> String {
        var bytes = [UInt8](repeating: 0, count: length)
        getBytes(&bytes, length: length)
        return String(UnicodeScalar( bytes[index] ))
    }
}
