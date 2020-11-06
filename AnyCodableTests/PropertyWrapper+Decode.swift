//
//  PropertyWrapper+Decode.swift
//  AnyCodableTests
//
//  Created by 이병찬 on 2020/11/06.
//  Copyright © 2020 levantAJ. All rights reserved.
//

import XCTest

class PropertyWrapper_DecodeTests: XCTestCase {
    func testDecodeDict() {
        let data = """
        {"dict": {"int": 123, "string": "string", "bool": true, "double": 873.436, "null":null, "array": [1, 2, 3, 4], "dict": {"string": "ok lah", "null": null}}, "array": [1, null, false, "string", 345.2346, ["1", "2", "4"], {"key": null}]}
        """.data(using: .utf8)!

        var sut: MockCodableObjectWithPropertyWrapper!
        XCTAssertNoThrow(sut = try JSONDecoder().decode(MockCodableObjectWithPropertyWrapper.self, from: data))
        XCTAssertEqual(sut.dict["int"] as? Int, 123)
        XCTAssertEqual(sut.dict["string"] as? String, "string")
        XCTAssertEqual(sut.dict["bool"] as? Bool, true)
        XCTAssertEqual(sut.dict["double"] as? Double, 873.436)
        XCTAssertTrue(sut.dict["null"] is NSNull)
        XCTAssertEqual(sut.dict["array"] as? [Int], [1, 2, 3, 4])
        XCTAssertEqual((sut.dict["dict"] as? [String: Any])?["string"] as? String, "ok lah")
        XCTAssertEqual((sut.dict["dict"] as? [String: Any])?["null"] is NSNull, true)

        let array = sut.array
        XCTAssertNotNil(array)
        XCTAssertEqual(array.count, 7)
        XCTAssertTrue(array.contains { $0 is NSNull })
        XCTAssertTrue(array.contains { $0 as? Int == 1 })
        XCTAssertTrue(array.contains { $0 as? String == "string" })
        XCTAssertTrue(array.contains { $0 as? Bool == false })
        XCTAssertTrue(array.contains { $0 as? Double == 345.2346 })
        XCTAssertTrue(array.contains { $0 as? [String] == ["1", "2", "4"] })
        XCTAssertTrue(array.contains(where: { dict -> Bool in
            let dict = dict as? [String: Any]
            return dict?["key"] is NSNull
        }))
    }

    func testDecodeDictContainsDict() {
        let data = """
        {"dict": {"nestedDict": {"array":[123, null, true, 456.789, "string", [1, 2, 3], {"string":"string", "int": 456, "array": ["9", "8", "7"]}]}}, "array": [1, null, false, "string", 345.2346, ["1", "2", "4"], {"key": null}]}
""".data(using: .utf8)!
        var sut: MockCodableObjectWithPropertyWrapper!
        XCTAssertNoThrow(sut = try JSONDecoder().decode(MockCodableObjectWithPropertyWrapper.self, from: data))
        let nestedDict = sut.dict["nestedDict"] as? [String: Any]
        let nestedArray = nestedDict?["array"] as? [Any] ?? []
        XCTAssertEqual(nestedArray.count, 7)
        XCTAssertTrue(nestedArray.contains { $0 is NSNull })
        XCTAssertTrue(nestedArray.contains { $0 as? Int == 123 })
        XCTAssertTrue(nestedArray.contains { $0 as? String == "string" })
        XCTAssertTrue(nestedArray.contains { $0 as? Bool == true })
        XCTAssertTrue(nestedArray.contains { $0 as? Double == 456.789 })
        XCTAssertTrue(nestedArray.contains { $0 as? [Int] == [1, 2, 3] })
        XCTAssertTrue(nestedArray.contains(where: { dict -> Bool in
            let dict = dict as? [String: Any]
            return dict?["string"] as? String == "string"
                && dict?["int"] as? Int == 456
                && dict?["array"] as? [String] == ["9", "8", "7"]
        }))

        let array = sut.array
        XCTAssertNotNil(array)
        XCTAssertEqual(array.count, 7)
        XCTAssertTrue(array.contains { $0 is NSNull })
        XCTAssertTrue(array.contains { $0 as? Int == 1 })
        XCTAssertTrue(array.contains { $0 as? String == "string" })
        XCTAssertTrue(array.contains { $0 as? Bool == false })
        XCTAssertTrue(array.contains { $0 as? Double == 345.2346 })
        XCTAssertTrue(array.contains { $0 as? [String] == ["1", "2", "4"] })
        XCTAssertTrue(array.contains(where: { dict -> Bool in
            let dict = dict as? [String: Any]
            return dict?["key"] is NSNull
        }))
    }

    func testDecodeDictContainsArray() {
        let data = """
        {"dict": {"array": [123, null, true, 456.789, "string", [1, 2, 3], {"string":"string", "int": 456, "array": ["9", "8", "7"]}]}, "array": [1, null, false, "string", 345.2346, ["1", "2", "4"], {"key": null}]}
""".data(using: .utf8)!
        var sut: MockCodableObjectWithPropertyWrapper!
        XCTAssertNoThrow(sut = try JSONDecoder().decode(MockCodableObjectWithPropertyWrapper.self, from: data))
        let nestedArray = sut.dict["array"] as? [Any] ?? []
        XCTAssertEqual(nestedArray.count, 7)
        XCTAssertTrue(nestedArray.contains { $0 is NSNull })
        XCTAssertTrue(nestedArray.contains { $0 as? Int == 123 })
        XCTAssertTrue(nestedArray.contains { $0 as? String == "string" })
        XCTAssertTrue(nestedArray.contains { $0 as? Bool == true })
        XCTAssertTrue(nestedArray.contains { $0 as? Double == 456.789 })
        XCTAssertTrue(nestedArray.contains { $0 as? [Int] == [1, 2, 3] })
        XCTAssertTrue(nestedArray.contains(where: { dict -> Bool in
            let dict = dict as? [String: Any]
            return dict?["string"] as? String == "string"
                && dict?["int"] as? Int == 456
                && dict?["array"] as? [String] == ["9", "8", "7"]
        }))

        let array = sut.array
        XCTAssertNotNil(array)
        XCTAssertEqual(array.count, 7)
        XCTAssertTrue(array.contains { $0 is NSNull })
        XCTAssertTrue(array.contains { $0 as? Int == 1 })
        XCTAssertTrue(array.contains { $0 as? String == "string" })
        XCTAssertTrue(array.contains { $0 as? Bool == false })
        XCTAssertTrue(array.contains { $0 as? Double == 345.2346 })
        XCTAssertTrue(array.contains { $0 as? [String] == ["1", "2", "4"] })
        XCTAssertTrue(array.contains(where: { dict -> Bool in
            let dict = dict as? [String: Any]
            return dict?["key"] is NSNull
        }))
    }

    func testDecodeIfPresentDict() {
        let data = """
{"dict": {"int": 123, "string": "cool", "bool": true, "double": 873.436, "null": null, "array": [1, 2, 3, 4], "dict": {"string": "ok lah", "null": null}}, \"array\": null}
""".data(using: .utf8)!
        
        var sut: MockCodableIfPresentObjectWithPropertyWrapper!
        XCTAssertNoThrow(sut = try JSONDecoder().decode(MockCodableIfPresentObjectWithPropertyWrapper.self, from: data))
        XCTAssertEqual(sut.dict?["int"] as? Int, 123)
        XCTAssertEqual(sut.dict?["string"] as? String, "cool")
        XCTAssertEqual(sut.dict?["bool"] as? Bool, true)
        XCTAssertEqual(sut.dict?["double"] as? Double, 873.436)
        XCTAssertTrue(sut.dict?["null"] is NSNull)
        XCTAssertEqual(sut.dict?["array"] as? [Int], [1, 2, 3, 4])
        XCTAssertEqual((sut.dict?["dict"] as? [String: Any])?["string"] as? String, "ok lah")
    }

    func testDecodeIfPresentDictIsNull() {
        let data = "{\"dict\": null, \"array\": null}".data(using: .utf8)!
        var sut: MockCodableIfPresentObjectWithPropertyWrapper!
        XCTAssertNoThrow(sut = try JSONDecoder().decode(MockCodableIfPresentObjectWithPropertyWrapper.self, from: data))
        XCTAssertNil(sut.dict)
        XCTAssertNil(sut.array)
    }

    func testDecodeIfPresentArray() {
        let data = """
{\"array\": [123, null, true, 456.789, "string", [1, 2, 3], {"string":"string", "int": 456, "array": ["9", "8", "7"]}], \"dict\": null}
""".data(using: .utf8)!
        
        var sut: MockCodableIfPresentObjectWithPropertyWrapper!
        XCTAssertNoThrow(sut = try JSONDecoder().decode(MockCodableIfPresentObjectWithPropertyWrapper.self, from: data))
        let array = sut.array
        XCTAssertEqual(array?.count, 7)
        XCTAssertEqual(array?.contains { $0 is NSNull }, true)
        XCTAssertEqual(array?.contains { $0 as? Int == 123 }, true)
        XCTAssertEqual(array?.contains { $0 as? String == "string" }, true)
        XCTAssertEqual(array?.contains { $0 as? Bool == true }, true)
        XCTAssertEqual(array?.contains { $0 as? Double == 456.789 }, true)
        XCTAssertEqual(array?.contains { $0 as? [Int] == [1, 2, 3] }, true)
        XCTAssertEqual(array?.contains(where: { dict -> Bool in
            let dict = dict as? [String: Any]
            return dict?["string"] as? String == "string"
                && dict?["int"] as? Int == 456
                && dict?["array"] as? [String] == ["9", "8", "7"]
        }), true)
    }
}
