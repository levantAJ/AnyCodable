//
//  PropertyWrapper.swift
//  AnyCodable
//
//  Created by 이병찬 on 2020/11/06.
//  Copyright © 2020 levantAJ. All rights reserved.
//

import Foundation

@propertyWrapper
public struct CodedAnyArray: Codable {
    public var wrappedValue: [Any]
    
    public init(wrappedValue: [Any]) {
        self.wrappedValue = wrappedValue
    }
    
    public init(from decoder: Decoder) throws {
        var values = try decoder.unkeyedContainer()
        self.wrappedValue = try values.decode([Any].self)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(wrappedValue)
    }
}

@propertyWrapper
public struct CodedAnyDictonary: Codable {
    public var wrappedValue: [String: Any]
    
    public init(wrappedValue: [String: Any]) {
        self.wrappedValue = wrappedValue
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: AnyCodingKey.self)
        self.wrappedValue = try values.decode([String: Any].self)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: AnyCodingKey.self)
        try container.encode(wrappedValue)
    }
}
