//
//  QueryResult.swift
//  swift-pg
//
//  Created by Haris Amin on 7/11/16.
//
//

import Foundation

public typealias QueryResultType = [ [String: Any?] ]

public struct QueryResult {
    var fields: [FieldInfo] = []
    var dataRows: [[Any?]] = []
    var isCommandComplete: Bool = false
    var isReadyForQUery: Bool = false
    
    init(messages: [BackendMessage]) {
        
        for msg in messages {
            switch msg.messageType {
            case .RowDescription:
                self.fields = msg.parsedResult as! [FieldInfo]
                break
            case .DataRow:
//                self.dataRows = msg.parsedResult as! [[Any?]]
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
                case .Int4, .Int8:
                    if let stringVal = row[i] as? String {
                        r[field.field] = Int(stringVal)
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