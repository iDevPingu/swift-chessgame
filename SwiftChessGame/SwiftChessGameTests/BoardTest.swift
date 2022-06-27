//
//  BoardTest.swift
//  SwiftChessGameTests
//
//  Created by pingu.hwang on 2022/06/27.
//

import XCTest
@testable import SwiftChessGame

class BoardTest: XCTestCase {

    let board = Board()
    
    func testBoardChessPieceMethodSuccess() throws {
        let location = Location(string: "A5")
        let queen = ChessPieceFactory.create(teamColor: .black, location: location, pieceType: .queen)
        
        XCTAssertEqual(queen?.pieceType, board.chessPiece(at: location)?.pieceType)
        XCTAssertEqual(queen?.currentLocation, board.chessPiece(at: location)?.currentLocation)
    }
    
    func testBoardChessPieceMethodFail() throws {
        let location = Location(string: "A9")
        
        XCTAssertNil(board.chessPiece(at: location))
    }
}
