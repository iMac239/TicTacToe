//
//  GameViewController.swift
//  TicTacToe
//
//  Created by Ian MacCallum on 9/13/15.
//  Copyright © 2015 Ian MacCallum. All rights reserved.
//

import Foundation
import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var boardView: BoardView!
    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        boardView.logic.delegate = self
        boardView.reset()
        logicDidChange(toPlayer: boardView.logic.currentPlayer)
    }
    
    @IBAction func refreshButtonPressed(sender: UIBarButtonItem) {
        boardView.reset()
    }
    
    @IBAction func infoButtonPressed(sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "How to Play", message: "You really don't know how to play Tic-Tac-Toe? Tap the board to match 3 shapes in a row!", preferredStyle: .Alert)
    
        let action = UIAlertAction(title: "Dismiss", style: .Cancel) { alert in
            
        }
        
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
  }


// MARK - Handle Logic Delegation
extension GameViewController: LogicDelegate {
    
    func logicDidEndGame(withWinner player: Player?) {
        
        var message: String?
        var winner: Int = -1
        
        // Determine winner
        if let player = player {
            winner = player == .X ? 0 : 1
            message = "\(player) wins!"
        } else {
            message = "Draw!"
        }
        
        
        
        // Alert to enter user data
        let alertController = UIAlertController(title: "Save Game", message: message ?? "Enter player names:", preferredStyle: .Alert)

        alertController.addTextFieldWithConfigurationHandler { textField in
            textField.placeholder = "Player 1 (X)"
        }
        
        alertController.addTextFieldWithConfigurationHandler { textField in
            textField.placeholder = "Player 2 (O)"
        }
        
        let action = UIAlertAction(title: "Done", style: UIAlertActionStyle.Default) { (action) -> Void in
            
            DataManager.createMatch(alertController.textFields?[0].text ?? "N/A", o: alertController.textFields?[1].text ?? "N/A", winner: winner)

            dispatch_async(dispatch_get_main_queue()) {
                self.boardView.reset()
            }
        }
        
        alertController.addAction(action)
        presentViewController(alertController, animated: true) {
    
        }
    }
    
    func logicDidChange(toPlayer player: Player) {
        textLabel.text = "\(player)'s move!"
    }
    
    func logicDidAddPiece(forPlayer player: Player, atLocation location: Location) {
        boardView.addedPieceBlock?(player: player, location: location)
    }
}