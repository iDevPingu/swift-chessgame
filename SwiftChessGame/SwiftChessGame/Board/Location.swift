//
//  Location.swift
//  SwiftChessGame
//
//  Created by pingu.hwang on 2022/06/20.
//

import Foundation

final class Location {
    private var rank: Character
    private var file: Int
    
    var string: String { "\(rank)\(file)" }
    var current: (rank: Int, file: Int)? {
        let stringValue = Int(("A" as UnicodeScalar).value)
        guard let rankAsciiValue = rank.asciiValue else { return nil }
        return (Int(rankAsciiValue) - stringValue, self.file - 1)
    }
    
    init?(string: String) {
        if Self.available(location: string) {
            guard let file = Int(String(string[string.index(string.startIndex, offsetBy: 1)])) else { return nil }
            self.rank = string[string.startIndex]
            self.file = file
        } else {
            return nil
        }
    }
    
    init?(col: Int, row: Int) {
        if Self.available(col: col, row: row) {
            let stringValue = Int(("A" as UnicodeScalar).value)
            guard let unicodeScalar = UnicodeScalar(stringValue + row) else { return nil }
            self.rank = Character(unicodeScalar)
            self.file = col + 1
        } else {
            return nil
        }
    }
    
    private static func available(location: String) -> Bool {
        guard location.count == 2 else { return false }
        let rank = location[location.startIndex]
        
        guard let rankAsciiValue = rank.asciiValue,
              let minAsciiValue = Character("A").asciiValue,
              let maxAsciiValue = Character("H").asciiValue,
              rankAsciiValue >= minAsciiValue,
              rankAsciiValue <= maxAsciiValue else { return false }
        
        guard let file = Int(String(location[location.index(location.startIndex, offsetBy: 1)])),
              file >= 1, file <= 8 else { return false }
        
        return true
    }
    
    private static func available(col: Int, row: Int) -> Bool {
        guard row >= 0, row <= 7 else { return false }
        guard col >= 0, row <= 7 else { return false }
        return true
    }
    
    func moveAvailable(pieceType: PieceType) -> [Location] {
        switch pieceType {
        case .queen:
            return []
        case .rook:
            return []
        case .bishop:
            return []
        case .knight:
            return []
        case .pawn:
            return []
        }
    }
}
