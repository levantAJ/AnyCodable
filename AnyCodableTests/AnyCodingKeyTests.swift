//
//  AnyCodingKeyTests.swift
//  AnyDecodableTests
//
//  Created by ShopBack on 1/18/19.
//  Copyright © 2019 levantAJ. All rights reserved.
//

import XCTest
@testable import AnyCodable

class AnyCodingKeyTests: XCTestCase {
    var sut: AnyCodingKey!

    func testInitStringValue() {
        sut = AnyCodingKey(stringValue: "Hello")
        XCTAssertEqual(sut.stringValue, "Hello")
        XCTAssertNil(sut.intValue)
    }

    func testInitIntValue() {
        sut = AnyCodingKey(intValue: 123)
        XCTAssertEqual(sut.stringValue, "123")
        XCTAssertEqual(sut.intValue, 123)
    }

}
