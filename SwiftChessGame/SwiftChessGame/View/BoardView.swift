//
//  BoardView.swift
//  SwiftChessGame
//
//  Created by pingu.hwang on 2022/06/28.
//

import UIKit

class BoardView: UIView {
    private let boardInfoView: BoardInfoView = {
        let boardInfoView = BoardInfoView(frame: .zero)
        boardInfoView.translatesAutoresizingMaskIntoConstraints = false
        return boardInfoView
    }()
    
    private let boardView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ChessPieceCell.self, forCellWithReuseIdentifier: ChessPieceCell.identifier)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    init(viewModel: BoardViewModel) {
        super.init(frame: .zero)
        boardInfoView.set(with: viewModel)
        boardView.delegate = viewModel
        boardView.dataSource = viewModel
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(boardInfoView)
        addSubview(boardView)
        
        NSLayoutConstraint.activate([
            boardInfoView.topAnchor.constraint(equalTo: topAnchor),
            boardInfoView.leadingAnchor.constraint(equalTo: leadingAnchor),
            boardInfoView.trailingAnchor.constraint(equalTo: trailingAnchor),
            boardInfoView.heightAnchor.constraint(equalToConstant: BoardInfoView.viewHeight),
            
            boardView.topAnchor.constraint(equalTo: boardInfoView.bottomAnchor),
            boardView.leadingAnchor.constraint(equalTo: leadingAnchor),
            boardView.trailingAnchor.constraint(equalTo: trailingAnchor),
            boardView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
