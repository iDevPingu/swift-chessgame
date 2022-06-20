//
//  Board.swift
//  SwiftChessGame
//
//  Created by pingu.hwang on 2022/06/20.
//

import Foundation

final class Board {
    var current: [[ChessPiece?]]
    private var currentTurn: TeamColor = .black
    
    init() {
        current = [[ChessPiece?]](repeating: [ChessPiece?](repeating: nil, count: 8), count: 8)
        setBlackPieces()
        setWhitePieces()
        print("체스 보드를 초기화했습니다.")
        print(display)
    }
    
    private func setBlackPieces() {
        var blackPawnRow: [ChessPiece?] = []
        for file in 0..<8 {
            guard let location = Location(col: file, row: 1) else { continue }
            blackPawnRow.append(ChessPieceFactory.create(teamColor: .black, location: location, pieceType: .pawn))
        }
        current[1] = blackPawnRow
        
        var blackQueenRow: [ChessPiece?] = []
        blackQueenRow.append(ChessPieceFactory.create(teamColor: .black, location: Location(col: 0, row: 0)!, pieceType: .rook))
        blackQueenRow.append(ChessPieceFactory.create(teamColor: .black, location: Location(col: 0, row: 1)!, pieceType: .knight))
        blackQueenRow.append(ChessPieceFactory.create(teamColor: .black, location: Location(col: 0, row: 2)!, pieceType: .bishop))
        blackQueenRow.append(nil)
        blackQueenRow.append(ChessPieceFactory.create(teamColor: .black, location: Location(col: 0, row: 4)!, pieceType: .queen))
        blackQueenRow.append(ChessPieceFactory.create(teamColor: .black, location: Location(col: 0, row: 5)!, pieceType: .bishop))
        blackQueenRow.append(ChessPieceFactory.create(teamColor: .black, location: Location(col: 0, row: 6)!, pieceType: .knight))
        blackQueenRow.append(ChessPieceFactory.create(teamColor: .black, location: Location(col: 0, row: 7)!, pieceType: .rook))
        current[0] = blackQueenRow
    }
    
    private func setWhitePieces() {
        var whitePwanRow: [ChessPiece?] = []
        for file in 0..<8 {
            guard let location = Location(col: file, row: 6) else { continue }
            whitePwanRow.append(ChessPieceFactory.create(teamColor: .white, location: location, pieceType: .pawn))
        }
        current[6] = whitePwanRow
        
        var whiteQueenRow: [ChessPiece?] = []
        whiteQueenRow.append(ChessPieceFactory.create(teamColor: .white, location: Location(col: 7, row: 0)!, pieceType: .rook))
        whiteQueenRow.append(ChessPieceFactory.create(teamColor: .white, location: Location(col: 7, row: 1)!, pieceType: .knight))
        whiteQueenRow.append(ChessPieceFactory.create(teamColor: .white, location: Location(col: 7, row: 2)!, pieceType: .bishop))
        whiteQueenRow.append(nil)
        whiteQueenRow.append(ChessPieceFactory.create(teamColor: .white, location: Location(col: 7, row: 4)!, pieceType: .queen))
        whiteQueenRow.append(ChessPieceFactory.create(teamColor: .white, location: Location(col: 7, row: 5)!, pieceType: .bishop))
        whiteQueenRow.append(ChessPieceFactory.create(teamColor: .white, location: Location(col: 7, row: 6)!, pieceType: .knight))
        whiteQueenRow.append(ChessPieceFactory.create(teamColor: .white, location: Location(col: 7, row: 7)!, pieceType: .rook))
        current[7] = whiteQueenRow
    }
    
    var display: [String] {
        var returnValue: [String] = []
        
        for rank in 0..<current.count {
            var currentRankString: String = "\(rank+1)"
            
            for file in 0..<current[rank].count {
                if let piece = current[rank][file] {
                    currentRankString += piece.pieceType.getString(teamColor: piece.teamColor)
                } else {
                    currentRankString += "."
                }
            }
            
            returnValue.append(currentRankString)
        }
        
        return returnValue
    }
    
    var blackTeamScore: Int {
        var blackTeamScore: Int = 0
        
        for file in 0..<current.count {
            for rank in 0..<current[file].count {
                guard let chessPiece = current[file][rank],
                      chessPiece.teamColor == .black else { continue }
                blackTeamScore += chessPiece.score
            }
        }
        return blackTeamScore
    }
    
    var whiteTeamScore: Int {
        var whiteTeamScore: Int = 0
        
        for file in 0..<current.count {
            for rank in 0..<current[file].count {
                guard let chessPiece = current[file][rank],
                      chessPiece.teamColor == .white else { continue }
                whiteTeamScore += chessPiece.score
            }
        }
        return whiteTeamScore
    }
    
    func printScore() {
        print("Black Team Score: \(blackTeamScore)")
        print("White Team Score: \(whiteTeamScore)")
    }
}
