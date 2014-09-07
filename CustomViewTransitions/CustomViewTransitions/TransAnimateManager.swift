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
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning)
    {
        /* get reference to our fromView, toView and the container view that we should perform the transition in
        */
        let container = transitionContext.containerView()
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        
        // set up from 2D transforms that we'll use in the animation
        let Pi : CGFloat = 3.14159265359

//        let offScreenRight = CGAffineTransformMakeTranslation(container.frame.width, 0)
//        let offScreenLeft = CGAffineTransformMakeTranslation(-container.frame.width, 0)
        
        let offScreenRight = CGAffineTransformMakeRotation(-Pi/2)
        let offScreenLeft = CGAffineTransformMakeRotation(Pi/2)

        toView.transform = self.presenting ? offScreenRight : offScreenLeft

        // start the toView to the right of the screen
//        toView.transform = offScreenRight
//        if self.presenting {
//            fromView.transform = offScreenLeft
//        } else {
//            fromView.transform = offScreenRight
//        }
        //Anchor views, providing axis of rotation
        toView.layer.anchorPoint = CGPoint(x:0, y:0)
        fromView.layer.anchorPoint = CGPoint(x:0, y:0)
        
        //Moving center position point to counter
        toView.layer.position = CGPoint(x:0, y:0)
        fromView.layer.position = CGPoint(x:0, y:0)

        //Add both views to viewController
        container.addSubview(toView)
        container.addSubview(fromView)
        
        //Get duration of animation
        let duration = self.transitionDuration(transitionContext)
        
        //Perform animation
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: nil, animations: {
                fromView.transform = self.presenting ? offScreenLeft : offScreenRight
//              fromView.transform = offScreenLeft
                toView.transform = CGAffineTransformIdentity
            }, completion: { finished in
                transitionContext.completeTransition(true)
        })
    }
    
    //how long transition will take
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval
    {
//        return 0.5
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
