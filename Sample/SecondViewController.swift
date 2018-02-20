//
//  SecondViewController.swift
//  Sample
//
//  Created by SysBig on 16/10/17.
//  Copyright © 2017 SysBig. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class SecondViewController: UIViewController
{
    @IBOutlet weak var destinationTextField: UITextField!
    @IBOutlet weak var sourceTextField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    var latitude = String()
    var longitude = String()
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestAlwaysAuthorization()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
extension SecondViewController : CLLocationManagerDelegate
{
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
    {
        switch status {
        case .authorizedAlways,.authorizedWhenInUse:
            self.locationManager.startUpdatingLocation()
        case .notDetermined:
            self.locationManager.requestWhenInUseAuthorization()
        case.denied,.restricted:
            break
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        print("Updated locations = \(locValue.latitude) \(locValue.longitude)")
        latitude = "\(locValue.latitude)"
        longitude = "\(locValue.longitude)"
        self.locationManager.stopUpdatingLocation()
        self.locationManager.delegate = nil
        self.gettingUserLocation()
    }
    func gettingUserLocation()
    {
        //let location = "Bangalore"
        let geoCoder = CLGeocoder()
        let placeLocLat = self.locationManager.location?.coordinate.latitude
        let placeLocLang = self.locationManager.location?.coordinate.longitude

        if placeLocLat != nil && placeLocLang != nil
        {
        let placeLoc = CLLocation(latitude: placeLocLat!, longitude: placeLocLang!)
        
        geoCoder.reverseGeocodeLocation(placeLoc, completionHandler: { (placemarks, error) -> Void in
            
            if (error != nil) {
                
                print("Reverse geocoder failed with error" + error!.localizedDescription)
            }
            
            if (placemarks?.count)! > Int(0)
            {
                let topResult:CLPlacemark = placemarks![0]
                let placemark: MKPlacemark = MKPlacemark(placemark: topResult)
                
                var region: MKCoordinateRegion = self.mapView.region
                region.center = (placemark.location?.coordinate)!
                region.span.longitudeDelta /= 8.0
                region.span.latitudeDelta /= 8.0
                self.mapView.setRegion(region, animated: true)
                self.mapView.addAnnotation(placemark)
            }
        })
        }
        else
        {
         // No Locations
        }
    }
}
