//
//  QueryResult.swift
//  swift-pg
//
//  Created by Haris Amin on 7/11/16.
//
//

import Foundation

public typealias QueryResultType = [ [String: Any?] ]
public typealias DataRowResultsType = [[Any?]]

public struct QueryResult {
    var fields: [FieldInfo] = []
    var dataRows: DataRowResultsType = []
    var isCommandComplete: Bool = false
    var isReadyForQUery: Bool = false
    
    static let PGDateFormatter: NSDateFormatter = NSDateFormatter()
    

    static func formatDate(dateString:String) -> NSDate {

        if QueryResult.PGDateFormatter.dateFormat == nil {
            QueryResult.PGDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ssZZ"
        }
        
        let ts:String
        
//        if ((dateString.range(of: ".")?.lowerBound) != nil) {
//            ts = String("\(dateString) +0000")
//        } else {
//            ts = String("\(dateString.substring(to: (dateString.range(of: ".")?.lowerBound)!)) +0000")
//        }
        
//        if dateString.rangeOfString(".").location != NSNotFound {
//            ts = "\(dateString.substringToIndex(dateString.startIndex.advancedBy(dateString.rangeOfString(".").location))) +0000"
//        }
//        else {
//            ts = "\(dateString) +0000"
//        }
        
        if let range: Range<String.Index> = dateString.range(of: ".") {
            let index: Int = dateString.distance(from: dateString.startIndex, to: range.lowerBound)
//            var start = advance(dateString.startIndex, index)
            
//            var end = advance(dateString.startIndex, index + dateString.length)
//            ts =  dateString.substringWithRange(Range<String.Index>(start: dateString.startIndex, end: index))
            ts = dateString.substring(with: range)
            
//            ts = dateString.substring(to: index) + " +0000"
        } else {
            ts = "\(dateString) +0000"
        }
        
        return QueryResult.PGDateFormatter.date(from: ts)!
    }
    
    init(messages: [BackendMessage]) {
        
        for msg in messages {
            switch msg.messageType {
            case .RowDescription:
                self.fields = msg.parsedResult as! [FieldInfo]
                break
            case .DataRow:
                let row = msg.parsedResult as! [Any?]
                self.dataRows.append(row)
                break
            case .CommandCompletion:
                self.isCommandComplete = true
                break
            case .ReadyForQuery:
                self.isReadyForQUery = true
                break
            default:
                break
            }
        }
    }
    
    static func dateFromResult(s:String) -> NSDate {
        
        return NSDate()
    }
    
    static func timeFromResult(s:String) -> NSDate {
        
        return NSDate()
    }
    
    static func timeStampFromResult(s:String) -> NSDate {
        
//        return NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = NSTimeZone(name: "UTC")
        
        guard let date = dateFormatter.date(from: s) else {
//            assert(false, "no date from string")
            return NSDate()
        }
        
//        dateFormatter.dateFormat = "yyyy MMM EEEE HH:mm"
//        dateFormatter.timeZone = NSTimeZone(name: "UTC")
        return date
    }
    
    static func timeIntervalFromResult(s:String) -> NSDate {
        
        return NSDate()
    }
    
    func parsedResult() -> QueryResultType {
        var results: [ [String: Any?] ] = []
        
        for row in dataRows {
            var r = [String: Any?]()
            
            for (i, field) in self.fields.enumerated() {
                
                switch field.type {
                case .Bool:
                    switch row[i] as! String {
                    case "t":
                        r[field.field] = true
                        break
                    case "f":
                        r[field.field] = false
                        break
                    default:
                        r[field.field] = nil
                        break
                    }
                case .Int2, .Int4, .Int8:
                    if let stringVal = row[i] as? String {
                        r[field.field] = Int(stringVal)
                    } else {
                        r[field.field] = nil
                    }
                    
                    break
                case .Float4, .Float8:
                    if let stringVal = row[i] as? String {
                        r[field.field] = Float(stringVal)
                    } else {
                        r[field.field] = nil
                    }
                    
                    break
                case .Date:
                    if let stringVal = row[i] as? String {
                        r[field.field] = QueryResult.dateFromResult(s: stringVal)
                    } else {
                        r[field.field] = nil
                    }
                    break
                case .Time, .Timetz, .Abstime:
                    if let stringVal = row[i] as? String {
                        r[field.field] = QueryResult.timeFromResult(s: stringVal)
                    } else {
                        r[field.field] = nil
                    }
                    break
                case .Timestamp, .TimestampTZ:
                    if let stringVal = row[i] as? String {
                        r[field.field] = QueryResult.timeStampFromResult(s: stringVal)
                    } else {
                        r[field.field] = nil
                    }
                    break
                case .Interval:
                    if let stringVal = row[i] as? String {
                        r[field.field] = QueryResult.timeIntervalFromResult(s: stringVal)
                    } else {
                        r[field.field] = nil
                    }
                    break
                case .Varchar, .Text:
                    r[field.field] = row[i]
                    break
                default:
                    r[field.field] = row[i]
                    break
                }
            }

            results.append(r)
        }
        
        return results
    }
}
