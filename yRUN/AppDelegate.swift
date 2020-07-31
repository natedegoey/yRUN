//
//  AppDelegate.swift
//  yRUN
//
//  Created by Nathan DeGoey on 2020-07-26.
//  Copyright © 2020 Nathan DeGoey. All rights reserved.
//

import UIKit
import CoreData
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        let locationManager = LocationManager.shared
        locationManager.requestWhenInUseAuthorization()
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        CoreDataStack.saveContext()
      }
      
      func applicationWillTerminate(_ application: UIApplication) {
        CoreDataStack.saveContext()
      }
      
    }
