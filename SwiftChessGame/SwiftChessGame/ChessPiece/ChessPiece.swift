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
    var currentMoveableLocationInfo: [String] { currentMoveableLocation.map { $0.string }.sorted() }
    var currentMoveableLocation: [Location] {
        var moveableLocation: [Location] = []
        
        switch pieceType {
        case .queen:
            moveableLocation += getAvailableStraigtMove(location: currentLocation)
            moveableLocation += getAvailableDiagonalMove(location: currentLocation)
        case .rook:
            moveableLocation += getAvailableStraigtMove(location: currentLocation)
        case .bishop:
            moveableLocation += getAvailableDiagonalMove(location: currentLocation)
        case .knight:
            moveableLocation += getAvailableknightMove(location: currentLocation)
        case .pawn:
            moveableLocation += getAvailablePawnMove(location: currentLocation, color: teamColor)
        }
        return Array(Set(moveableLocation))
    }
    
    private func getAvailableDiagonalMove(location: Location) -> [Location] {
        let currentPoint = location.current
        var returnValue: [Location] = []
        let directions: [(ud: Int,lr: Int)] = [(-1, -1), (-1, 1), (1, -1), (1, 1)]
        
        for direction in directions {
            for count in 1..<8 {
                if let location = Location(col: currentPoint.file + count * direction.ud, row: currentPoint.rank + count * direction.lr) {
                    returnValue.append(location)
                } else {
                    break
                }
            }
        }

        return returnValue
    }
    
    private func getAvailableStraigtMove(location: Location) -> [Location] {
        let currentPoint = location.current
        var returnValue: [Location] = []
        let directions: [(ud: Int, lr: Int)] = [(-1, 0), (1, 0), (0, -1), (0, 1)]
        
        for direction in directions {
            for count in 1..<8 {
                if let location = Location(col: currentPoint.file + count * direction.ud, row: currentPoint.rank + count * direction.lr) {
                    returnValue.append(location)
                } else {
                    break
                }
            }
        }
        return returnValue
    }
    
    private func getAvailableknightMove(location: Location) -> [Location] {
        let currentPoint = location.current
        var returnValue: [Location] = []
        let directions: [(ud: Int, lr: Int)] = [(-2, -1), (-2, 1), (-1, 2), (1, 2), (2, -1), (2, 1), (-1, -2), (1, -2)]
        
        for direction in directions {
            if let location = Location(col: currentPoint.file + direction.ud, row: currentPoint.rank + direction.lr) {
                returnValue.append(location)
            }
        }
        
        return returnValue
    }
    
    private func getAvailablePawnMove(location: Location, color: TeamColor) -> [Location] {
        let currentPoint = location.current
        
        let newFile = currentPoint.file + (color == .black ? 1 : -1)
        if let location = Location(col: newFile, row: currentPoint.rank) {
            return [location]
        }
        
        return []
    }
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
