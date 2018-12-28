//
//  AppDelegate.swift
//  GPXUse
//
//  Created by Bhavin on 26/12/18.
//  Copyright © 2018 Logistic Infotech PVT LTD. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps

@objc protocol AppDelegateLocationUpdateDelegate : NSObjectProtocol
{
    @objc optional func currentLocationUpdate(_ location:CLLocation)
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,CLLocationManagerDelegate {


    let locationManager = CLLocationManager()
//    let apikey: String = "Please google map apk key."
    var window: UIWindow?
    var appDelegateLocationUpdateDelegate: AppDelegateLocationUpdateDelegate?
    
    var currentLocation:CLLocation!

    class func SharedDelegate () -> AppDelegate
    {
        return UIApplication.shared.delegate as! AppDelegate
    }


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        if CLLocationManager.locationServicesEnabled()
        {
            switch(CLLocationManager.authorizationStatus())
            {
            case .authorizedAlways, .authorizedWhenInUse:
                locationManager.startUpdatingLocation()
                break
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
                break
            case .restricted:
                print("Restricted.")
                break
            case .denied:
                UIApplication.shared.open(URL(string:UIApplicationOpenSettingsURLString)!, options: [:], completionHandler: nil)
            }
        }
        GMSServices.provideAPIKey(apikey)
        return true
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
    {
        if status == .authorizedWhenInUse
        {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        self.currentLocation = locations.last! as CLLocation
        
        if (self.appDelegateLocationUpdateDelegate != nil && (self.appDelegateLocationUpdateDelegate?.responds(to: #selector(self.appDelegateLocationUpdateDelegate?.currentLocationUpdate(_:))))!)
        {
            self.appDelegateLocationUpdateDelegate?.currentLocationUpdate!(locations.last! as CLLocation)
        }
        print("User current location===>>",locations)
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

