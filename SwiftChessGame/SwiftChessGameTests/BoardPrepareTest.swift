//
//  BoardPrepareTest.swift
//  SwiftChessGameTests
//
//  Created by pingu.hwang on 2022/06/23.
//

import XCTest
@testable import SwiftChessGame

class BoardPrepareTest: XCTestCase {

    let board = Board()
    
    func testBoardScore() throws {
        let initScore = 9 + 10 + 6 + 6 + 8
        
        XCTAssertEqual(initScore, board.whiteTeamScore)
        XCTAssertEqual(initScore, board.blackTeamScore)
    }

    func testBoardDisplay() throws {
        let displayText = """
        ♜♞♝.♛♝♞♜
        ♟♟♟♟♟♟♟♟
        ........
        ........
        ........
        ........
        ♙♙♙♙♙♙♙♙
        ♖♘♗.♕♗♘♖
        """
        
        XCTAssertEqual(board.display().joined(separator: "\n"), displayText)
    }
}
