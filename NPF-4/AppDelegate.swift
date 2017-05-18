//
//  AppDelegate.swift
//  NPF-4
//
//  Created by Chetan R Kanthala on 5/4/17.
//  Copyright © 2017 Chetan R Kanthala. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var parks: [Park] = []
//    var tabBarController: UITabBarController!


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if let path = Bundle.main.path(forResource: "data", ofType: "plist") {
            
            let tempDict = NSDictionary(contentsOfFile: path)
            let tempArray = (tempDict!.value(forKey: "parks") as! NSArray) as Array
            
            //next step’s code will go here…
            //var parks : [Park] = []
            
            for dict in tempArray {
                
                let parkName = dict["parkName"]! as! String
                let parkLocation = dict["parkLocation"]! as! String
                let latitude = (dict["latitude"]! as! NSString).doubleValue
                let longitude = (dict["longitude"]! as! NSString).doubleValue
                let location = CLLocation(latitude: latitude, longitude: longitude)
                let dateFormed = dict["dateFormed"]! as! String
                let area = dict["area"]! as! String
                let link = dict["link"]! as! String
                let imageLink = dict["imageLink"]! as! String
                let parkDescription = dict["description"]! as! String
                let imageName = dict["imageName"]! as! String
                let imageSize = dict["imageSize"]! as! String
                let imageType = dict["imageType"]! as! String
                
                
                //you need to provide all of the values from the plist and possibly modify the initializer with any new values...
                
                let p = Park(parkName: parkName, parkLocation: parkLocation, dateFormed: dateFormed, area: area, link: link, location: location, imageLink: imageLink, parkDescription: parkDescription, imageName: imageName, imageSize: imageSize, imageType: imageType)
                parks.append(p)
            }
            
            //check to see if the parks were created correctly
            for p in parks {
                print("-----Park:-----\n\(p)\n")
            }
            
            let tabBarController = self.window?.rootViewController as! UITabBarController
            let mapView = tabBarController.viewControllers![0] as! MapVC
            mapView.parks = parks
            
            let navVC = tabBarController.viewControllers![1] as! UINavigationController
            
            let tableVC = navVC.viewControllers[0] as! TableVC
            tableVC.parks = parks
            tableVC.mapVC = mapView
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

