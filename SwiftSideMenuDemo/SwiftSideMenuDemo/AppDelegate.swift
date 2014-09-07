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
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
    {
        var rootVC = ViewController()
        var navCon = UINavigationController(rootViewController: rootVC)
        navCon.navigationBar.backgroundColor = UIColor.clearColor()
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window?.backgroundColor = UIColor.greenColor()
        self.window?.makeKeyAndVisible()
        self.window!.rootViewController = navCon
        self.prefersStatusBarHidden()
        return true
    }
    
    func prefersStatusBarHidden() -> Bool {
        return true
    }

    
//    func applicationWillResignActive(application: UIApplication)
//    {
//    }
//
//    func applicationDidEnterBackground(application: UIApplication)
//    {
//    }
//
//    func applicationWillEnterForeground(application: UIApplication)
//    {
//    }
//
//    func applicationDidBecomeActive(application: UIApplication)
//    {
//    }
//
//    func applicationWillTerminate(application: UIApplication)
//    {
//    }
}

