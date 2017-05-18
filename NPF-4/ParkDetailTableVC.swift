//
//  ParkDetailTableVC.swift
//  NPF-4
//
//  Created by Chetan R Kanthala on 5/4/17.
//  Copyright © 2017 Chetan R Kanthala. All rights reserved.
//

import UIKit
import Foundation
import MapKit
import CoreLocation


class ParkDetailTableVC: UITableViewController {
    
    //global variables
    let PARKNAME = 0
    let PARKLOCATION = 1
    let PARKDECRIPTION = 2
    let DATEFORMED = 3
    let PARKIMAGE = 4
    let PARKAREA = 5
    let PARKURL = 6
    let FAV = 7

    
    var park : Park!
    var zoomDelegate: ZoomingProtocol?
    var favParkArray:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 8
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "FavouritesCell")
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "FavouritesCell")
        }
        
        // Configure the cell...
        switch(indexPath.section) {
        case PARKNAME:
            cell!.textLabel?.text = park.getParkName()
        case PARKIMAGE:
            let url = URL(string: ("\(park.getimageLink())"))
            let data = try? Data(contentsOf: url!)
            let image = UIImage(data:data!)
            cell!.imageView?.image = image
        case PARKAREA:
            cell!.textLabel?.text = park.getarea()
        case PARKDECRIPTION:
            cell!.textLabel?.text = park.getparkDescription()
            cell!.textLabel?.numberOfLines = 5
        case PARKLOCATION:
            cell!.textLabel?.text = "Show on Map"
        case PARKURL:
            cell!.textLabel?.text = park.getlink()
            cell!.textLabel?.numberOfLines = 2
        case DATEFORMED:
            cell!.textLabel?.text = park.getdateFormed()
        case FAV:
            cell!.textLabel?.text = "Add to favourites"
        default:
            break;
        }
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var title = ""
        
        switch section {
        case PARKNAME:
            title =  "PARK NAME"
        case PARKLOCATION:
            title =  "PARK LOCATION"
        case PARKDECRIPTION:
            title =  "DESCRIPTION"
        case DATEFORMED:
            title =  "DATE FORMED"
        case PARKIMAGE:
            title =  "IMAGE"
        case PARKAREA:
            title =  "AREA"
        case PARKURL:
            title =  "URL"
        case FAV:
            title = "ADD TO FAVOURITES"
        default:
            break;
        }
        return title
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var msg = ""
        
        switch indexPath.section{
        case PARKNAME:
            msg = "You tapped Park Name"
        case PARKDECRIPTION:
            msg = "You tapped Park Description"
        case PARKLOCATION:
            //one of the best ways
            msg = "Opening location"
            zoomDelegate?.zoomOnAnnotation(park) //releases mapVC from memory since it has ownership
        //NSnotificaitonceneter is the other way
        case PARKURL:
            if let url = URL(string: park.getlink()){
                UIApplication.shared.openURL(url)
            }
        case FAV:
            msg = "\(park.getParkName()) added to fav!!"
            if !FavParksVC.favourites.contains(park){
                FavParksVC.favourites.append(park)
                UserDefaults.standard.set(favParkArray, forKey: "favorites")
                let alert = UIAlertController(title: "Success", message: "Park added to Favourites!", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }else {
                let alert = UIAlertController(title: "Failure", message: "Park already added in Favourites!", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        default:
            break
            
        }
        
        let alert = UIAlertController(title:"Sucess", message: msg, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(OKAction)
        present(alert, animated: true, completion: nil)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == PARKDECRIPTION || indexPath.section == PARKIMAGE{
            return 230.0
        } else{
            return 44.0
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
