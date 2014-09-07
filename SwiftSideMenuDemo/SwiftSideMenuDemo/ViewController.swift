//
//  ViewController.swift
//  SwiftSideMenuDemo
//
//  Created by Edward Salter on 9/5/14.
//  Copyright (c) 2014 Edward Salter. All rights reserved.
//
import Foundation
import UIKit

class ViewController: UIViewController, SideMenuDelegate {
    
    var sideMenu : SideMenu?
    let imageView = UIImageView(image: UIImage(named: "background"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(imageView)
        // Do any additional setup after loading the view, typically from a nib.
        sideMenu = SideMenu(sourceView: self.view, menuData: ["Always", "Endeavor", "to be", "EPIC!!!"])
        sideMenu!.delegate = self
        self.navigationController?.navigationBar.backgroundColor = UIColor.clearColor()
        var visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
        visualEffectView.frame = self.navigationController!.navigationBar.frame
        self.navigationController?.view.addSubview(visualEffectView)
        self.prefersStatusBarHidden()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sideMenuDidSelectItemAtIndex(index: Int) {
        sideMenu?.toggleMenu()
    }
    
//    func toggleSideMenu(sender: AnyObject) {
//        sideMenu?.toggleMenu()
//    }
   }

