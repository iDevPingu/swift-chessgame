//
//  BoardView.swift
//  SwiftChessGame
//
//  Created by pingu.hwang on 2022/06/28.
//

import Combine
import UIKit

class BoardView: UICollectionView {
    static let headerViewHeight: CGFloat = 40.0
    static let footerViewHeight: CGFloat = 40.0
    
    private var cancellables = Set<AnyCancellable>()
    
    let myView = UIView(frame: .zero)
    
    init(viewModel: BoardViewModel) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        super.init(frame: .zero, collectionViewLayout: layout)
        delegate = viewModel
        dataSource = viewModel
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        register(ChessPieceCell.self, forCellWithReuseIdentifier: ChessPieceCell.identifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
