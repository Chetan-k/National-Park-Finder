//
//  FirstViewController.swift
//  NPF-4
//
//  Created by Chetan R Kanthala on 5/4/17.
//  Copyright © 2017 Chetan R Kanthala. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, ZoomingProtocol {
    
    //outlets
    
    @IBOutlet weak var segmentedCtrl: UISegmentedControl!
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    var location : CLLocation?
    var flag: Bool = true
    
    var parkList = Wrapper()
    
    //LandmarkList model object
    var parks : [Park] {
        get {
            return self.parkList.parkList!
        }
        set(val) {
            self.parkList.parkList = val
        }
    }

    //for requesting user location authorization...
    required init?(coder aDecoder:NSCoder){
        locationManager = CLLocationManager()
        if CLLocationManager.locationServicesEnabled(){
            if
                locationManager.responds(to: #selector(CLLocationManager.requestWhenInUseAuthorization)) != nil {
                locationManager.requestWhenInUseAuthorization()
                
            }
        }
        super.init(coder: aDecoder)
    }
    
    //for zooming park annotations
    func zoomOnAnnotation(_ annotation: MKAnnotation){
        tabBarController?.selectedViewController = self
        let region = MKCoordinateRegionMakeWithDistance(annotation.coordinate, 5000, 5000)
        mapView.setRegion(region, animated: true)
        mapView.selectAnnotation(annotation, animated: true)
    }


    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        for list: Park in parks{
            mapView?.addAnnotation(list)
        }
        mapView?.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        mapView?.showsUserLocation = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //for differetn views of map
    @IBAction func mapSegment(_ sender: Any) {
        switch (segmentedCtrl.selectedSegmentIndex) {
        case 0:
            mapView!.mapType = .standard
        case 1:
            mapView!.mapType = .satellite
        default:
            mapView!.mapType = .hybrid
        }
    }
    
    @IBAction func zoomIn(_ sender: Any) {
        let userLocation = mapView!.userLocation
        let region = MKCoordinateRegionMakeWithDistance(userLocation.location!.coordinate, 20000, 20000)
        mapView!.setRegion(region, animated: true)
    }
    
    @IBAction func zoomOut(_ sender: Any) {
        let userLocation = mapView!.userLocation
        let region = MKCoordinateRegionMakeWithDistance(userLocation.location!.coordinate, 5000000, 5000000)
        mapView!.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var view:MKPinAnnotationView
        let identifier = "Pin"
        
        if annotation is MKUserLocation{
            return nil//use the blue dot
        }
        if annotation !== mapView.userLocation {
            //try to reuse the view
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
                dequeuedView.annotation =  annotation
                view = dequeuedView
            } else {
                //finish
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.pinTintColor = MKPinAnnotationView.purplePinColor()
                view.canShowCallout = true
                view.animatesDrop = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                let leftButton = UIButton(type: .infoLight)
                let rightButton = UIButton(type: .detailDisclosure)
                leftButton.tag = 0
                rightButton.tag = 1
                view.leftCalloutAccessoryView = leftButton
                view.rightCalloutAccessoryView = rightButton
                
            }
            return view
        }
        return nil
    }
    
    func mapView(_ mv: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let parkAnnotation = view.annotation as! Park
        switch control.tag {
            
        case 0: //left button
            if let url = URL(string: parkAnnotation.getlink()){
                UIApplication.shared.openURL(url)
            }
        case 1: //right button
            
            let parkLatitude = parkAnnotation.getlocation()?.coordinate.latitude
            let parkLongitude = parkAnnotation.getlocation()?.coordinate.longitude
            let location = CLLocation(latitude: parkLatitude!, longitude: parkLongitude!)
            
            CLGeocoder().reverseGeocodeLocation(location, completionHandler: { (placemark, error) -> Void in
                if placemark!.count > 0 {
                    let pm = placemark![0]
                    let addressDict = pm.addressDictionary as? [String: AnyObject]
                    let parkLocation2D: CLLocationCoordinate2D = location.coordinate
                    let place = MKPlacemark(coordinate: parkLocation2D, addressDictionary: addressDict)
                    let mapItem = MKMapItem(placemark: place)
                    let options = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
                    mapItem.openInMaps(launchOptions: options)
                }
            })
            
        default:
            break
        }
    }


}

