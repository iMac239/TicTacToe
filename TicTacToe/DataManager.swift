//
//  ScoreManager.swift
//  TicTacToe
//
//  Created by Ian MacCallum on 9/11/15.
//  Copyright © 2015 Ian MacCallum. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DataManager {
    
    static let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    class func createMatch(x: String, o: String, winner: Int) -> Match? {
        
        let match = NSEntityDescription.insertNewObjectForEntityForName("Match", inManagedObjectContext: context) as? Match
        match?.x = x
        match?.o = o
        match?.winner = winner
        match?.date = NSDate()
        
        return match
    }
}

