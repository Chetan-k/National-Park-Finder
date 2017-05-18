//
//  SecondViewController.swift
//  NPF-4
//
//  Created by Chetan R Kanthala on 5/4/17.
//  Copyright © 2017 Chetan R Kanthala. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Foundation


class TableVC: UITableViewController, CLLocationManagerDelegate {
    
    var mapVC: MapVC!
    let locationManager = CLLocationManager()
    
    var parkLists = Wrapper()
    var parks : [Park] {
        get {
            return self.parkLists.parkList!
        }
        set(val) {
            self.parkLists.parkList = val
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func TableviewParks(_ sender: Any) {
        switch((sender as AnyObject).selectedSegmentIndex){
        case 0:
            parks.sort(by: {$0.getParkName() < $1.getParkName()})
            self.tableView.reloadData()
        case 1:
            parks.sort(by: {$0.getParkName() > $1.getParkName()})
            self.tableView.reloadData()
        case 2:
            print("-----------")
            print("sort parks according to the distance from the user!")
        default:
            break
        }

    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func  tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ParkCell", for: indexPath)
        
        // cell building
        let park = parks[indexPath.row]
        cell.textLabel?.text = park.getParkName()
        let userlocation = locationManager.location?.coordinate
        let userLocate = CLLocation(latitude: userlocation!.latitude, longitude: userlocation!.longitude)
        let distance = userLocate.distance  (from: park.getlocation()!)
        cell.detailTextLabel?.text = String(round(distance/1609.344)) + " Miles"
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let park = parks[indexPath.row]
        let detailVC = ParkDetailTableVC(style: .grouped)
        detailVC.title = park.title
        detailVC.park = park
        detailVC.zoomDelegate = mapVC
        navigationController?.pushViewController(detailVC, animated: true)
    }

}

