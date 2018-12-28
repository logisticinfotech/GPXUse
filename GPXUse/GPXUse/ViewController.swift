//
//  ViewController.swift
//  GPXUse
//
//  Created by Bhavin on 26/12/18.
//  Copyright © 2018 Logistic Infotech PVT LTD. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController,AppDelegateLocationUpdateDelegate {

    @IBOutlet weak var mapView: GMSMapView!
    var cameraupdate:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        AppDelegate.SharedDelegate().appDelegateLocationUpdateDelegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        
        if AppDelegate.SharedDelegate().currentLocation != nil{
            cameraupdate = true
            let camera = GMSCameraPosition.camera(withLatitude: AppDelegate.SharedDelegate().currentLocation.coordinate.latitude,
                                                  longitude: AppDelegate.SharedDelegate().currentLocation.coordinate.longitude,
                                                  zoom: 16)
            mapView.camera = camera
        }
    }
    
    func currentLocationUpdate(_ location: CLLocation) {
        
        if cameraupdate == false{
            cameraupdate = true
            let camera = GMSCameraPosition.camera(withLatitude: AppDelegate.SharedDelegate().currentLocation.coordinate.latitude,
                                                  longitude: AppDelegate.SharedDelegate().currentLocation.coordinate.longitude,
                                                  zoom: 16)
            mapView.camera = camera
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

