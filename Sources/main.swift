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

func handleMessage(data:NSMutableData, socket:Socket) {
    let d = NSMutableData(data: data as Data)
    let ident = d.firstASCIIByte()
    
    print("ident: \(ident)")

    switch ident {
    case "R":
        // Auth
        handleAuth(data: d, socket: socket)
        break
    case "T":
        // Row Description
        let result = BackendMessage.parseRawBuffer(data: data)
        let queryResult = QueryResult(messages: result.0)
        
        let parsedResult = queryResult.parsedResult()
        print(parsedResult)
        
        break
    case "E":
        //"ErrorResponse";
        break
    case "S":
        //"ParameterStatus";
        break
    case "K":
        //"BackendKeyData";
        print("BackendKeyData")
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
    let d = NSMutableData(data: data as Data)
//    let buf = ByteBuffer(buffer: d)
    let buf = ByteBuffer(data: d, index: 0)
    buf.readIndex = 5
    let authType = buf.decodeInt()
    print(authType)
    
    switch authType {
    case 0:
        // AuthenticationOk
        print("AuthenticationOk")
        
        let query = QueryMessage(query: "SELECT * FROM core_user;")
        do {
            try socket.write(from: query.messageData())
            
            
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
        print("Unhandled Message")
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
    let data = StartupMessage(username:username, database:database).messageData()
    try blueSocket.write(from: data)
    
    let response = NSMutableData()
    _ = try blueSocket.read(into: response)
    
    handleMessage(data: response, socket: blueSocket)
} catch let error as NSError{
    // do something with the error
    print("we have an error creating BlueSocket")
    print(error.localizedDescription)
}

//while 1 > 0 {
//    
//}
