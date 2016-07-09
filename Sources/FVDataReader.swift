//
//  FVDataReader.swift
//  ForkView
//
//  Created by Kevin Wojniak on 5/2/15.
//  Copyright (c) 2015 Kevin Wojniak. All rights reserved.
//

import Foundation

final class FVDataReader {
    private var data = NSData()
    private var pos = 0
    
    var length: Int {
        get {
            return data.length
        }
    }
    
    var position: Int {
        get {
            return pos
        }
    }
    
    init(_ data: NSData) {
        self.data = data
    }
    
    init?(URL: NSURL, resourceFork: Bool) {
        // Apple's docs say "The maximum size of the resource fork in a file is 16 megabytes"
        let maxResourceSize = 16777216
        if !resourceFork {
            var fileSize: AnyObject?
            do {
                try URL.getResourceValue(&fileSize, forKey: NSURLFileSizeKey)
            } catch _ {
            }
            let fileSizeNum = fileSize as? NSNumber
            if fileSizeNum == nil {
                return nil
            }
            if fileSizeNum!.intValue == 0 || fileSizeNum!.intValue >= maxResourceSize {
                return nil
            }
            let data = NSData(contentsOf: URL)
            if data == nil {
                return nil
            }
            self.data = data!
        } else {
            let rsrcSize = getxattr(URL.path!, XATTR_RESOURCEFORK_NAME, nil, 0, 0, 0)
            if rsrcSize <= 0 || rsrcSize >= maxResourceSize {
                return nil
            }
            let data = NSMutableData(length: rsrcSize)
            if data == nil {
                return nil
            }
            if getxattr(URL.path!, XATTR_RESOURCEFORK_NAME, data!.mutableBytes, rsrcSize, 0, 0) != rsrcSize {
                return nil
            }
            self.data = data!
        }
    }
    
    class func dataReader(URL: NSURL, resourceFork: Bool) -> FVDataReader? {
        return FVDataReader(URL: URL, resourceFork: resourceFork)
    }
    
    func read(size: Int) -> NSData? {
        if (pos + size > self.length) {
            return nil
        }
        let subdata = data.subdata(with: NSMakeRange(pos, size))
        pos += size
        return subdata
    }
    
    func read(size: CUnsignedInt, into buf: UnsafeMutablePointer<Void>) -> Bool {
        let data = self.read(size: Int(size))
        if data == nil {
            return false
        }
//        data!.getBytes(buf)
        data!.getBytes(buf, length: Int(size))
        return true
    }
    
    func seekTo(offset: Int) -> Bool {
        if (offset >= self.length) {
            return false
        }
        pos = offset
        return true
    }
    
    enum Endian {
        case Little, Big
    }
    
    func readUInt16(endian: Endian, _ val: inout UInt16) -> Bool {
        if let dat = read(size: sizeof(UInt16)) {
            dat.getBytes(&val)
            val = endian == .Big ? UInt16(bigEndian: val) : UInt16(littleEndian: val)
            return true
        }
        return false
    }
    
    func readInt16(endian: Endian, _ val: inout Int16) -> Bool {
        if let dat = read(size: sizeof(Int16)) {
            dat.getBytes(&val)
            val = endian == .Big ? Int16(bigEndian: val) : Int16(littleEndian: val)
            return true
        }
        return false
    }
    
    func readUInt32(endian: Endian, _ val: inout UInt32) -> Bool {
        if let dat = read(size: sizeof(UInt32)) {
            dat.getBytes(&val)
            val = endian == .Big ? UInt32(bigEndian: val) : UInt32(littleEndian: val)
            return true
        }
        return false
    }
    
    func readInt32(endian: Endian, _ val: inout Int32) -> (Bool, Int32) {
        if let dat = read(size: sizeof(Int32)) {
            dat.getBytes(&val)
            val = endian == .Big ? Int32(bigEndian: val) : Int32(littleEndian: val)
            return (true, val)
        }
        return (false, 0)
    }
    
    func readUInt8( val: inout UInt8) -> Bool {
        if let dat = read(size: sizeof(UInt8)) {
            dat.getBytes(&val)
            return true
        }
        return false
    }
    
    func readInt8( val: inout Int8) -> Bool {
        if let dat = read(size: sizeof(Int8)) {
            dat.getBytes(&val)
            return true
        }
        return false
    }
}