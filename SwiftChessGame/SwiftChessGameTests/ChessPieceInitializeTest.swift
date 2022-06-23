//
//  ChessPieceInitializeTest.swift
//  SwiftChessGameTests
//
//  Created by pingu.hwang on 2022/06/20.
//

import XCTest
@testable import SwiftChessGame

class ChessPieceInitializeTest: XCTestCase {
    
    func testWhiteQueenCreate() {
        let createSuccessWhiteQueen = ChessPieceFactory.create(teamColor: .white, location: .init(string: "E8"), pieceType: .queen)
        let createFailWhiteQueen = ChessPieceFactory.create(teamColor: .white, location: .init(string: "A8"), pieceType: .queen)
        
        XCTAssertNotNil(createSuccessWhiteQueen)
        XCTAssertNil(createFailWhiteQueen)
    }
    
    func testWhiteRookCreate() {
        let createSuccessWhiteRook1 = ChessPieceFactory.create(teamColor: .white, location: .init(string: "A8"), pieceType: .rook)
        let createSuccessWhiteRook2 = ChessPieceFactory.create(teamColor: .white, location: .init(string: "H8"), pieceType: .rook)
        let createFailWhiteRook = ChessPieceFactory.create(teamColor: .white, location: .init(string: "A2"), pieceType: .rook)
        
        XCTAssertNotNil(createSuccessWhiteRook1)
        XCTAssertNotNil(createSuccessWhiteRook2)
        XCTAssertNil(createFailWhiteRook)
    }
    
    func testWhiteKnightCreate() {
        let createSuccessWhiteKnight1 = ChessPieceFactory.create(teamColor: .white, location: .init(string: "B8"), pieceType: .knight)
        let createSuccessWhiteKnight2 = ChessPieceFactory.create(teamColor: .white, location: .init(string: "G8"), pieceType: .knight)
        let createFailWhiteKnight = ChessPieceFactory.create(teamColor: .white, location: .init(string: "A2"), pieceType: .knight)
        
        XCTAssertNotNil(createSuccessWhiteKnight1)
        XCTAssertNotNil(createSuccessWhiteKnight2)
        XCTAssertNil(createFailWhiteKnight)
    }
    
    func testWhiteBishopCreate() {
        let createSuccessWhiteBishop1 = ChessPieceFactory.create(teamColor: .white, location: .init(string: "C8"), pieceType: .bishop)
        let createSuccessWhiteBishop2 = ChessPieceFactory.create(teamColor: .white, location: .init(string: "F8"), pieceType: .bishop)
        let createFailWhiteBishop = ChessPieceFactory.create(teamColor: .white, location: .init(string: "A2"), pieceType: .bishop)
        
        XCTAssertNotNil(createSuccessWhiteBishop1)
        XCTAssertNotNil(createSuccessWhiteBishop2)
        XCTAssertNil(createFailWhiteBishop)
    }
    
    func testWhitePawnCreate() {
        for rank in 0..<8 {
            let createSuccessWhitePawn = ChessPieceFactory.create(teamColor: .white, location: .init(col: 6, row: rank), pieceType: .pawn)
            XCTAssertNotNil(createSuccessWhitePawn)
        }
        
        for rank in 0..<8 {
            let createFailWhitePawn = ChessPieceFactory.create(teamColor: .white, location: .init(col: 5, row: rank), pieceType: .pawn)
            XCTAssertNil(createFailWhitePawn)
        }
    }
    
    func testBlackQueenCreate() {
        let createSuccessBlackQueen = ChessPieceFactory.create(teamColor: .black, location: .init(string: "E1"), pieceType: .queen)
        let createFailBlackQueen = ChessPieceFactory.create(teamColor: .black, location: .init(string: "A1"), pieceType: .queen)
        
        XCTAssertNotNil(createSuccessBlackQueen)
        XCTAssertNil(createFailBlackQueen)
    }
    
    func testBlackRookCreate() {
        let createSuccessBlackRook1 = ChessPieceFactory.create(teamColor: .black, location: .init(string: "A1"), pieceType: .rook)
        let createSuccessBlackRook2 = ChessPieceFactory.create(teamColor: .black, location: .init(string: "H1"), pieceType: .rook)
        let createFailBlackRook = ChessPieceFactory.create(teamColor: .black, location: .init(string: "A2"), pieceType: .rook)
        
        XCTAssertNotNil(createSuccessBlackRook1)
        XCTAssertNotNil(createSuccessBlackRook2)
        XCTAssertNil(createFailBlackRook)
    }
    
    func testBlackKnightCreate() {
        let createSuccessBlackKnight1 = ChessPieceFactory.create(teamColor: .black, location: .init(string: "B1"), pieceType: .knight)
        let createSuccessBlackKnight2 = ChessPieceFactory.create(teamColor: .black, location: .init(string: "G1"), pieceType: .knight)
        let createFailBlackKnight = ChessPieceFactory.create(teamColor: .black, location: .init(string: "A2"), pieceType: .knight)
        
        XCTAssertNotNil(createSuccessBlackKnight1)
        XCTAssertNotNil(createSuccessBlackKnight2)
        XCTAssertNil(createFailBlackKnight)
    }
    
    func testBlackBishopCreate() {
        let createSuccessBlackBishop1 = ChessPieceFactory.create(teamColor: .black, location: .init(string: "C1"), pieceType: .bishop)
        let createSuccessBlackBishop2 = ChessPieceFactory.create(teamColor: .black, location: .init(string: "F1"), pieceType: .bishop)
        let createFailBlackBishop = ChessPieceFactory.create(teamColor: .black, location: .init(string: "A2"), pieceType: .bishop)
        
        XCTAssertNotNil(createSuccessBlackBishop1)
        XCTAssertNotNil(createSuccessBlackBishop2)
        XCTAssertNil(createFailBlackBishop)
    }
    
    func testBlackPawnCreate() {
        for rank in 0..<8 {
            let createSuccessBlackPawn = ChessPieceFactory.create(teamColor: .black, location: .init(col: 1, row: rank), pieceType: .pawn)
            XCTAssertNotNil(createSuccessBlackPawn)
        }
        
        for rank in 0..<8 {
            let createFailBlackPawn = ChessPieceFactory.create(teamColor: .black, location: .init(col: 2, row: rank), pieceType: .pawn)
            XCTAssertNil(createFailBlackPawn)
        }
    }
}
