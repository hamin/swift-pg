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
    
    func appendStringWithoutTerminator(value : String) {
        self.append(value, length: Int(strlen(value)) )
    }
}


extension NSData {
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
        let result = parseRawBuffer(data: data)
        
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
// RowDescription
// Byte1('T')
// Int32 - Length
// Int16 - number of fields in a row
// For Each Field:
// String - field name
// Int32 - Object ID of the parent table, or 0 if not part of a table
// Int16 - Attribute number of the column, or 0 if not part of a table
// Int32 - Object ID of the data type
// Int16 - data type size; negative = variable-width.  see pg_type.typlen
// Int32 - type modifier; see pg_attribute.atttypmod
// Int16 - format code for the field; 0 = text; 1 = binary.  0 means unknown when responding to a Describe
// Adds rowDescription property to messageObj.  Value is an array of objects.  Each object:
//  fieldName
//  parentTableObjectID
//  attributeNumber
//  dataTypeObjectID
//  dataTypeSize
//  typeModifier
//  formatCode
//var rowDescription = function rowDescription(messageObj) {
//    var numberOfFields = messageObj.data.readInt16BE(0),
//    fieldDescription,
//    i,
//    curVal,
//    strLen = 0,
//    ptr = 2; // start after numberOfFields
//    messageObj.rowDescription = [];
//    for (i = 0; i < numberOfFields; i += 1) {
//        fieldDescription = {};
//        strLen = 0;
//        curVal = messageObj.data[ptr];
//        while (curVal !== 0) {
//            strLen += 1;
//            curVal = messageObj.data[ptr + strLen];
//        }
//        fieldDescription.fieldName = messageObj.data.toString('utf8', ptr, ptr + strLen);
//        ptr += strLen + 1;
//        fieldDescription.parentTableObjectID = messageObj.data.readInt32BE(ptr);
//        ptr += 4;
//        fieldDescription.attributeNumber = messageObj.data.readInt16BE(ptr);
//        ptr += 2;
//        fieldDescription.dataTypeObjectID = messageObj.data.readInt32BE(ptr);
//        ptr += 4;
//        fieldDescription.dataTypeSize = messageObj.data.readInt16BE(ptr);
//        ptr += 2;
//        fieldDescription.typeModifier = messageObj.data.readInt32BE(ptr);
//        ptr += 4;
//        fieldDescription.formatCode = messageObj.data.readInt16BE(ptr);
//        ptr += 2;
//        messageObj.rowDescription.push(fieldDescription);
//    }
//    return messageObj;
//};

struct FieldInfo {
    let field:String
    let tableId:Int32
    let columnId:Int16
    let typeId:Int32
    let typeSize:Int16
    let typeModifier:Int32
    let formatCode:Int16
}

/**
 
 ** Row Description Frame **
 
'T' | int32 Len | int16 numfields
                +
str col  | int32 tableoid | int16 colno | int32 typeoid | int16 typelen | int32 typmod | int16 format

*/
func handleRowDescription(data:NSMutableData, socket:Socket) {
    let buffer = ByteBuffer(buffer: data)

    // Offset ident 'T' byte and int32 frame length Bytes
//    let numFieldsByteOffset = 1 + sizeof(UInt32)
//    buffer.readIndex = numFieldsByteOffset
    
    buffer.readIndex = 1 // Skip 'T' byte
    
    let rowDescriptionLength = Int(buffer.decodeInt())
    
    let numberOfFields = buffer.decodeInt16()
    
    print("Row description Length: \(rowDescriptionLength)")
    
    print("Number of fields: \(numberOfFields)")
//    print(data.byteArray)
    
    var fields:[FieldInfo] = []
    
    for _ in 0..<numberOfFields {
        var strLength = 0
        var nameBytes:[Int8] = []
        
        var continueParsingName = true
        
        while continueParsingName {
            let curVal = buffer.decodeByte()
            if curVal == 0 {
                continueParsingName = false
            } else {
                nameBytes.append(curVal)
                strLength += 1
            }
        }
        
        let fieldName = NSString(cString: nameBytes, encoding: NSUTF8StringEncoding)! as String
        print(fieldName)
        
        let field = FieldInfo(
            field: fieldName,
            tableId:
            buffer.decodeInt(),
            columnId: buffer.decodeInt16(),
            typeId: buffer.decodeInt(),
            typeSize: buffer.decodeInt16(),
            typeModifier: buffer.decodeInt(),
            formatCode: buffer.decodeInt16()
        )
        
        fields.append(field)
    }
    
    print(fields)
    
//    handleDataRow(data: data, socket: socket, fields: fields, buffer: buffer)
    var curDataIndex = rowDescriptionLength + 1
//    let dataAscii = data.ASCIIByteAtIndex(index: startingDataIndex )
    
    var dataRowBuffers:[ByteBuffer] = []
    var dataRowData:[NSData] = []
    
    var continueParsingDataRows = true
    
    while continueParsingDataRows {
        if data.ASCIIByteAtIndex(index: curDataIndex ) == "D" {
            _ = buffer.decodeByte()
            let dataRowLength = Int(buffer.decodeInt())
            print(dataRowLength)
            let range = NSMakeRange(curDataIndex, dataRowLength)
            let rowData = data.subdata(with: range)
            dataRowData.append(rowData)
            let dataRowBuffer = ByteBuffer(data: rowData)
            dataRowBuffers.append(dataRowBuffer)
            curDataIndex += dataRowLength
        } else {
            continueParsingDataRows = false
        }
    }
    
    
    
}


//var dataRow = function dataRow(messageObj) {
//    var numColumns = messageObj.data.readInt16BE(0),
//    i,
//    columnValueLength,
//    columnValue,
//    ptr = 2; // Start after the length data.
//    messageObj.rowValue = [];
//    for (i = 0; i < numColumns; i += 1) {
//        columnValueLength = messageObj.data.readInt32BE(ptr);
//        ptr += 4;
//        
//        if (columnValueLength >= 0) {
//            columnValue = messageObj.data.toString('utf8', ptr, ptr + columnValueLength);
//            ptr += columnValueLength;
//        } else {
//            columnValue = null;
//        }
//        messageObj.rowValue.push(columnValue);
//    }
//    messageObj.data = undefined;
//    return messageObj;
//};

func handleDataRow(data:NSMutableData, socket:Socket, fields:[FieldInfo], buffer: ByteBuffer) {
    
    
    
    
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
