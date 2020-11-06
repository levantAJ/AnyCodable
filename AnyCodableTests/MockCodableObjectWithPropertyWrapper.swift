//
//  MockCodableObjectWithPropertyWrapper.swift
//  AnyCodableTests
//
//  Created by 이병찬 on 2020/11/06.
//  Copyright © 2020 levantAJ. All rights reserved.
//

import Foundation
@testable import AnyCodable

struct MockCodableObjectWithPropertyWrapper: Codable {
    @CodedAnyDictonary private(set) var dict: [String: Any]
    @CodedAnyArray private(set) var array: [Any]
    
    init(dict: [String: Any], array: [Any]) {
        self.dict = dict
        self.array = array
    }
}
