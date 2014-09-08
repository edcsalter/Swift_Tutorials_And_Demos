//
//  ViewController.swift
//  SwiftSideMenuDemo
//
//  Created by Edward Salter on 9/5/14.
//  Copyright (c) 2014 Edward Salter. All rights reserved.
//
import Foundation
import UIKit

class ViewController: UIViewController, SideMenuDelegate, UIGestureRecognizerDelegate {
    
    var sideMenu : SideMenu?
    let imageView = UIImageView(image: UIImage(named: "background"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(imageView)
        sideMenu = SideMenu(sourceView: self.view, menuData: ["Always", "Endeavor", "to be", "EPIC!!!"])
        sideMenu!.delegate = self
        self.navigationController?.navigationBarHidden = true
        self.navigationController?.navigationBar.backgroundColor = UIColor.clearColor()
        self.prefersStatusBarHidden()
        self.setupNavBar()
    }
    
    func setupNavBar() {
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
        visualEffectView.frame = CGRectMake(0, 0, self.view.frame.size.width, 44)
        visualEffectView.setNeedsUpdateConstraints()
        self.view.addSubview(visualEffectView)
        let button = self.buildButton()
        self.view.addSubview(button)
    }
    
    func buildButton() -> UIButton {
        let menuButton = UIButton(frame: CGRectMake(10, 2, 40, 40))
        let image = UIImage(named: "lines")
        menuButton.setImage(image, forState: UIControlState.Normal)
        menuButton.setImage(image, forState: UIControlState.Highlighted)
        menuButton.addTarget(self, action: "toggleSideMenu:", forControlEvents: .TouchUpInside)
        return menuButton
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func sideMenuDidSelectItemAtIndex(index: Int) {
        sideMenu?.toggleMenu()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func toggleSideMenu(sender: AnyObject) {
        sideMenu?.toggleMenu()
    }
}

