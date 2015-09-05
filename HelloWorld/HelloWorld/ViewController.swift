//
//  ViewController.swift
//  HelloWorld
//
//  Created by George Lo on 9/4/15.
//  Copyright © 2015 Purdue iOS Dev Club. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var exampleLabel: UILabel!
    
    @IBAction func openButtonTapped(sender: AnyObject) {
        self.performSegueWithIdentifier("goToDetail", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exampleLabel.numberOfLines = 2
        exampleLabel.text = "Purdue iOS Dev Club\nFall 2015"
    }
    
    override func viewWillAppear(animated: Bool) {
        // Set things up
        // Refresh
    }
    
    override func viewWillDisappear(animated: Bool) {
        // Clean up
    }
    
    override func viewDidDisappear(animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

