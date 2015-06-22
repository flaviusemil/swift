//
//  TableViewController.swift
//  Memorable Places
//
//  Created by Flavius Condurache on 22/06/15.
//  Copyright (c) 2015 Flavius Condurache. All rights reserved.
//

import UIKit

var places = [Dictionary<String, String>()]
var activePlace = -1
var didLoad = false

class TableViewController: UITableViewController {
    
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if NSUserDefaults.standardUserDefaults().objectForKey("places") != nil {
            places = NSUserDefaults.standardUserDefaults().objectForKey("places") as! [Dictionary<String, String>]
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        if places.count == 0 && didLoad == false {
            didLoad = true
            places.append(["name": "Taj Mahal", "lat": "27.175277", "long": "78.042128"])
        }
        
        table.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "newPlace" {
            activePlace = -1
        }
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            places.removeAtIndex(indexPath.row)
            NSUserDefaults.standardUserDefaults().setObject(places, forKey: "places")
            table.reloadData()
        }
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        activePlace = indexPath.row
        return indexPath
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel?.text = places[indexPath.row]["name"]
        
        return cell
    }

}
