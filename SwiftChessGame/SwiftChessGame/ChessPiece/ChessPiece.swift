//
//  ChessPiece.swift
//  SwiftChessGame
//
//  Created by pingu.hwang on 2022/06/20.
//

import Foundation

enum PieceType {
//    case king
    case queen
    case rook
    case bishop
    case knight
    case pawn
    
    func getString(teamColor: TeamColor) -> String {
        switch self {
//        case .king:
//            return "."
        case .queen:
            if teamColor == .black {
                return "♛"
            } else {
                return "♕"
            }
        case .rook:
            if teamColor == .black {
                return "♜"
            } else {
                return "♖"
            }
        case .bishop:
            if teamColor == .black {
                return "♝"
            } else {
                return "♗"
            }
        case .knight:
            if teamColor == .black {
                return "♞"
            } else {
                return "♘"
            }
        case .pawn:
            if teamColor == .black {
                return "♟"
            } else {
                return "♙"
            }
        }
    }
    
    var score: Int {
        switch self {
        case .queen:
            return 9
        case .rook:
            return 5
        case .bishop, .knight:
            return 3
        case .pawn:
            return 1
        }
    }
}

enum TeamColor {
    case white
    case black
}

protocol ChessPiece {
    var teamColor: TeamColor { get set }
    var currentLocation: Location { get set }
    var pieceType: PieceType { get }
    
    init(teamColor: TeamColor, currentLocation: Location)
}

extension ChessPiece {
    var score: Int { pieceType.score }
    var currentMoveableLocation: [Location] { currentLocation.moveAvailable(pieceType: pieceType) }
}

struct ChessPieceFactory {
    static func create(teamColor: TeamColor, location: Location, pieceType: PieceType) -> ChessPiece {
        switch pieceType {
        case .queen:
            return Queen(teamColor: teamColor, currentLocation: location)
        case .rook:
            return Rook(teamColor: teamColor, currentLocation: location)
        case .bishop:
            return Bishop(teamColor: teamColor, currentLocation: location)
        case .knight:
            return Knight(teamColor: teamColor, currentLocation: location)
        case .pawn:
            return Pawn(teamColor: teamColor, currentLocation: location)
        }
    }
}
