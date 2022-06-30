//
//  BoardViewModel.swift
//  SwiftChessGame
//
//  Created by pingu.hwang on 2022/06/30.
//

import UIKit

final class BoardViewModel: NSObject {
    private let board = Board()
    private var from: Location?
}

extension BoardViewModel: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let location = Location.create(with: indexPath) else { return }
        
        if from == nil {
            if board.checkTurn(with: board.chessPiece(at: location)) {
                from = location
                collectionView.reloadData()
            } else {
                // 해당 말의 차례가 아님을 알려야함
                print("해당 말 차례가 아님")
            }
        } else {
            do {
                try board.move(from: from, to: Location.create(with: indexPath))
                from = nil
                collectionView.reloadData()
            } catch {
                guard let error = error as? BoardError else { return }
                switch error {
                case .locationError:
                    print("locationError")
                case .notAvailableLocation:
                    print("notAvailableLocation")
                case .emptyLocation:
                    print("emptyLocation")
                case .moveToEqualTeamLocation:
                    print("moveToEqualTeamLocation")
                case .chessPieceInTheRoute:
                    print("chessPieceInTheRoute")
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
        
        if let from = from,
           board.isMoveAvailable(from: from, to: Location.create(with: indexPath)) {
            cellBackgroundColor = .red
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
