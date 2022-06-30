//
//  Board.swift
//  SwiftChessGame
//
//  Created by pingu.hwang on 2022/06/20.
//

import Foundation

extension Array {
    subscript(location: Location?) -> ChessPiece? {
        guard let location = location else { return nil }
        guard let file = self[location.boardIndex.file] as? [ChessPiece?] else { return nil }
        
        return file[location.boardIndex.rank]
    }
}

final class Board {
    static var boardSize: Int = 8
    
    private var current: [[ChessPiece?]] = []
    private var currentTurn: TeamColor = .black
    
    var blackTeamScore: Int {
        var blackTeamScore: Int = 0
        
        for file in 0..<Self.boardSize {
            for rank in 0..<Self.boardSize {
                guard let chessPiece = current[file][rank],
                      chessPiece.teamColor == .black else { continue }
                blackTeamScore += chessPiece.score
            }
        }
        return blackTeamScore
    }
    
    var whiteTeamScore: Int {
        var whiteTeamScore: Int = 0
        
        for file in 0..<Self.boardSize {
            for rank in 0..<Self.boardSize {
                guard let chessPiece = current[file][rank],
                      chessPiece.teamColor == .white else { continue }
                whiteTeamScore += chessPiece.score
            }
        }
        return whiteTeamScore
    }
    
    init() {
        resetBoard()
    }
    
    private func setBlackPieces() {
        var blackPawnRow: [ChessPiece?] = []
        for rank in 0..<8 {
            guard let location = Location(col: 1, row: rank) else { continue }
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
        for rank in 0..<8 {
            guard let location = Location(col: 6, row: rank) else { continue }
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
    
    func resetBoard() {
        current.removeAll()
        current = [[ChessPiece?]](repeating: [ChessPiece?](repeating: nil, count: 8), count: 8)
        currentTurn = .black
        setBlackPieces()
        setWhitePieces()
        print("체스 보드를 초기화했습니다.")
        displayPretty()
    }
    
    func checkTurn(with: ChessPiece?) -> Bool {
        return with?.teamColor == currentTurn
    }
    
    func printScore() {
        print("Black Team Score: \(blackTeamScore)")
        print("White Team Score: \(whiteTeamScore)")
    }
    
    func display() -> [String] {
        var returnValue: [String] = []
        
        for rank in 0..<Self.boardSize {
            var currentRankString: String = ""
            
            for file in 0..<Self.boardSize {
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
    
    func displayPretty() {
        let display = display()
        print(" ABCDEFGH")
        for count in 0..<display.count {
            print("\(count+1)\(display[count])")
        }
        print(" ABCDEFGH")
    }
    
    func chessPiece(at: Location?) -> ChessPiece? {
        return current[at]
    }
    
    func move(from: Location?, to: Location?) throws {
        guard let from = from,
              let to = to else { throw BoardError.locationError }
        
        guard let fromChessPiece = current[from] else { throw BoardError.emptyLocation }
        guard fromChessPiece.currentMoveableLocation.contains(to) else { throw BoardError.notAvailableLocation }
        for route in fromChessPiece.getRoute(to: to) {
            guard route != to else { break }
            if let chessPiece = current[route],
               chessPiece.teamColor == fromChessPiece.teamColor {
                throw BoardError.chessPieceInTheRoute
            }
        }
        
        let toChessPiece = current[to]
        
        if let toChessPiece = toChessPiece {
            guard fromChessPiece.teamColor != toChessPiece.teamColor else { throw BoardError.moveToEqualTeamLocation }
        }
        
        
        current[from.boardIndex.file][from.boardIndex.rank] = nil
        current[to.boardIndex.file][to.boardIndex.rank] = fromChessPiece
        fromChessPiece.move(to: to)
        
        currentTurn = currentTurn == .black ? .white : .black
    }
    
    func isMoveAvailable(from: Location?, to: Location?) -> Bool {
        guard let from = from, let to = to,
              let fromChessPiece = chessPiece(at: from) else { return false }
        
        if fromChessPiece.currentMoveableLocation.contains(to) == false {
            return false
        } else {
            var chessPieceInTheRoute: Bool = false
            for route in fromChessPiece.getRoute(to: to) {
                guard !chessPieceInTheRoute else { return false }
                
                if let chessPiece = current[route] {
                    if chessPiece.teamColor == fromChessPiece.teamColor {
                        return false
                    } else {
                        chessPieceInTheRoute = true
                    }
                }
            }
        }
        
        return true
    }
}

enum BoardError: Error {
    case locationError
    case notAvailableLocation
    case emptyLocation
    case moveToEqualTeamLocation
    case chessPieceInTheRoute
    
    var message: String {
        switch self {
        case .locationError:
            return "이상한 위치입니다."
        case .notAvailableLocation:
            return "이동할 수 없는 위치입니다."
        case .emptyLocation:
            return "해당 위치엔 체스말이 없습니다."
        case .moveToEqualTeamLocation:
            return "해당 위치는 같은팀 체스말이 이미 존재합니다."
        case .chessPieceInTheRoute:
            return "해당 위치로 가는 경로에 같은팀 체스말이 존재합니다."
        }
    }
}
