//
//  CFLogic.swift
//  ConnectFour
//
//  Created by Ian MacCallum on 9/9/15.
//  Copyright © 2015 Ian MacCallum. All rights reserved.
//

import Foundation

enum Player: Int {
    case X = 0, O
}

protocol LogicDelegate {
    func logicDidChange(toPlayer player: Player)
    func logicDidAddPiece(forPlayer player: Player, atLocation location: Location)
    func logicDidEndGame(withWinner player: Player?)
}

typealias Location = (x: Int, y: Int)
typealias Board = [[Player?]]
typealias Pattern = (Int, Int, Int)

class Logic {
    
    let rows = 3
    let columns = 3
    var board: [Player?]!
    var delegate: LogicDelegate?
    var gameOver = false
    var currentPlayer: Player = .X {
        didSet {
            delegate?.logicDidChange(toPlayer: currentPlayer)
        }
    }

    init() {
        reset()
    }
    
    func reset() {
        board = [Player?](count: rows * columns, repeatedValue: nil)
        gameOver = false
    }
    
    func addMark(atLocation location: Location) {
        guard board[location.x + rows * location.y] == nil && !gameOver else { return }
        
        board[location.x + rows * location.y] = currentPlayer
        delegate?.logicDidAddPiece(forPlayer: currentPlayer, atLocation: location)
        
        if let winner = checkMatch() {
            // Winner
            delegate?.logicDidEndGame(withWinner: winner)
            gameOver = true
        } else {
            // No winner
            if isDraw() {
                delegate?.logicDidEndGame(withWinner: nil)
                gameOver = true
            } else {
                // Game continues
                currentPlayer = currentPlayer == .X ? .O : .X

            }
        }
    }
    
    func checkMatch() -> Player? {
        let patterns = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
        
        // Iterate through winning patterns to find winner
        for pattern in patterns {
            if board[pattern[0]] == board[pattern[1]] && board[pattern[0]] == board[pattern[2]] {
                return board[pattern[0]]
            }
        }
        return nil
    }
    
    func isDraw() -> Bool {
        var result = true
        for i in 0...8 {
            if board[i] == nil {
                result = false
                break
            }
        }
        return result
    }
}

