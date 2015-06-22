//
//  ViewController.swift
//  Memorable Places
//
//  Created by Flavius Condurache on 22/06/15.
//  Copyright (c) 2015 Flavius Condurache. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet var map: MKMapView!
    
    var manager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
        if activePlace == -1 {
            manager.requestWhenInUseAuthorization()
            manager.startUpdatingLocation()
        } else {
            let latitude = NSString(string: places[activePlace]["lat"]!).doubleValue
            let longitude = NSString(string: places[activePlace]["long"]!).doubleValue
            var latDelta: CLLocationDegrees = 0.01
            var logDelta: CLLocationDegrees = 0.01
            
            var span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, logDelta)
            var coordonate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            var region: MKCoordinateRegion = MKCoordinateRegionMake(coordonate, span)
            self.map.setRegion(region, animated: true)
            
            var annotation = MKPointAnnotation()
            annotation.coordinate = coordonate
            annotation.title = places[activePlace]["name"]
            self.map.addAnnotation(annotation)
        }
    
        var uilpgr = UILongPressGestureRecognizer(target: self, action: "action:")
        uilpgr.minimumPressDuration = 2
        self.map.addGestureRecognizer(uilpgr)
    }
    
    func action(gestureRecognizer: UIGestureRecognizer) {
        if gestureRecognizer.state == UIGestureRecognizerState.Began {
            var touchPoint = gestureRecognizer.locationInView(self.map)
            var newCoordonates = self.map.convertPoint(touchPoint, toCoordinateFromView: self.map)
            var location = CLLocation(latitude: newCoordonates.latitude, longitude: newCoordonates.longitude)
            
            
            CLGeocoder().reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
                
                var title = ""
                
                if error == nil {
                    if let p = CLPlacemark(placemark: placemarks?[0] as! CLPlacemark) {
                        var subThoroughfare: String = ""
                        var thoroughfare: String = ""
                        
                        if p.subThoroughfare != nil {
                            subThoroughfare = p.subThoroughfare
                        }
                        
                        if p.thoroughfare != nil {
                            thoroughfare = p.thoroughfare
                        }
                        
                        title = "\(subThoroughfare) \(thoroughfare)"
                    }
                }
                
                if title == "" || title == " " {
                    title = "Added \(NSDate())"
                }
                
                println(title)
            
                places.append(["name": title, "lat": "\(newCoordonates.latitude)", "long": "\(newCoordonates.longitude)"])
                NSUserDefaults.standardUserDefaults().setObject(places, forKey: "places")
                var annotation = MKPointAnnotation()
                annotation.coordinate = newCoordonates
                annotation.title = title
                self.map.addAnnotation(annotation)
                
            })
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        //println(locations)
        
        var userLocation: CLLocation = locations[0] as! CLLocation
        
        var latitude = userLocation.coordinate.latitude
        var longitude = userLocation.coordinate.longitude
        
        var latDelta: CLLocationDegrees = 0.01
        var logDelta: CLLocationDegrees = 0.01
        
        var span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, logDelta)
        var coordonate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        var region: MKCoordinateRegion = MKCoordinateRegionMake(coordonate, span)
        self.map.setRegion(region, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

