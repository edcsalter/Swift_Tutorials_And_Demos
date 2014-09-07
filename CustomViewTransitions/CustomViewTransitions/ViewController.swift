//
//  ViewController.swift
//  CustomViewTransitions
//
//  Created by Edward Salter on 9/6/14.
//  Copyright (c) 2014 Edward Salter. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let transitionManager = TransAnimateManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        let toViewController = segue.destinationViewController as UIViewController
        toViewController.transitioningDelegate = self.transitionManager
    }
    
    @IBAction func unwindToViewController(segue: UIStoryboardSegue)
    {
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return self.presentingViewController == nil ? UIStatusBarStyle.Default : UIStatusBarStyle.LightContent
    }
}

