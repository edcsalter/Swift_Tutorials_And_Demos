//
//  TransAnimateManager.swift
//  CustomViewTransitions
//
//  Created by Edward Salter on 9/6/14.
//  Copyright (c) 2014 Edward Salter. All rights reserved.
//


import UIKit
class TransAnimateManager: NSObject, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    
    private var presenting = true
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        //MARK: Set Transition Constants
        //Get reference to fromView, toView, & container view where transition occurs
        let container = transitionContext.containerView()
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        let Pi : CGFloat = 3.14159265359
        let offScreenRight = CGAffineTransformMakeRotation(-Pi/2)
        let offScreenLeft = CGAffineTransformMakeRotation(Pi/2)
        
        //MARK: Mechanics of Sliding Views Horizontally
//        let offScreenRight = CGAffineTransformMakeTranslation(container.frame.width, 0)
//        let offScreenLeft = CGAffineTransformMakeTranslation(-container.frame.width, 0)

        // start the toView to the right of the screen
//        toView.transform = offScreenRight
//        if self.presenting {
//            fromView.transform = offScreenLeft
//        } else {
//            fromView.transform = offScreenRight
//        }
        
        //MARK: Mechanics of Rotating View About Anchor
        toView.transform = self.presenting ? offScreenRight : offScreenLeft
        
        //MARK: Anchor
            //Provides axis of rotation for view transiton
        toView.layer.anchorPoint = CGPoint(x:0, y:0)
        fromView.layer.anchorPoint = CGPoint(x:0, y:0)
        
        //MARK: Center Reset
            //Moving center position point to allow rotation transformation about top left corner
        toView.layer.position = CGPoint(x:0, y:0)
        fromView.layer.position = CGPoint(x:0, y:0)

        //Add both views to viewController
        container.addSubview(toView)
        container.addSubview(fromView)
        
        //Get duration of animation
        let duration = self.transitionDuration(transitionContext)
        
        //MARK: Perform Animation
            //Perform animation
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: nil, animations: {
                fromView.transform = self.presenting ? offScreenLeft : offScreenRight //fromView.transform = offScreenLeft
                toView.transform = CGAffineTransformIdentity
            }, completion: { finished in
                transitionContext.completeTransition(true)
        })
    }
    
    //MARK: Transition Timing
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 0.75
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = true
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = false
        return self
    }
    
}
