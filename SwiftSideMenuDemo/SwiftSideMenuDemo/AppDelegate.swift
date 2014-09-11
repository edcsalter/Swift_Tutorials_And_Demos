//
//  AppDelegate.swift
//  SwiftSideMenuDemo
//
//  Created by Edward Salter on 9/5/14.
//  Copyright (c) 2014 Edward Salter. All rights reserved.
//
import Foundation
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?
    var rootVC = ViewController()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
    {
        var navCon = UINavigationController(rootViewController: rootVC)
        navCon.navigationBar.backgroundColor = UIColor.clearColor()
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window!.rootViewController = navCon
        self.window?.backgroundColor = UIColor.greenColor()
        self.window?.makeKeyAndVisible()
        navCon.navigationBar.backgroundColor = UIColor.clearColor()
        self.prepareForInterfaceBuilder()
        return true
    }

}

