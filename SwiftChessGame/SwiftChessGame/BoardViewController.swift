//
//  BoardViewController.swift
//  SwiftChessGame
//
//  Created by pingu.hwang on 2022/06/28.
//

import UIKit

class BoardViewController: UIViewController {
    lazy var boardView: BoardView = {
        let boardView = BoardView(viewModel: boardViewModel)
        boardView.translatesAutoresizingMaskIntoConstraints = false
        return boardView
    }()
    private let boardViewModel = BoardViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(boardView)
        NSLayoutConstraint.activate([
            boardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            boardView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            boardView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            boardView.widthAnchor.constraint(equalTo: view.widthAnchor),
            boardView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width + BoardInfoView.viewHeight)
        ])
    }
}
