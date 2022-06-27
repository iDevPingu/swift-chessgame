//
//  BoardView.swift
//  SwiftChessGame
//
//  Created by pingu.hwang on 2022/06/28.
//

import UIKit

class BoardView: UIStackView {
    var board: Board
    
    // 임시
    private var boardFile: [UIStackView] = []
    private var chessPieceView: [[UIButton]] = []
    
    init(board: Board) {
        self.board = board
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .lightGray
        spacing = 0
        axis = .vertical
        distribution = .fillEqually
        
        setBoardFile()
        setChessPieceView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setBoardFile() {
        for _ in 0..<Board.boardSize {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.spacing = 0
            stackView.distribution = .fillEqually
            addArrangedSubview(stackView)
            boardFile.append(stackView)
        }
    }
    
    private func setChessPieceView() {
        for file in 0..<Board.boardSize {
            for rank in 0..<Board.boardSize {
                let button = UIButton()
                if let location = Location(col: file, row: rank),
                   let chessPiece = board.chessPiece(at: location) {
                    button.setTitle(chessPiece.pieceType.getString(teamColor: chessPiece.teamColor), for: .normal)
                }
                boardFile[file].addArrangedSubview(button)
            }
        }
    }
}
