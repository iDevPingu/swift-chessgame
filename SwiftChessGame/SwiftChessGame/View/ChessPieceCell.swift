//
//  ChessPieceCell.swift
//  SwiftChessGame
//
//  Created by pingu.hwang on 2022/06/30.
//

import UIKit

class ChessPieceCell: UICollectionViewCell {
    static let identifier = "ChessPieceCell"
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 40)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        contentView.backgroundColor = .clear
        contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
   
    func configure(with: ChessPiece?, backgroundColor: UIColor) {
        if let chessPiece = with {
            label.text = chessPiece.pieceType.getString(teamColor: chessPiece.teamColor)
        } else {
            label.text = nil
        }
        
        contentView.backgroundColor = backgroundColor
    }
}

