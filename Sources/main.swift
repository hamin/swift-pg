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
        self.appendBytes(&val, length: sizeofValue(val))
    }
    
    func appendInt16(value : Int16) {
        var val = value.bigEndian
        self.appendBytes(&val, length: sizeofValue(val))
    }
    
    func appendInt8(value : Int8) {
        var val = value
        self.appendBytes(&val, length: sizeofValue(val))
    }
    
    func appendString(value : String) {
        value.withCString {
            self.appendBytes($0, length: Int(strlen($0)) + 1)
        }
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

let connectionParams = ConnectionParameters(host: "127.0.0.1", port: Int32(5432), options: "", databaseName: "metabase-pager-copy", user: "metabase-dev", password: "")


var blueSocket: Socket
let backgroundQueue = backgroundThread()

func createStartupMessage(user:String, database:String ){
    
}

do {
	blueSocket = try Socket.makeDefault()
    try blueSocket.connect(to: connectionParams.host, port: connectionParams.port)
    print("cool: \(blueSocket.isConnected)")
//    try blueSocket.write(from: "COOL StuFF")
    
//    let date = "\u{0000}\u{0000}\u{00008}\u{0000}\u{0003}\u{0000}\u{0000}user\u{0000}metabase-dev\u{0000}database\u{0000}metabase-pager-copy\u{0000}\u{0000}"
////    try blueSocket.write(from: "\u{0000}\u{0000}\u{00008}\u{0000}\u{0003}\u{0000}\u{0000}user\u{0000}metabase-dev\u{0000}database\u{0000}metabase-pager-copy\u{0000}\u{0000}" )
////    let foo = try blueSocket.readString()
//    try blueSocket.write(from: date)
//    var data = NSMutableData()
//    print(data)
//    let foo = try blueSocket.read(into: data)
//    print(foo)
//    print(data)
//    print(data.length)
    
//    var startupMessageData = NSMutableData(capacity: (22 + connectionParams.user.characters.count + 1 + connectionParams.databaseName.characters.count + 1 + 1))
//    startupMessageData.
//    startupMessageData?.appendInt8(0)
//    startupMessageData?.appendInt32(196608)
//    startupMessageData?.appendString("user")
//    startupMessageData?.appendString(connectionParams.user)
//    startupMessageData?.appendString("database")
//    startupMessageData?.appendString(connectionParams.databaseName)
//    startupMessageData?.appendInt8(0)
//    print(startupMessageData)
    
    
    
    var startupMessageData = NSMutableData()
//    startupMessageData.appendInt8(0)
//    startupMessageData.appendInt8(0)
    startupMessageData.appendInt32(8)
//    startupMessageData.appendInt32(0)
    startupMessageData.appendInt32(3)
//    startupMessageData.appendInt32(0)
    startupMessageData.appendInt32(0)
    startupMessageData.appendString("user")
    startupMessageData.appendInt32(0)
    startupMessageData.appendString(connectionParams.user)
    startupMessageData.appendInt32(0)
    startupMessageData.appendString("database")
    startupMessageData.appendInt32(0)
    startupMessageData.appendString(connectionParams.databaseName)
    startupMessageData.appendInt32(0)
    startupMessageData.appendInt32(0)
    print(startupMessageData)
    try blueSocket.write(from: startupMessageData)
    
//    let foo = try blueSocket.readString()
//    print(foo)
    
} catch let error as NSError{
    // do something with the error
    print("we have an error creating BlueSocket")
    print(error.localizedDescription)
}

//var createStartupMessage = function(user_name, database_name){
//    
//    var buffer_size = 22 + user_name.length + 1 + database_name.length + 1 + 1;
//    var StartUpMessage = new Buffer(buffer_size);
//    var position_in_buffer = 0;
//    
//    StartUpMessage.writeUInt32BE(buffer_size, 0);
//    position_in_buffer += 4;
//    
//    StartUpMessage.writeUInt32BE(196608, position_in_buffer); //version 3.0
//    position_in_buffer += 4;
//    
//    position_in_buffer = addMessageSegment(StartUpMessage, "user", position_in_buffer);
//    position_in_buffer = addMessageSegment(StartUpMessage, user_name, position_in_buffer);
//    
//    position_in_buffer = addMessageSegment(StartUpMessage, "database", position_in_buffer);
//    position_in_buffer = addMessageSegment(StartUpMessage, database_name, position_in_buffer);
//    
//    //Add the last null terminator to the buffer
//    addNullTerminatorToMessageSegment(StartUpMessage, position_in_buffer);
//    
//    console.log("The StartUpMessage looks like this in Hexcode: " + StartUpMessage.toString('hex'));
//    console.log("The length of the StartupMessage in Hexcode is: " + StartUpMessage.toString('hex').length);
//    
//    return StartUpMessage;
//    
//};

//var addMessageSegment = function(StartUpMessage, message_segment, position_in_buffer){
//    
//    var bytes_in_message_segment = Buffer.byteLength(message_segment);
//    
//    StartUpMessage.write(message_segment, position_in_buffer, StartUpMessage - position_in_buffer, 'utf8');
//    position_in_buffer = position_in_buffer + bytes_in_message_segment;
//    
//    position_in_buffer = addNullTerminatorToMessageSegment(StartUpMessage, position_in_buffer);
//    
//    return position_in_buffer;
//    
//};
//
//
//var addNullTerminatorToMessageSegment = function(StartUpMessage, position_in_buffer){
//    
//    StartUpMessage.writeUInt8(0, position_in_buffer);
//    position_in_buffer = position_in_buffer + 1;
//    
//    return position_in_buffer;
//    
//};




