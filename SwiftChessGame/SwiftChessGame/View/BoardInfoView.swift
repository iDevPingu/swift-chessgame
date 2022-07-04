//
//  BoardInfoView.swift
//  SwiftChessGame
//
//  Created by pingu.hwang on 2022/07/01.
//

import Combine
import UIKit

class BoardInfoView: UIView {
    static let identifier: String = "BoardInfoCell"
    static let viewHeight: CGFloat = 60.0
    
    private var cancellables = Set<AnyCancellable>()
    
    private let turnLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Turn"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Score"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(turnLabel)
        addSubview(scoreLabel)
        
        NSLayoutConstraint.activate([
            turnLabel.topAnchor.constraint(equalTo: topAnchor),
            turnLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            turnLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            turnLabel.heightAnchor.constraint(equalToConstant: 30),
            
            scoreLabel.topAnchor.constraint(equalTo: turnLabel.bottomAnchor),
            scoreLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            scoreLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func set(with: BoardViewModel) {
        turnLabel.text = with.turnInfoText
        scoreLabel.text = with.scoreInfoText
        
        with.infoPublisher
            .sink { [weak self] boardInfo in
                self?.turnLabel.text = boardInfo.turnInfo
                self?.scoreLabel.text = boardInfo.scoreInfo
            }
            .store(in: &cancellables)
    }
}
