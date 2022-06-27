//
//  Location.swift
//  SwiftChessGame
//
//  Created by pingu.hwang on 2022/06/20.
//

import Foundation

extension Location: Hashable {
    static func == (lhs: Location, rhs: Location) -> Bool {
        return (lhs.file == rhs.file) && (lhs.rank == rhs.rank)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(file)
        hasher.combine(rank)
    }
}

extension Location: Comparable {
    static func < (lhs: Location, rhs: Location) -> Bool {
        return lhs.string < rhs.string
    }
}

final class Location {
    private(set) var rank: Int
    private(set) var file: Int
    
    var string: String {
        let aAsciiValue = Int(("A" as UnicodeScalar).value)
        guard let rankAsCharacter = UnicodeScalar(rank + aAsciiValue) else { return "" }
        return "\(rankAsCharacter)\(file)"
    }
    
    var boardIndex: (rank: Int, file: Int) {
        return (rank, file - 1)
    }
    
    init?(string: String) {
        if Self.available(location: string) {
            guard let file = Int(String(string[string.index(string.startIndex, offsetBy: 1)])) else { return nil }
            let aAsciiValue = Int(("A" as UnicodeScalar).value)
            let rankCharacter = string[string.startIndex]
            guard let rankAsciiValue = rankCharacter.asciiValue else { return nil }
            
            self.rank = Int(rankAsciiValue) - aAsciiValue
            self.file = file
        } else {
            return nil
        }
    }
    
    init?(col: Int, row: Int) {
        if Self.available(col: col, row: row) {
            self.rank = row
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
        guard col >= 0, col <= 7 else { return false }
        return true
    }
}
