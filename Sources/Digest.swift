//
//  Digest.swift
//  SwiftDigest
//
//  Created by Brent Royal-Gordon on 8/26/14.
//  Copyright (c) 2014 Groundbreaking Software. All rights reserved.
//

import Foundation

internal extension NSData {
    var bufferPointer: UnsafeBufferPointer<UInt8> {
        return UnsafeBufferPointer<UInt8>(start: UnsafePointer(self.bytes), count: self.length)
    }
}

internal extension UInt8 {
    private static let allHexits: [Character] = Array("0123456789abcdef".characters)
    
    func toHex() -> String {
        let nybbles = [ self >> 4, self & 0x0F ]
        let hexits = nybbles.map { (nybble) -> Character in
            return UInt8.allHexits[Int(nybble)]
        }
//        let hexits = map(nybbles) { nybble in UInt8.allHexits[Int(nybble)] }
//        return String(seq: hexits)
        return String(hexits)
    }
}

/// Digest is an immutable object representing a completed digest. Use the Digest
/// object to fetch the completed digest in various forms.
final public class Digest: Equatable, Hashable {
    /// The digest as a series of bytes.
    public let bytes: [UInt8]
    
    /// The digest as an NSData object.
    public lazy var data: NSData = {
        var temp = self.bytes
        return NSData(bytes: &temp, length: temp.count)
    }()
    
    /// The digest as a hexadecimal string.
    public lazy var hex: String = self.bytes.map { byte in byte.toHex() }.reduce("", combine: +)
    
    /// The digest as a base64-encoded String.
    public func base64WithOptions(options: NSDataBase64EncodingOptions) -> String {
        return data.base64EncodedString(options)
    }
    
    /// The digest as an array of base64-encoded bytes.
//    public func base64BytesWithOptions(options: NSDataBase64EncodingOptions) -> [UInt8] {
//        return withExtendedLifetime(base64DataWithOptions(options: options)) { (data: NSData) in
//            return Array(data.bufferPointer)
//        }
//    }
    
    /// The digest as an NSData object of base64-encoded bytes.
    public func base64DataWithOptions(options: NSDataBase64EncodingOptions) -> NSData {
        return data.base64EncodedData(options)
    }
    
    /// Creates a Digest from an array of bytes. You should not normally need to
    /// call this yourself.
    public init(bytes: [UInt8]) {
        self.bytes = bytes
    }
    
    /// Creates a Digest by copying the algorithm object and finish()ing it. You
    /// should not normally need to call this yourself.
//    public convenience init<Algorithm: AlgorithmType>( algorithm: Algorithm) {
//        var algorithm = algorithm
//        self.init(bytes: algorithm.finish())
//    }
    
    public lazy var hashValue: Int = {
        // This should actually be a great hashValue for cryptographic digest
        // algorithms, since each bit should contain as much entropy as
        // every other.
        var value: Int = 0
        let usedBytes = self.bytes[0 ..< min(self.bytes.count, sizeof(Int))]
        
        for byte in usedBytes {
            value <<= 8
            value &= Int(byte)
        }
        
        return value
    }()
}

/// Tests if two digests are exactly equal.
public func == (lhs: Digest, rhs: Digest) -> Bool {
    return lhs.bytes == rhs.bytes
}

/// Tests which digest is "less than" the other. Note that this comparison treats
/// shorter digests as "less than" longer digests; this should only occur if you
/// compare digests created by different algorithms.
//public func < (lhs: Digest, rhs: Digest) -> Bool {
//    if lhs.bytes.count < rhs.bytes.count {
//        // rhs is a larger number
//        return true
//    }
//    
//    if lhs.bytes.count > rhs.bytes.count {
//        // lhs is a larger number
//        return false
//    }
//    
//    return lexicographicalCompare(lhs.bytes, rhs.bytes)
//}