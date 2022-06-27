//
//  ChessPieceTest.swift
//  SwiftChessGameTests
//
//  Created by pingu.hwang on 2022/06/27.
//

import XCTest
@testable import SwiftChessGame

class ChessPieceTest: XCTestCase {

    var blackQueen = ChessPieceFactory.create(teamColor: .black, location: Location(string: "E1"), pieceType: .queen)
    var blackRook = ChessPieceFactory.create(teamColor: .black, location: Location(string: "A1"), pieceType: .rook)
    var blackBishop = ChessPieceFactory.create(teamColor: .black, location: Location(string: "C1"), pieceType: .bishop)
    var blackKnight = ChessPieceFactory.create(teamColor: .black, location: Location(string: "B1"), pieceType: .knight)
    var blackPawn = ChessPieceFactory.create(teamColor: .black, location: Location(string: "A2"), pieceType: .pawn)
    
    override func setUp() {
        blackQueen = ChessPieceFactory.create(teamColor: .black, location: Location(string: "E1"), pieceType: .queen)
        blackRook = ChessPieceFactory.create(teamColor: .black, location: Location(string: "A1"), pieceType: .rook)
        blackBishop = ChessPieceFactory.create(teamColor: .black, location: Location(string: "C1"), pieceType: .bishop)
        blackKnight = ChessPieceFactory.create(teamColor: .black, location: Location(string: "B1"), pieceType: .knight)
        blackPawn = ChessPieceFactory.create(teamColor: .black, location: Location(string: "A2"), pieceType: .pawn)
    }
    
    func testBlackRookGetRouteToUp() throws {
        blackRook?.move(to: Location(string: "A5")!)
        let route = blackRook?.getRoute(to: Location(string: "A1"))
        
        XCTAssertEqual(route, [
            Location(string: "A4")!,
            Location(string: "A3")!,
            Location(string: "A2")!,
            Location(string: "A1")!,
        ])
    }
    
    func testBlackRookGetRouteToDown() throws {
        let route = blackRook?.getRoute(to: Location(string: "A5"))
        
        XCTAssertEqual(route, [
            Location(string: "A2")!,
            Location(string: "A3")!,
            Location(string: "A4")!,
            Location(string: "A5")!,
        ])
    }
    
    func testBlackRookGetRouteToLeft() throws {
        blackRook?.move(to: Location(string: "H1")!)
        
        let route = blackRook?.getRoute(to: Location(string: "A1"))
        XCTAssertEqual(route, [
            Location(string: "G1")!,
            Location(string: "F1")!,
            Location(string: "E1")!,
            Location(string: "D1")!,
            Location(string: "C1")!,
            Location(string: "B1")!,
            Location(string: "A1")!,
        ])
    }
    
    func testBlackRookGetRouteToRight() throws {
        let route = blackRook?.getRoute(to: Location(string: "D1"))
        
        XCTAssertEqual(route, [
            Location(string: "B1")!,
            Location(string: "C1")!,
            Location(string: "D1")!,
        ])
    }
    
    func testBlackBishopGetRouteToRightUp() throws {
        blackBishop?.move(to: Location(string: "C7")!)
        let route = blackBishop?.getRoute(to: Location(string: "H2"))
        
        XCTAssertEqual(route, [
            Location(string: "D6")!,
            Location(string: "E5")!,
            Location(string: "F4")!,
            Location(string: "G3")!,
            Location(string: "H2")!,
        ])
    }
    
    func testBlackBishopGetRouteToRightDown() throws {
        let route = blackBishop?.getRoute(to: Location(string: "H6"))
        
        XCTAssertEqual(route, [
            Location(string: "D2")!,
            Location(string: "E3")!,
            Location(string: "F4")!,
            Location(string: "G5")!,
            Location(string: "H6")!,
        ])
    }
    
    func testBlackBishopGetRouteToLeftUp() throws {
        blackBishop?.move(to: Location(string: "H8")!)
        let route = blackBishop?.getRoute(to: Location(string: "A1"))
        
        XCTAssertEqual(route, [
            Location(string: "G7")!,
            Location(string: "F6")!,
            Location(string: "E5")!,
            Location(string: "D4")!,
            Location(string: "C3")!,
            Location(string: "B2")!,
            Location(string: "A1")!,
        ])
    }
    
    func testBlackBishopGetRouteToLeftDown() throws {
        blackBishop?.move(to: Location(string: "A1")!)
        let route = blackBishop?.getRoute(to: Location(string: "H8"))
        
        XCTAssertEqual(route, [
            Location(string: "B2")!,
            Location(string: "C3")!,
            Location(string: "D4")!,
            Location(string: "E5")!,
            Location(string: "F6")!,
            Location(string: "G7")!,
            Location(string: "H8")!,
        ])
    }
    
    func testBlackQueenGetRouteToUp() throws {
        blackQueen?.move(to: Location(string: "A5")!)
        let route = blackQueen?.getRoute(to: Location(string: "A1"))
        
        XCTAssertEqual(route, [
            Location(string: "A4")!,
            Location(string: "A3")!,
            Location(string: "A2")!,
            Location(string: "A1")!,
        ])
    }
    
    func testBlackQueenGetRouteToDown() throws {
        blackQueen?.move(to: Location(string: "A1")!)
        let route = blackQueen?.getRoute(to: Location(string: "A5"))
        
        XCTAssertEqual(route, [
            Location(string: "A2")!,
            Location(string: "A3")!,
            Location(string: "A4")!,
            Location(string: "A5")!,
        ])
    }
    
    func testBlackQueenGetRouteToLeft() throws {
        blackQueen?.move(to: Location(string: "H1")!)
        
        let route = blackQueen?.getRoute(to: Location(string: "A1"))
        XCTAssertEqual(route, [
            Location(string: "G1")!,
            Location(string: "F1")!,
            Location(string: "E1")!,
            Location(string: "D1")!,
            Location(string: "C1")!,
            Location(string: "B1")!,
            Location(string: "A1")!,
        ])
    }
    
    func testBlackQueenGetRouteToRight() throws {
        blackQueen?.move(to: Location(string: "A1")!)
        let route = blackQueen?.getRoute(to: Location(string: "D1"))
        
        XCTAssertEqual(route, [
            Location(string: "B1")!,
            Location(string: "C1")!,
            Location(string: "D1")!,
        ])
    }
    
    func testBlackQueenGetRouteToRightUp() throws {
        blackQueen?.move(to: Location(string: "C7")!)
        let route = blackQueen?.getRoute(to: Location(string: "H2"))
        
        XCTAssertEqual(route, [
            Location(string: "D6")!,
            Location(string: "E5")!,
            Location(string: "F4")!,
            Location(string: "G3")!,
            Location(string: "H2")!,
        ])
    }
    
    func testBlackQueenGetRouteToRightDown() throws {
        blackQueen?.move(to: Location(string: "C1")!)
        let route = blackQueen?.getRoute(to: Location(string: "H6"))
        
        XCTAssertEqual(route, [
            Location(string: "D2")!,
            Location(string: "E3")!,
            Location(string: "F4")!,
            Location(string: "G5")!,
            Location(string: "H6")!,
        ])
    }
    
    func testBlackQueenGetRouteToLeftUp() throws {
        blackQueen?.move(to: Location(string: "H8")!)
        let route = blackQueen?.getRoute(to: Location(string: "A1"))
        
        XCTAssertEqual(route, [
            Location(string: "G7")!,
            Location(string: "F6")!,
            Location(string: "E5")!,
            Location(string: "D4")!,
            Location(string: "C3")!,
            Location(string: "B2")!,
            Location(string: "A1")!,
        ])
    }
    
    func testBlackQueenGetRouteToLeftDown() throws {
        blackQueen?.move(to: Location(string: "A1")!)
        let route = blackQueen?.getRoute(to: Location(string: "H8"))
        
        XCTAssertEqual(route, [
            Location(string: "B2")!,
            Location(string: "C3")!,
            Location(string: "D4")!,
            Location(string: "E5")!,
            Location(string: "F6")!,
            Location(string: "G7")!,
            Location(string: "H8")!,
        ])
    }
    
    func testBlackKnightGetRoute() throws {
        blackKnight?.move(to: Location(string: "D4")!)
        
        let route1 = blackKnight?.getRoute(to: Location(string: "E2"))

        XCTAssertEqual(route1, [
            Location(string: "D3")!,
            Location(string: "E2")!
        ])
        
        let route2 = blackKnight?.getRoute(to: Location(string: "C2"))
        XCTAssertEqual(route2, [
            Location(string: "D3")!,
            Location(string: "C2")!
        ])
        
        let route3 = blackKnight?.getRoute(to: Location(string: "F3"))
        XCTAssertEqual(route3, [
            Location(string: "E4")!,
            Location(string: "F3")!
        ])
        
        let route4 = blackKnight?.getRoute(to: Location(string: "F5"))
        XCTAssertEqual(route4, [
            Location(string: "E4")!,
            Location(string: "F5")!
        ])
        
        let route5 = blackKnight?.getRoute(to: Location(string: "E6"))
        XCTAssertEqual(route5, [
            Location(string: "D5")!,
            Location(string: "E6")!
        ])
        
        let route6 = blackKnight?.getRoute(to: Location(string: "C6"))
        XCTAssertEqual(route6, [
            Location(string: "D5")!,
            Location(string: "C6")!
        ])
        
        let route7 = blackKnight?.getRoute(to: Location(string: "B3"))
        XCTAssertEqual(route7, [
            Location(string: "C4")!,
            Location(string: "B3")!
        ])
        
        let route8 = blackKnight?.getRoute(to: Location(string: "B5"))
        XCTAssertEqual(route8, [
            Location(string: "C4")!,
            Location(string: "B5")!
        ])
    }
    
    func testBlackPawnGetRouteAvailable() throws {
        let route = blackPawn?.getRoute(to: Location(string: "A3"))
        
        XCTAssertEqual(route, [
            Location(string: "A3")!,
        ])
    }
    
    func testBlackPawnGetRouteNotAvailable() throws {
        let route = blackPawn?.getRoute(to: Location(string: "A1"))
        
        XCTAssertEqual(route, [])
    }
}
