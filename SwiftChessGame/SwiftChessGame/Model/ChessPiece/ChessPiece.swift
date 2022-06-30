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

enum TeamColor: String {
    case white = "White"
    case black = "Black"
}

protocol ChessPiece: AnyObject {
    var teamColor: TeamColor { get set }
    var currentLocation: Location { get set }
    var pieceType: PieceType { get }
    
    init?(teamColor: TeamColor, at: Location?)
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
    
    func createAvailable() -> Bool {
        var returnValue: Bool
        switch pieceType {
        case .queen:
            if teamColor == .black {
                returnValue = currentLocation.string == "E1"
            } else {
                returnValue = currentLocation.string == "E8"
            }
        case .rook:
            if teamColor == .black {
                returnValue = currentLocation.string == "A1" || currentLocation.string == "H1"
            } else {
                returnValue = currentLocation.string == "A8" || currentLocation.string == "H8"
            }
        case .knight:
            if teamColor == .black {
                returnValue = currentLocation.string == "B1" || currentLocation.string == "G1"
            } else {
                returnValue = currentLocation.string == "B8" || currentLocation.string == "G8"
            }
        case .bishop:
            if teamColor == .black {
                returnValue = currentLocation.string == "C1" || currentLocation.string == "F1"
            } else {
                returnValue = currentLocation.string == "C8" || currentLocation.string == "F8"
            }
        case .pawn:
            if teamColor == .black {
                returnValue = currentLocation.boardIndex.file == 1 && Array(0...7).contains(currentLocation.boardIndex.rank)
            } else {
                returnValue = currentLocation.boardIndex.file == 6 && Array(0...7).contains(currentLocation.boardIndex.rank)
            }
        }

        return returnValue
    }
    
    private func getAvailableDiagonalMove(location: Location) -> [Location] {
        let currentPoint = location.boardIndex
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
        let currentPoint = location.boardIndex
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
        let currentPoint = location.boardIndex
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
        let currentPoint = location.boardIndex
        
        let newFile = currentPoint.file + (color == .black ? 1 : -1)
        if let location = Location(col: newFile, row: currentPoint.rank) {
            return [location]
        }
        
        return []
    }
}

// For Moving
extension ChessPiece {
    func move(to: Location) {
        currentLocation = to
    }
    
    func getRoute(to: Location?) -> [Location] {
        guard let to = to else { return [] }
        guard currentMoveableLocation.contains(to) else { return [] }

        switch pieceType {
        case .queen:
            if currentLocation.rank != to.rank && currentLocation.file != to.file {
                return getDiagonalRoute(to: to)
            } else {
                return getStraightRoute(to: to)
            }
        case .rook:
            return getStraightRoute(to: to)
        case .bishop:
            return getDiagonalRoute(to: to)
        case .knight:
            return getKnightRoute(to: to)
        case .pawn:
            return [to]
        }
    }
    
    private func getStraightRoute(to: Location) -> [Location] {
        var returnValue: [Location] = []
        let currentPoint = currentLocation.boardIndex
        if currentLocation.rank == to.rank {
            let isGoDown: Bool = currentLocation.file < to.file
            for count in 1..<8 {
                if let location = Location(col: currentPoint.file + (count * (isGoDown ? 1 : -1)), row: currentPoint.rank) {
                    returnValue.append(location)
                    
                    if location == to {
                        break
                    }
                }
            }
        } else if currentLocation.file == to.file {
            let isGoRight: Bool = currentLocation.rank < to.rank
            for count in 1..<8 {
                if let location = Location(col: currentPoint.file, row: currentPoint.rank + (count * (isGoRight ? 1 : -1))) {
                    returnValue.append(location)
                    
                    if location == to {
                        break
                    }
                }
            }
        }
        return returnValue
    }
    
    private func getDiagonalRoute(to: Location) -> [Location] {
        var returnValue: [Location] = []
        let currentPoint = currentLocation.boardIndex
        let direction: (file: Int, rank: Int)
        
        if currentLocation.rank < to.rank && currentLocation.file < to.file {
            // 오른쪽 아래
            direction = (1, 1)
        } else if currentLocation.rank > to.rank && currentLocation.file < to.file {
            // 왼쪽 아래
            direction = (1, -1)
        } else if currentLocation.rank < to.rank && currentLocation.file > to.file {
            // 오른쪽 위
            direction = (-1, 1)
        } else {
            // 왼쪽 위
            direction = (-1, -1)
        }
        
        for count in 1..<8 {
            if let location = Location(col: currentPoint.file + direction.file * count,
                                       row: currentPoint.rank + direction.rank * count) {
                returnValue.append(location)
                if location == to {
                    break
                }
            }
        }
        
        return returnValue
    }
    
    private func getKnightRoute(to: Location) -> [Location] {
        var returnValue: [Location] = []
        let currentPoint = currentLocation.boardIndex
        let toPoint = to.boardIndex
        
        if currentPoint.file - toPoint.file == 2 {
            if let location = Location(col: currentPoint.file - 1, row: currentPoint.rank) {
                returnValue.append(location)
            }
        } else if currentPoint.file - toPoint.file == -2 {
            if let location = Location(col: currentPoint.file + 1, row: currentPoint.rank) {
                returnValue.append(location)
            }
        } else if currentPoint.rank - toPoint.rank == 2 {
            if let location = Location(col: currentPoint.file, row: currentPoint.rank - 1) {
                returnValue.append(location)
            }
        } else if currentPoint.rank - toPoint.rank == -2 {
            if let location = Location(col: currentPoint.file, row: currentPoint.rank + 1) {
                returnValue.append(location)
            }
        }
          
        returnValue.append(to)
        
        return returnValue
    }
}

struct ChessPieceFactory {
    static func create(teamColor: TeamColor, location: Location?, pieceType: PieceType) -> ChessPiece? {
        switch pieceType {
        case .queen:
            return Queen(teamColor: teamColor, at: location)
        case .rook:
            return Rook(teamColor: teamColor, at: location)
        case .bishop:
            return Bishop(teamColor: teamColor, at: location)
        case .knight:
            return Knight(teamColor: teamColor, at: location)
        case .pawn:
            return Pawn(teamColor: teamColor, at: location)
        }
    }
}
