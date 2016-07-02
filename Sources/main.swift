import Foundation
import Dispatch
import Socket

// do {
//     let connection = try Connection(host: "127.0.0.1")
//     try connection.connect()

// } catch {
//     // do something with the error
//     print("we hav an error")
// }

extension NSMutableData {

    func appendInt32(value : Int32) {
        var val = value.bigEndian
        self.append(&val, length: sizeofValue(val))
    }

    func appendInt16(value : Int16) {
        var val = value.bigEndian
        self.append(&val, length: sizeofValue(val))
    }

    func appendInt8(value : Int8) {
        var val = value
        self.append(&val, length: sizeofValue(val))
    }

    func appendString(value : String) {
        value.withCString {
            self.append($0, length: Int(strlen($0)) + 1)
        }
    }
}

extension NSData {
    public func firstASCIIByte() -> String {
        var bytes = [UInt8](repeating: 0, count: 1)
        getBytes(&bytes, length: length)
        return String(UnicodeScalar( bytes[0] ))
    }
    
    public func firstByteAsInt32BE() -> UInt32 {
//        var bytes = [UInt8](repeating: 0, count: length)
//        getBytes(&bytes, length: length)
        
//        return bytes[0].bigEndian
        
        var value : UInt32 = 0
//        let data = NSData(bytes: bytes, length: length)
//        data.getBytes(&value, length: 4)
        getBytes(&value, length: sizeofValue(bytes[0]))
        value = UInt32(bigEndian: value)
        return value
    }
}

public struct ConnectionParameters {
    public let host: String
    public let port: Int32
    public let options: String
    public let databaseName: String
    public let user: String
    public let password: String
}

//let u = "pager-dev"
//let db = "pager-dev"

//let u = "metabase-dev"
//let db = "metabase-pager-copy"

//let url = "127.0.0.1"


let u = "pagerpg"
let db = "postgres"
let url = "pagerpg.czzazgihja6p.us-east-1.rds.amazonaws.com"

let connectionParams = ConnectionParameters(host: url, port: Int32(5432), options: "", databaseName: db, user: u, password: "")


var blueSocket: Socket
//let backgroundQueue = backgroundThread()

func startupMessage(username:String, database:String) -> NSMutableData {
    let protocolVersion = 196608
    
    let connectionData = NSMutableData()
    connectionData.appendString(value: "user")
    connectionData.appendString(value: username)
    connectionData.appendString(value: "database")
    connectionData.appendString(value: database)
    connectionData.appendString(value: "") // undocumented final termination thingydoodle
    
    
    let mutableData = NSMutableData()
    mutableData.appendInt32(value: Int32(connectionData.length) + 8)
    mutableData.appendInt32(value: Int32(protocolVersion))
    mutableData.append(connectionData)
//    mutableData.appendString(value: "")
    
    print(mutableData)
    
    return mutableData
}

func handleMessage(data:NSMutableData) {
    let ident = data.firstASCIIByte()
    
    switch ident {
    case "R":
        // Auth
        handleAuth(data: data)
        break
    default:
        break
    }
}

func handleAuth(data:NSMutableData) {
    let firstInt = data.firstByteAsInt32BE()
    
    switch firstInt {
    case 0:
        // AuthenticationOk
        print("AuthenticationOk")
        break
    case 2:
        // AuthenticationKerberosV5;
        break
    case 3:
        // AuthenticationCleartextPassword;
        break
    case 5:
        // AuthenticationMD5Password;
        break;
    case 6:
        // AuthenticationSCMCredential;
        break
    case 7:
        // AuthenticationGSS;
        break
    case 9:
        // AuthenticationSSPI;
        break
    case 8:
        // AuthenticationGSSContinue;
        break
    default:
        break
    }
}

do {
	blueSocket = try Socket.create()
    try blueSocket.connect(to: connectionParams.host, port: connectionParams.port)
    print("cool: \(blueSocket.isConnected)")
    
    let username = connectionParams.user
    let database = connectionParams.databaseName
    let data = startupMessage(username: username, database: database)
    try blueSocket.write(from: data)
    
    let response = NSMutableData()
    _ = try blueSocket.read(into: response)
    
    handleMessage(data: response)
    
    

} catch let error as NSError{
    // do something with the error
    print("we have an error creating BlueSocket")
    print(error.localizedDescription)
}
