//
//  ViewController.swift
//  DynamicDrop
//
//  Created by Edward Salter on 8/17/14.
//  Copyright (c) 2014 Edward Salter. All rights reserved.
//

import UIKit
import CoreGraphics

class ViewController: UIViewController, UICollisionBehaviorDelegate {
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var dynamicBehavior: UICollisionBehavior!
    var square: UIView!
    var snap: UISnapBehavior!
    var initialHit = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let pushVector = CGVectorMake(10, 20)

        square = UIView(frame: CGRect(x: 100, y: 0, width: 100, height: 100))
        square.backgroundColor = UIColor.greenColor()
        view.addSubview(self.square)
        
        let barrierFloor = UIView(frame: CGRectMake( 100, 100, 100, 100))
        barrierFloor.backgroundColor = UIColor.blackColor()
        //  view.addSubview(barrierFloor)
        
        let bumperLeft = UIView(frame: CGRectMake(0, 300, 125, 25))
        bumperLeft.backgroundColor = UIColor.orangeColor()
        view.addSubview(bumperLeft)
        
        let leftMidBumper = UIView(frame: CGRectMake(240, 385, 40, 40))
        leftMidBumper.backgroundColor = UIColor.orangeColor()
        view.addSubview(leftMidBumper)

        let rightMidBumper = UIView(frame: CGRectMake(300, 205, 40, 40))
        rightMidBumper.backgroundColor = UIColor.orangeColor()
        view.addSubview(rightMidBumper)

       
        animator = UIDynamicAnimator(referenceView: self.view)
        gravity = UIGravityBehavior(items: [self.square])

        dynamicBehavior = UICollisionBehavior(items: [self.square])
        dynamicBehavior.collisionDelegate = self

      //  dynamicBehavior.addBoundaryWithIdentifier("left", forPath: UIBezierPath(rect: CGRectMake(0, 0, 10, 580)))
       // dynamicBehavior.addBoundaryWithIdentifier("left", forPath: UIBezierPath(rect: CGRectMake(310, 0, 10, 580)))
        dynamicBehavior.addBoundaryWithIdentifier("bumperLeft", forPath: UIBezierPath(rect: bumperLeft.frame))
        dynamicBehavior.addBoundaryWithIdentifier("leftMidBumper", forPath: UIBezierPath(rect: leftMidBumper.frame))
        dynamicBehavior.addBoundaryWithIdentifier("rightMidBumper", forPath: UIBezierPath(rect: rightMidBumper.frame))

        dynamicBehavior.translatesReferenceBoundsIntoBoundary = true
        
        animator.addBehavior(dynamicBehavior)
        animator.addBehavior(gravity)
    
        
        var updateCount = 0
        dynamicBehavior.action = {
            if (updateCount % 2 == 0) {
                let outline = UIView(frame: self.square.bounds)
                outline.transform = self.square.transform
                outline.center = self.square.center
                outline.alpha = 0.4
                outline.backgroundColor = UIColor.clearColor()
                outline.layer.borderColor = self.square.layer.presentationLayer().backgroundColor
                outline.layer.borderWidth = 1.0
                outline.layer.cornerRadius = 5
                ++outline.layer.cornerRadius
                self.view.addSubview(outline)
            }
            
            ++updateCount
        }
        let objectBehavior = UIDynamicItemBehavior(items: [self.square])
        objectBehavior.elasticity = 0.8
        animator.addBehavior(objectBehavior)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collisionBehavior(behavior: UICollisionBehavior!, beganContactForItem item: UIDynamicItem!, withBoundaryIdentifier identifier: NSCopying!, atPoint p: CGPoint) {
        println("We've been hit at \(identifier)")
        let collisionView = item as UIView
        collisionView.backgroundColor = UIColor.greenColor()
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            collisionView.backgroundColor = UIColor.redColor()
        })
//        if (!initialHit) {
//            initialHit = true
//            
//            let square = UIView(frame: CGRect(x: 150, y: 0, width: 100, height: 100))
//            square.backgroundColor = UIColor.blueColor()
//            view.addSubview(square)
//            
//            dynamicBehavior.addItem(square)
//            
//            gravity.addItem(square)
//            
//            let attach = UIAttachmentBehavior(item: square, attachedToItem:self.square)
//            animator.addBehavior(attach)
//        }

    }
    
}


