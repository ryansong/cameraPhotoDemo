//
//  SYBAppDelegate.h.swift
//  cameraPhotoDemo
//
//  Created by Ryan on 5/3/17.
//  Copyright © 2017 Song Xiaoming. All rights reserved.
//

import UIKit

@UIApplicationMain
class SYBAppDelegate: UIResponder, UIApplicationDelegate{
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
    
        self.window = UIWindow();
        self.window?.makeKeyAndVisible()
        
        let rootVC = UINavigationController.init(rootViewController: SYBCollectionViewController())
        self.window?.rootViewController = rootVC
        return true;
    }
    
}
