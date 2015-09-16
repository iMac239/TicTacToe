//
//  Match+CoreDataProperties.swift
//  TicTacToe
//
//  Created by Ian MacCallum on 9/13/15.
//  Copyright © 2015 Ian MacCallum. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Match {

    @NSManaged var x: String!
    @NSManaged var winner: NSNumber!
    @NSManaged var o: String!
    @NSManaged var date: NSDate!

}
