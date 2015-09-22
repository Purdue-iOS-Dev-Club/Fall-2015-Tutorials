//
//  RestaurantViewController.swift
//  BoilerMenu
//
//  Created by George Lo on 9/21/15.
//  Copyright © 2015 Purdue iOS Dev Club. All rights reserved.
//

import UIKit

class RestaurantViewController: UITableViewController {
    
    // MARK: - Global vars
    
    var restaurantDictionary: [NSDictionary] = []
    var selectedRow = 0
    
    // MARK: - View controller cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Retrieve the data from the URL and get it into the data variable
        let data = NSData(contentsOfURL: NSURL(string: "http://api.hfs.purdue.edu/menus/v2/retail")!)
        
        // Convert those data from the web into the format of NSDictionary
        let dict = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
        
        // Get the value of "Location" key, and set that value to restaurantDictionary
        restaurantDictionary = dict["Location"] as! [NSDictionary]
        
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
        return restaurantDictionary.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RestaurantCell", forIndexPath: indexPath) as! RestaurantTableViewCell
        
        let fileName = restaurantDictionary[indexPath.row]["Logo"] as! String
        cell.restaurantIV.sd_setImageWithURL(NSURL(string: "http://api.hfs.purdue.edu/menus/v2/file/\(fileName)")!, placeholderImage: UIImage(named: "placeholder"))
        //cell.restaurantIV.image = UIImage(data: NSData(contentsOfURL: NSURL(string: "http://api.hfs.purdue.edu/menus/v2/file/\(fileName)")!)!)
        cell.restaurantLabel.text = restaurantDictionary[indexPath.row]["Name"] as? String
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedRow = indexPath.row
        self.performSegueWithIdentifier("toRestaurantDetail", sender: self)
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toRestaurantDetail" {
            let viewController = segue.destinationViewController as! RestaurantDetailViewController
            viewController.restaurantDict = restaurantDictionary[selectedRow]
        }
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
