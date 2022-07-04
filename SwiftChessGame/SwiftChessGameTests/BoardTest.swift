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
    
    func testBoardMoveSuccess() throws {
        try? board.move(from: Location(string: "A2"), to: Location(string: "A3"))
        XCTAssertNotNil(board.chessPiece(at: Location(string: "A3")))
    }
    
    func testBoardMoveFailWithEmptyLocationError() throws {
        do {
            try board.move(from: Location(string: "A3"), to: Location(string: "A4"))
        } catch {
            if let error = error as? BoardError {
                XCTAssertEqual(error, .emptyLocation)
            }
        }
    }
    
    func testBoardMoveFailWithEqualTeamError() throws {
        do {
            try board.move(from: Location(string: "A1"), to: Location(string: "A2"))
        } catch {
            if let error = error as? BoardError {
                XCTAssertEqual(error, .moveToEqualTeamLocation)
            }
        }
    }
    
    func testBoardMoveFailWithNotAvailableLocation() throws {
        do {
            try board.move(from: Location(string: "A1"), to: Location(string: "C2"))
        } catch {
            if let error = error as? BoardError {
                XCTAssertEqual(error, .notAvailableLocation)
            }
        }
    }
    
    func testBoardMoveFailWithNotChessPieceInTheRoute() throws {
        do {
            try board.move(from: Location(string: "A1"), to: Location(string: "A3"))
        } catch {
            if let error = error as? BoardError {
                XCTAssertEqual(error, .chessPieceInTheRoute)
            }
        }
    }
    
    func testBoardMoveToOtherTeam() throws {
        try? board.move(from: Location(string: "A2"), to: Location(string: "A3"))
        try? board.move(from: Location(string: "A3"), to: Location(string: "A4"))
        try? board.move(from: Location(string: "A4"), to: Location(string: "A5"))
        try? board.move(from: Location(string: "A5"), to: Location(string: "A6"))
        try? board.move(from: Location(string: "A6"), to: Location(string: "A7"))
        
        XCTAssertEqual(board.blackTeamScore - 1, board.whiteTeamScore)
    }
}
