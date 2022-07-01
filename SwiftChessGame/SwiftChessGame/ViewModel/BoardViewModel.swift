//
//  BoardViewModel.swift
//  SwiftChessGame
//
//  Created by pingu.hwang on 2022/06/30.
//

import Combine
import UIKit

final class BoardViewModel: NSObject {
    private let board = Board()
    private var from: Location?
    @Published var infoPublisher = PassthroughSubject<(turnInfo: String,scoreInfo: String), Never>()
    var turnInfoText: String {
        return "Turn: \(board.currentTurnInfo) Team 차례"
    }
    
    var scoreInfoText: String {
        let score = board.score
        return "Black: \(score.black), \(score.white): White"
    }
    
    private func presentAlert(message: String) {
        let alertController = UIAlertController(title: "에러", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default)
        alertController.addAction(okAction)
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let delegate = windowScene.delegate as? SceneDelegate {
            delegate.window?.rootViewController?.present(alertController, animated: true)
        }
    }
}

extension BoardViewModel: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let location = Location.create(with: indexPath) else { return }
        
        if from == nil {
            if board.checkTurn(with: board.chessPiece(at: location)) {
                from = location
                collectionView.reloadData()
                infoPublisher.send((turnInfoText, scoreInfoText))
            } else {
                presentAlert(message: "해당 팀의 차례가 아닙니다.")
            }
        } else {
            if from == Location.create(with: indexPath) {
                from = nil
                collectionView.reloadData()
                return
            } else {
                do {
                    try board.move(from: from, to: Location.create(with: indexPath))
                    from = nil
                    collectionView.reloadData()
                    infoPublisher.send((turnInfoText, scoreInfoText))
                } catch {
                    guard let error = error as? BoardError else { return }
                    presentAlert(message: error.message)
                }
            }
        }
    }
}


extension BoardViewModel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Board.boardSize * Board.boardSize
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChessPieceCell.identifier, for: indexPath) as? ChessPieceCell else { return UICollectionViewCell() }
        let location = Location.create(with: indexPath)
        var cellBackgroundColor: UIColor
        let row = indexPath.item / 8
        
        if row % 2 == 0 {
            cellBackgroundColor = indexPath.item % 2 == 0 ? .systemBlue : .white
        } else {
            cellBackgroundColor = indexPath.item % 2 == 0 ? .white : .systemBlue
        }
        
        if let from = from {
            if from == Location.create(with: indexPath) {
                cellBackgroundColor = .yellow
            } else if board.isMoveAvailable(from: from, to: Location.create(with: indexPath)) {
                cellBackgroundColor = .red
            }
        }
        
        cell.configure(with: board.chessPiece(at: location), backgroundColor: cellBackgroundColor)
        return cell
    }
}


extension BoardViewModel: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let cellSize = screenWidth / 8.0
        return .init(width: cellSize, height: cellSize)
    }
}
