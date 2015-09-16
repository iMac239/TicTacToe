//
//  ViewController.swift
//  TicTacToe
//
//  Created by Ian MacCallum on 9/11/15.
//  Copyright © 2015 Ian MacCallum. All rights reserved.
//

import UIKit
import CoreData

class ScoreViewController: UITableViewController {
    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    let fetchedResultsController: NSFetchedResultsController
   
    required init?(coder aDecoder: NSCoder) {
        
        // Setup FRC
        let fetchRequest = NSFetchRequest(entityName: "Match")
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        // Bug. Returns Void so there is no "Result"
        let _ = try? fetchedResultsController.performFetch()

        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


// MARK - Data Source
extension ScoreViewController {
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.fetchedObjects?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ScoreCellID", forIndexPath: indexPath)
        
        if let match = fetchedResultsController.objectAtIndexPath(indexPath) as? Match {
            // Outcome
            switch Int(match.winner ?? -1) {
            case 0:
                cell.textLabel?.text = "\(match.x) beats \(match.o)"

            case 1:
                cell.textLabel?.text = "\(match.o) beats \(match.x)"

            default:
                cell.textLabel?.text = "\(match.x) and \(match.o) draw"
            }
            
            // Date
            let formatter = NSDateFormatter()
            formatter.dateStyle = .ShortStyle
            formatter.timeStyle = .ShortStyle
            cell.detailTextLabel?.text = formatter.stringFromDate(match.date)

        }
        return cell
    }
}
