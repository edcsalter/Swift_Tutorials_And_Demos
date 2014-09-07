//
//  SideMenu.swift
//  SwiftSideMenuDemo
//
//  Created by Edward Salter on 9/5/14.
//  Copyright (c) 2014 Edward Salter. All rights reserved.
//

import Foundation
import UIKit

@objc protocol SideMenuDelegate {
    func sideMenuDidSelectItemAtIndex(index:Int)
    optional func sideMenuWillOpen()
    optional func sideMenuWillClose()
}

class SideMenu : NSObject, TableVCDelegate {
    
    let menuWidth : CGFloat = 220.0
    let menuTVInsetTop : CGFloat = 84.0
    let menuTVInsetLeft : CGFloat = 0.0
    let menuContView =  UIView()
    let menuTVC = TableVC()
    var animator : UIDynamicAnimator!
    let sourceView : UIView!
    var delegate : SideMenuDelegate?
    var isMenuOpen : Bool = false
    
    init(sourceView: UIView, menuData:Array<String>) {
        super.init()
        self.sourceView = sourceView
        self.menuTVC.tableData = menuData
        
        self.setupMenuView()
        
        animator = UIDynamicAnimator(referenceView:sourceView)
        // Add show gesture recognizer
        var showGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("handleGesture:"))
        showGestureRecognizer.direction = UISwipeGestureRecognizerDirection.Right
        sourceView.addGestureRecognizer(showGestureRecognizer)
        
        // Add hide gesture recognizer
        var hideGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("handleGesture:"))
        hideGestureRecognizer.direction = UISwipeGestureRecognizerDirection.Left
        menuContView.addGestureRecognizer(hideGestureRecognizer)
    }
    
    
    func setupMenuView() {
        
        // Configure side menu container
        menuContView.frame = CGRectMake(-menuWidth-1.0, sourceView.frame.origin.y, menuWidth, sourceView.frame.size.height)
        menuContView.backgroundColor = UIColor.clearColor()
        menuContView.clipsToBounds = true
        menuContView.layer.masksToBounds = false;
        menuContView.layer.shadowOffset = CGSizeMake(1.0, 1.0);
        menuContView.layer.shadowRadius = 1.0;
        menuContView.layer.shadowOpacity = 0.125;
        menuContView.layer.shadowPath = UIBezierPath(rect: menuContView.bounds).CGPath
        
        sourceView.addSubview(menuContView)
        
        // Add blur view
        var visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
        visualEffectView.frame = menuContView.bounds
        menuContView.addSubview(visualEffectView)
        
        // Configure side menu table view
        menuTVC.delegate = self
        menuTVC.tableView.frame = menuContView.bounds
        menuTVC.tableView.clipsToBounds = false
        menuTVC.tableView.separatorStyle = .None
        menuTVC.tableView.backgroundColor = UIColor.clearColor()
        menuTVC.tableView.scrollsToTop = false
        menuTVC.tableView.contentInset = UIEdgeInsetsMake(menuTVInsetTop, menuTVInsetLeft, 0, 0)
        
        menuTVC.tableView.reloadData()
        menuContView.addSubview(menuTVC.tableView)
    }
    
    func handleGesture(gesture: UISwipeGestureRecognizer) {
        
        if (gesture.direction == .Left) {
            toggleMenu(false)
            delegate?.sideMenuWillClose?()
        }
        else{
            toggleMenu(true)
            delegate?.sideMenuWillOpen?()
        }
    }
    
    func toggleMenu (shouldOpen: Bool) {
        animator.removeAllBehaviors()
        isMenuOpen = shouldOpen
        let gravityDirectionX: CGFloat = (shouldOpen) ? 0.5 : -0.5;
        let pushMagnitude: CGFloat = (shouldOpen) ? 80.0 : -80.0;
        let boundaryPointX: CGFloat = (shouldOpen) ? menuWidth : -menuWidth-1.0;
        
        let gravityBehavior = UIGravityBehavior(items: [menuContView])
        gravityBehavior.gravityDirection = CGVectorMake(gravityDirectionX, 0.0)
        animator.addBehavior(gravityBehavior)
        
        let collisionBehavior = UICollisionBehavior(items: [menuContView])
        collisionBehavior.addBoundaryWithIdentifier("menuBoundary", fromPoint: CGPointMake(boundaryPointX, 20.0),
            toPoint: CGPointMake(boundaryPointX, sourceView.frame.size.height))
        animator.addBehavior(collisionBehavior)
        
        let pushBehavior = UIPushBehavior(items: [menuContView], mode: UIPushBehaviorMode.Instantaneous)
        pushBehavior.magnitude = pushMagnitude
        animator.addBehavior(pushBehavior)
        
        let menuViewBehavior = UIDynamicItemBehavior(items: [menuContView])
        menuViewBehavior.elasticity = 0.2
        animator.addBehavior(menuViewBehavior)
    }
    func menuControllerDidSelectRow(indexPath:NSIndexPath) {
        delegate?.sideMenuDidSelectItemAtIndex(indexPath.row)
    }
    func toggleMenu () {
        if (isMenuOpen) {
            toggleMenu(false)
        }
        else {
            toggleMenu(true)
        }
    }
}

