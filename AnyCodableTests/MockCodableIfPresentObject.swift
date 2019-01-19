//
//  MockCodableIfPresentObject.swift
//  AnyDecodableTests
//
//  Created by ShopBack on 1/19/19.
//  Copyright © 2019 levantAJ. All rights reserved.
//

import Foundation

struct MockCodableIfPresentObject: Codable {
    var dict: [String: Any]?
    var array: [Any]?

    init(dict: [String: Any]?, array: [Any]?) {
        self.dict = dict
        self.array = array
    }

    enum CodingKeys: String, CodingKey {
        case dict
        case array
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        dict = try values.decodeIfPresent([String: Any].self, forKey: .dict)
        array = try values.decodeIfPresent([Any].self, forKey: .array)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(dict, forKey: .dict)
        try container.encodeIfPresent(array, forKey: .array)
    }
}
