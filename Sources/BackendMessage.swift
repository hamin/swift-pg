//
//  BackendMessage.swift
//  swift-pg
//
//  Created by Haris Amin on 7/4/16.
//
//

import Foundation

public enum BackendMessageType: String {
    case Authentication = "R"
    case RowDescription = "T"
}

struct BackendMessage {
    
    init(type: BackendMessageType) {
        
    }
}