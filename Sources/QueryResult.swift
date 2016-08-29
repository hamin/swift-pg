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

    static let PGDateFormatter: DateFormatter = DateFormatter()

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

    static func timeStampFromResult(s:String) -> NSDate? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSX"
//        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)

        guard let date = dateFormatter.date(from: s) else {
            return nil
        }
        return date as NSDate
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
                        if let tzResult = QueryResult.timeStampFromResult(s: stringVal) {
                            r[field.field] = tzResult
                        } else {
                            r[field.field] = stringVal
                        }
                        print(r[field.field])
                        
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
