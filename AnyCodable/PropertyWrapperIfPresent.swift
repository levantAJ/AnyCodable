//
//  PropertyWrapperIfPresent.swift
//  AnyCodable
//
//  Created by 이병찬 on 2020/11/06.
//  Copyright © 2020 levantAJ. All rights reserved.
//

import Foundation

@propertyWrapper
public struct CodedIfPresentAnyArray: Codable {
    public var wrappedValue: [Any]?
    
    public init(wrappedValue: [Any]?) {
        self.wrappedValue = wrappedValue
    }
    
    public init(from decoder: Decoder) throws {
        if var values = try? decoder.unkeyedContainer() {
            self.wrappedValue = try values.decode([Any].self)
        } else {
            self.wrappedValue = nil
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        if let value = wrappedValue {
            var container = encoder.unkeyedContainer()
            try container.encode(value)
        } else {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
        }
    }
}

@propertyWrapper
public struct CodedIfPresentAnyDictonary: Codable {
    public var wrappedValue: [String: Any]?
    
    public init(wrappedValue: [String: Any]?) {
        self.wrappedValue = wrappedValue
    }
    
    public init(from decoder: Decoder) throws {
        if let values = try? decoder.container(keyedBy: AnyCodingKey.self) {
            self.wrappedValue = try values.decode([String: Any].self)
        } else {
            self.wrappedValue = nil
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        if let value = wrappedValue {
            var container = encoder.container(keyedBy: AnyCodingKey.self)
            try container.encode(value)
        } else {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
        }
    }
}
