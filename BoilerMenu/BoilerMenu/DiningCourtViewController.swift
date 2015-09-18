//
//  DiningCourtViewController.swift
//  BoilerMenu
//
//  Created by George Lo on 9/18/15.
//  Copyright © 2015 Purdue iOS Dev Club. All rights reserved.
//

import UIKit

class DiningCourtViewController: UITableViewController {
    
    var diningCourtDictionary: [NSDictionary] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Retrieve the data from the URL and get it into the data variable
        let data = NSData(contentsOfURL: NSURL(string: "http://api.hfs.purdue.edu/menus/v2/locations")!)
        
        // Convert those data from the web into the format of NSDictionary
        let dict = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
        
        // Get the value of "Location" key, and set that value to diningCourtDictionary
        diningCourtDictionary = dict["Location"] as! [NSDictionary]
        
        self.tableView.rowHeight = 70
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return diningCourtDictionary.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MenuCell", forIndexPath: indexPath)

        let fileName = diningCourtDictionary[indexPath.row]["Images"]![0] as! String
        cell.imageView?.image = UIImage(data: NSData(contentsOfURL: NSURL(string: "http://api.hfs.purdue.edu/menus/v2/file/\(fileName)")!)!)
        cell.textLabel?.text = diningCourtDictionary[indexPath.row]["FormalName"] as? String
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
