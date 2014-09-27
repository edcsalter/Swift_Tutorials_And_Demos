//
//  VCMain.swift
//  CoreDataTest
//
//  Created by Edward Salter on 8/7/14.
//  Copyright (c) 2014 Edward Salter. All rights reserved.
//

import UIKit
import CoreData

class VCMain: UIViewController {
    
    @IBOutlet var txtUsername: UITextField!
    @IBOutlet var txtPassword: UITextField!
    
    @IBAction func saveButton() {
        //  println("Save Button Pressed \(txtUsername.text)")
        
        var appDelegateReference: AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        /*adding "as AppDelegate" points the ".delegate", which is just
         a general delegate back to specific app's AppDelegate */
        var contextReference:NSManagedObjectContext = appDelegateReference.managedObjectContext!
        //Xcode won't accept anything other than existence (hence the exclamation point) of ".managedObjectedContext"
        
        //Below = how to add user to SQlite/CoreData
        var newUser = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: contextReference) as NSManagedObject
        //Takes inferred entry of "AnyObject", which actually NSManagedObject, which refers back to NSManagedObjectContext of "contextReference"
        newUser.setValue(txtUsername.text!, forKey: "username")
        // Key must reference SQlite Key previously established
        newUser.setValue(txtPassword.text!, forKey: "password")
        // Key must reference SQlite Key previously established
        
        contextReference.save(nil)
        //"nil" is currently placeholder for errorhandling code
        
        println(newUser)
        println("Object Saved")
    }
    
    @IBAction func loadButton() {
        //   println("Load Button Pressed \(txtPassword.text)")
        var appDelegateReference: AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        
        var contextReference:NSManagedObjectContext = appDelegateReference.managedObjectContext!
        
        var request = NSFetchRequest(entityName: "Users")
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: "username = %@", txtUsername.text!)
        //Double checking that the entered Username actually has corresponding stored password
        
        //prevents return of reference to nonexistent object crashing app
        var results:NSArray = contextReference.executeFetchRequest(request, error: nil)!
        
        if results.count > 0 {
            var res = results[0] as NSManagedObject
            txtUsername.text = res.valueForKey("username") as String
            txtPassword.text = res.valueForKey("password") as String
          //  for returnedResults in results {
          //      println(returnedResults)
          //  }

        } else {
            println("0 Results Returned Potential Error")

                   }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
