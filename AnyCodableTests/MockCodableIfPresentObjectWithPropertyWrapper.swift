//
//  MockCodableIfPresentObjectWithPropertyWrapper.swift
//  AnyCodableTests
//
//  Created by 이병찬 on 2020/11/06.
//  Copyright © 2020 levantAJ. All rights reserved.
//

import Foundation
@testable import AnyCodable

struct MockCodableIfPresentObjectWithPropertyWrapper: Codable {
    @CodedIfPresentAnyDictonary var dict: [String: Any]?
    @CodedIfPresentAnyArray var array: [Any]?
    
    init(dict: [String: Any]?, array: [Any]?) {
        self.dict = dict
        self.array = array
    }
}
