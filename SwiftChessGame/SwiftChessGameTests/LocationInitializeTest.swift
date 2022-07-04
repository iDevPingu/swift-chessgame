//
//  LocationInitializeTest.swift
//  SwiftChessGameTests
//
//  Created by pingu.hwang on 2022/06/23.
//

import XCTest
@testable import SwiftChessGame

class LocationInitializeTest: XCTestCase {
    func testCreateLocationWithInt() throws {
        for file in 0..<8 {
            for rank in 0..<8 {
                let location = Location(col: file, row: rank)
                XCTAssertNotNil(location)
            }
        }
        
        let location = Location(col: 8, row: 8)
        XCTAssertNil(location)
    }
    
    func testCreateLocationWithString() throws {
        let aAsciiValue = Int(("A" as UnicodeScalar).value)
        for file in 1...8 {
            for rank in 0..<8 {
                if let rankString = UnicodeScalar(aAsciiValue + rank) {
                    let location = Location(string: "\(rankString)\(file)")
                    XCTAssertNotNil(location)
                }
            }
        }
        
        let location = Location(string: "Z9")
        XCTAssertNil(location)
    }
    
    func testCreateLocationWithTwoDifferentWayIsEqual() {
        var createWithString: [Location?] = []
        var createWithInt: [Location?] = []
        let aAsciiValue = Int(("A" as UnicodeScalar).value)
        
        for file in 1...8 {
            for rank in 0..<8 {
                if let rankString = UnicodeScalar(aAsciiValue + rank) {
                    let location = Location(string: "\(rankString)\(file)")
                    createWithString.append(location)
                }
            }
        }
        
        for file in 0..<8 {
            for rank in 0..<8 {
                let location = Location(col: file, row: rank)
                createWithInt.append(location)
            }
        }
        
        XCTAssertEqual(createWithString, createWithInt)
    }
}
