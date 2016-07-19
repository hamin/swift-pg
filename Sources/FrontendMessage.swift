//
//  FrontendMessage.swift
//  swift-pg
//
//  Created by Haris Amin on 7/12/16.
//
//

import Foundation
import MD5

public enum FrontendMessageType: String {
    case StartUp = "S"
    case Query = "Q"
    case Password = "P"
}

protocol FrontendMessage {
    var messageType: FrontendMessageType { get }
    func messageData() -> NSData
}

public struct StartupMessage: FrontendMessage {
    static let protocolVersion = 196608
    
    var messageType: FrontendMessageType {
        return .StartUp
    }
    
    func messageData() -> NSData {
        return self.data
    }
    
    private var data: NSMutableData = NSMutableData()
    
    init(username:String, database:String, options:[String:Any]? = nil) {
        let connectionData = NSMutableData()
        connectionData.appendString(value: "user")
        connectionData.appendString(value: username)
        connectionData.appendString(value: "database")
        connectionData.appendString(value: database)
        connectionData.appendString(value: "") // undocumented final termination
        
        self.data.appendInt32(value: Int32(connectionData.length) + 8)
        self.data.appendInt32(value: Int32(StartupMessage.protocolVersion))
        self.data.append(connectionData)
        //    self.data(value: "")
    }
}

public struct QueryMessage: FrontendMessage {
    
    var messageType: FrontendMessageType {
        return .Query
    }
    
    func messageData() -> NSData {
        return self.data
    }
    
    private var data: NSMutableData = NSMutableData()
    
    init(query:String) {
        self.data.appendStringWithoutTerminator(value: "Q")
        self.data.appendInt32(value: query.lengthOfBytes(using: NSUTF8StringEncoding) + 5)
        self.data.appendString(value: query)
    }
}


// PasswordMessage (F)
// Byte1('p')
// Int32 - Length
// String - password (encrypted or plaintext, depending on Backend request)
//exports.passwordMessage = function (password, encrypted, user, salt) {
//
//    var messageLength = 5,
//    buf,
//    passusermd5,
//    md5hash;
//    encrypted = (encrypted === undefined) ? false : encrypted;
//    if (encrypted === true) {
//        passusermd5 = crypto.createHash('md5').update(password + user).digest('hex');
//        md5hash = crypto.createHash('md5').update(passusermd5 + salt.toString('binary')).digest('hex');
//        password = 'md5' + md5hash;
//        console.log(salt);
//        console.log(password);
//    }
//    messageLength += Buffer.byteLength(password);
//
//    buf = new Buffer(messageLength + 1);
//    buf.write('p', 0);
//    buf.writeInt32BE(messageLength, 1);
//    buf.write(password + '\u0000', 5);
//
//    return buf;
//};
func makePasswordMessage(password:String, encrypted:Bool, user:String, salt:String) -> NSMutableData {
    var messageLength = 5
    
    var pwd = ""
    
    if encrypted == true {
        let passUserMD5 = MD5.calculate(password + user)
        let passUserMD55DigestHex = Digest(bytes: passUserMD5).hex
        
        let md5hash = MD5.calculate(passUserMD55DigestHex + salt)
        let md5hashDigextHex = Digest(bytes: md5hash).hex
        
        pwd = "md5" + md5hashDigextHex
    }
    
    messageLength += pwd.utf16.count
    
    let passwordData = NSMutableData()
    passwordData.appendStringWithoutTerminator(value: "P")
    passwordData.appendInt32(value: Int32(messageLength))
    passwordData.appendString(value: pwd)
    
    return passwordData
}