//
//  ToDoViewController.swift
//  ToDoList
//
//  Created by George Lo on 9/25/15.
//  Copyright © 2015 Purdue iOS Dev Club. All rights reserved.
//

import UIKit
import CoreData

class ToDoViewController: UITableViewController {
    
    var tasks = [NSManagedObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "To Do List"
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        let applicationDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = applicationDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Task")
        let fetchedResults = try! managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]
        
        if let results = fetchedResults {
            tasks = results
        }
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
        return tasks.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let priority = tasks[indexPath.row].valueForKey("priority") as! Int
        cell.imageView?.image = self.createPriorityImage("\(priority)")
        cell.textLabel?.text = tasks[indexPath.row].valueForKey("name") as? String

        return cell
    }

    @IBAction func addTask(sender: AnyObject) {
        // Jump a popup
        let alert = UIAlertController(title: "To Do", message: "Add a task", preferredStyle: UIAlertControllerStyle.Alert)
        
        let saveButton = UIAlertAction(title: "Save", style: UIAlertActionStyle.Default, handler: {
            (action: UIAlertAction!) -> Void in
                // Retrieve the text from textfields
                let nameTF = alert.textFields![0]
                let prioTF = alert.textFields![1]
                let name = nameTF.text! as String
                let prio = Int(prioTF.text! as String)!
                self.saveTask(name, priority: prio)
                self.tableView.reloadData()
            })
        
        let cancelButton = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: {
            (action: UIAlertAction!) -> Void in
        })
        
        alert.addTextFieldWithConfigurationHandler({
            (textField: UITextField) -> Void in
            textField.placeholder = "Name"
        })
        
        alert.addTextFieldWithConfigurationHandler({
            (textField: UITextField) -> Void in
            textField.placeholder = "Priority"
        })
        
        alert.addAction(saveButton)
        alert.addAction(cancelButton)
        
        presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func saveTask(name: String, priority: Int) {
        let applicationDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = applicationDelegate.managedObjectContext
        
        let entity = NSEntityDescription.entityForName("Task", inManagedObjectContext: managedContext)
        
        let task = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        task.setValue(name, forKey: "name")
        task.setValue(priority, forKey: "priority")
        
        try! managedContext.save()
        tasks.append(task)
    }
    
    func createPriorityImage(text: NSString) -> UIImage {
        let len: CGFloat = 36
        
        let color: UIColor
        switch text {
        case "1":
            color = UIColor.blueColor()
            break
        case "2":
            color = UIColor.greenColor()
            break
        case "3":
            color = UIColor.grayColor()
            break
        default:
            color = UIColor.orangeColor()
            break
        }
        
        // Create the context
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(len, len), false, UIScreen.mainScreen().scale)
        let context = UIGraphicsGetCurrentContext()
        
        // Fill the circle
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillEllipseInRect(context, CGRectMake(0, 0, len, len))
        
        let paragraphStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.alignment = NSTextAlignment.Center
        let fontAttributes = [
            NSFontAttributeName: UIFont.boldSystemFontOfSize(17),
            NSParagraphStyleAttributeName: paragraphStyle,
            NSForegroundColorAttributeName: UIColor.whiteColor()
        ]
        text.drawInRect(CGRectMake(0, 7, len, 22), withAttributes: fontAttributes)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let applicationDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let managedContext = applicationDelegate.managedObjectContext
            
            managedContext.deleteObject(tasks[indexPath.row])
            try! managedContext.save()
            tasks.removeAtIndex(indexPath.row)
            self.tableView.reloadData()
        }
    }

    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }

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
