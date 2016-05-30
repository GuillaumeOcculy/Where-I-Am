//
//  ViewController.swift
//  Where Am I
//
//  Created by Guillaume on 30/05/16.
//  Copyright © 2016 Guillaume. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    var manager:CLLocationManager!
    
    
    @IBOutlet var latitudeLabel: UILabel!
    @IBOutlet var longitudeLabel: UILabel!
    @IBOutlet var courseLabel: UILabel!
    @IBOutlet var speedLabel: UILabel!
    @IBOutlet var altitudeLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        
        
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        
        var userLocation:CLLocation = locations[0]
        self.latitudeLabel.text = "\(userLocation.coordinate.latitude)"
        self.longitudeLabel.text = "\(userLocation.coordinate.longitude)"
        self.courseLabel.text = "\(userLocation.course)"
        self.speedLabel.text = "\(userLocation.speed)"
        self.altitudeLabel.text = "\(userLocation.altitude)"
        
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemarks, error) in
            
            
            if (error != nil) {
                print(error)
            } else {
                if let p =  placemarks?[0] {
                    var subThoroughfare:String = ""
                    if (p.subThoroughfare != nil){
                        subThoroughfare = p.subThoroughfare!
                    }
                    print(p)
                    self.addressLabel.text = "\(p.thoroughfare) \n\(p.subLocality) \n\(p.subAdministrativeArea) \n\(p.postalCode) \n \(p.country)"
                }
            }
        }
    }
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

