//
//  Rook.swift
//  SwiftChessGame
//
//  Created by pingu.hwang on 2022/06/20.
//

import Foundation

final class Rook: ChessPiece {
    public internal(set) var teamColor: TeamColor
    var currentLocation: Location
    let pieceType: PieceType = .rook
    
    init(teamColor: TeamColor, currentLocation: Location) {
        self.teamColor = teamColor
        self.currentLocation = currentLocation
    }
}
