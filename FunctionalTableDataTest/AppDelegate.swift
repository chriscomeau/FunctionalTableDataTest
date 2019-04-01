//
//  AppDelegate.swift
//  FunctionalTableDataTest
//
//  Created by Chris Comeau on 2019-02-15.
//  Copyright © 2019 Skyriser Media. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		
    //without storyboard
    window = UIWindow(frame: UIScreen.main.bounds)
    let rootViewController = ViewController()
    let nav = UINavigationController()
    nav.viewControllers = [rootViewController]
    window!.rootViewController = nav
    window!.makeKeyAndVisible()
    
    //tint
    //UINavigationBar.appearance().barTintColor = UIColor.appTintColor
    UINavigationBar.appearance().tintColor = UIColor.appTintColor
    UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.appTintColor]
    
    return true
  }
}

