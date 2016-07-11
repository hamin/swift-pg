import Foundation
import Dispatch
import Socket
import MD5

// do {
//     let connection = try Connection(host: "127.0.0.1")
//     try connection.connect()

// } catch {
//     // do something with the error
//     print("we hav an error")
// }

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

let u = "metabase-dev"
let db = "metabase-pager-copy"

//let u = "chappie"
//let db = "chappie-dev"

let url = "127.0.0.1"
let pwd = ""


//let u = "pagerpg"
//let db = "postgres"
//let url = "pagerpg.czzazgihja6p.us-east-1.rds.amazonaws.com"
//
//let pwd = "8K%4uO1y4$67"

let connectionParams = ConnectionParameters(host: url, port: Int32(5432), options: "", databaseName: db, user: u, password: pwd)


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

// Query (F)
// Byte1('Q')
// Int32 - Length
// String - Query String
//exports.query = function (queryString) {
//    queryString = queryString + '\u0000';
//    var messageLength = Buffer.byteLength(queryString) + 5,
//    buf = new Buffer(messageLength);
//    buf.write('Q');
//    buf.writeInt32BE(messageLength - 1, 1);
//    buf.write(queryString, 5);
//    return buf;
//};
func makeQuery(query:String) -> NSMutableData {
    let queryData = NSMutableData()
    
//    queryData.appendString(value: "Q")
    queryData.appendStringWithoutTerminator(value: "Q")
    queryData.appendInt32(value: query.lengthOfBytes(using: NSUTF8StringEncoding) + 5)
    queryData.appendString(value: query)
    return queryData
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

func handleMessage(data:NSMutableData, socket:Socket) {
    let d = NSMutableData(data: data)
    let ident = d.firstASCIIByte()
    
    print("ident: \(ident)")

    switch ident {
    case "R":
        // Auth
        handleAuth(data: d, socket: socket)
        break
    case "T":
        // Row Description
//        handleRowDescription(data: d, socket: socket)
//        let result = parseRawBuffer(data: data)
        let result = BackendMessage.parseRawBuffer(data: data)
        
        break
    case "E":
        //"ErrorResponse";
        break
    case "S":
        //"ParameterStatus";
        break
    case "K":
        //"BackendKeyData";
        break
    case "Z":
        //"ReadyForQuery";
        break
    case "D":
        //"DataRow";
        break
    case "C":
        // "CommandComplete";
        break;
    case "N":
        //"NoticeResponse";
        break
    default:
        print("unahndled ident: \(ident)")
        break
    }
}

func handleAuth(data:NSMutableData, socket:Socket) {
    let d = NSMutableData(data: data)
//    let buf = ByteBuffer(buffer: d)
    let buf = ByteBuffer(data: d, index: 0)
    buf.readIndex = 5
    let authType = buf.decodeInt()
    print(authType)
    
    switch authType {
    case 0:
        // AuthenticationOk
        print("AuthenticationOk")
        
//        let query = makeQuery(query: "SELECT NOW() AS current_time")
        let query = makeQuery(query: "SELECT * FROM core_user;")
        do {
            try socket.write(from: query)
            
            
            let queryResponse = NSMutableData()
            _ = try socket.read(into: queryResponse)
            
            handleMessage(data: queryResponse, socket: socket)
            break
        } catch {
            
            print("something bad qith query happened")
            break
        }


//        break
    case 2:
        // AuthenticationKerberosV5;
        break
    case 3:
        // AuthenticationCleartextPassword;
        print("AuthenticationCleartextPassword")
        break
    case 5:
        // AuthenticationMD5Password;
        print("AuthenticationMD5Password")
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
    
//    try blueSocket.setBlocking(mode: true)
    print("isBlocking: \(blueSocket.isBlocking)")
    
    let username = connectionParams.user
    let database = connectionParams.databaseName
    let data = startupMessage(username: username, database: database)
    try blueSocket.write(from: data)
    
    let response = NSMutableData()
    _ = try blueSocket.read(into: response)
    
    handleMessage(data: response, socket: blueSocket)
    
//    let queryData = makeQuery(query: "SELECT NOW() AS current_time")
//    
//    try blueSocket.write(from: queryData)
//    
//    
//    let queryResponse = NSMutableData()
//    _ = try blueSocket.read(into: queryResponse)
//
//    print("queryresponse ascii")
//    
//    print(queryResponse.firstASCIIByte())

} catch let error as NSError{
    // do something with the error
    print("we have an error creating BlueSocket")
    print(error.localizedDescription)
}

//while 1 > 0 {
//    
//}
