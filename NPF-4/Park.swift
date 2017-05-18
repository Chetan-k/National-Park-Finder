//
//  Park.swift
//  NPF-4
//
//  Created by Chetan R Kanthala on 5/4/17.
//  Copyright © 2017 Chetan R Kanthala. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

class Park:NSObject, MKAnnotation{
    
    private var location: CLLocation?
    private var imageLink: String = ""
    private var parkDescription: String = ""
    
    private var parkName : String = ""
    private var parkLocation : String = ""
    private var dateFormed : String = ""
    private var area : String  = ""
    private var link : String = ""
    private var imageName: String = ""
    private var imageSize: String = ""
    private var imageType: String = ""
    
    override var description: String {
        
        return "parkName: \(parkName)\nparkLocation: \(parkLocation)\ndateFormed: \(dateFormed)\narea: \(area)\nlink: \(link)\nimageName: \(imageName)\nimageSize: \(imageSize)\nimageType: \(imageType)\nlocation: \(location!)\nimageLink: \(imageLink)\nparkDescription: \(parkDescription)"
    }
    
    override var debugDescription: String {
        return "Something went wrong!! please check it"
    }
    
    init(parkName: String,parkLocation: String, dateFormed: String, area: String, link: String, location: CLLocation?, imageLink: String, parkDescription: String, imageName: String, imageSize: String, imageType: String) {
        
        super.init()
        //check condition for parkName
        let trimmedString = parkName.trimmingCharacters(in: .whitespaces)
        
        //        let trimmedString1 = removeWhiteSpaces(text: parkName)
        let count = 4..<75
        if count.contains(trimmedString.characters.count){
            set(parkName: trimmedString)
        }else{
            print("Bad value of \(parkName) in setParkName: setting to TBD")
            //            set(parkName: "TBD")
            self.parkName = "TBD"
        }
        
        //check condition for parkLocation
        let trimmedStringLoc = parkLocation.trimmingCharacters(in: .whitespaces)
        //        let trimmedStringLoc1 = removeWhiteSpaces(text: parkLocation)
        if count.contains(trimmedStringLoc.characters.count){
            set(parkLocation: trimmedStringLoc)
        }else{
            print("Bad value of \(parkLocation) in setParkLocation: setting to TBD")
            //            set(parkLocation: "TBD")
            self.parkLocation = "TBD"
        }
        
        set(dateFormed: dateFormed)
        set(area: area)
        set(link: link)
        self.location = location
        set(imageLink: imageLink)
        set(parkDescription: parkDescription)
        set(imageName: imageName)
        set(imageSize: imageSize)
        set(imageType: imageType)
        
        
    }
    
    @objc var coordinate: CLLocationCoordinate2D {
        get {
            return location!.coordinate
        }
    }
    
    //optional - required with set callout true
    @objc var title : String? {
        get {
            return parkName
        }
    }
    
    @objc var subtitle : String? {
        get {
            return parkLocation
        }
    }
    
    
    convenience override init() {
        self.init(parkName: "Unknown",parkLocation: "Unknown", dateFormed: "Unknown", area: "Unknown", link: "Unknown", location: nil, imageLink: "Unknown", parkDescription: "Unknown", imageName: "Unknown", imageSize: "Unknown", imageType: "Unknown")
    }
    
    //Can also be implemented using this function to check the trailing and leading white spaces-- this will also remove any extra spaces in between the words..used methods (swift inbuilt methods) dont work
    func removeWhiteSpaces(text:String ) -> String {
        
        var result:String = ""
        var whiteChar = " " // white space
        for char in text.characters {
            
            let currentChar = String( char )
            if !( whiteChar == " " && currentChar == whiteChar )
            {
                result.append( currentChar )
            }
            whiteChar = currentChar
        }
        return result
    }
    
    
    func getParkName() -> String {
        return parkName
    }
    
    func set(parkName: String){
        //for trimming whitespaces in the string
        let trimmedString = parkName.trimmingCharacters(in: .whitespaces)
        //        let trimmedString1 = removeWhiteSpaces(text: parkName)
        let characterBound = 4..<75
        if characterBound.contains(trimmedString.characters.count) {
            self.parkName = trimmedString
        }else {
            print("Bad value of \(parkName) in setParkName: Setting to TBD")
            self.parkName = "TBD"
        }
    }
    
    func getParkLocation() -> String {
        return parkLocation
    }
    
    func set(parkLocation: String){
        //for trimming whitespaces from the string
        let trimmedString = parkLocation.trimmingCharacters(in: .whitespaces)
        //        let trimmedString1 = removeWhiteSpaces(text: parkLocation)
        let characterBound = 4..<75
        if characterBound.contains(trimmedString.characters.count) {
            self.parkLocation = trimmedString
        }else {
            print("Bad value of \(parkLocation) in setParkLocation: Setting to TBD")
            self.parkLocation = "TBD"
        }
    }
    
    func getdateFormed() -> String {
        return dateFormed
    }
    
    func set(dateFormed: String){
        self.dateFormed = dateFormed
    }
    
    func getarea() -> String {
        return area
    }
    
    func set(area: String){
        self.area = area
    }
    
    func getlink() -> String {
        return link
    }
    
    func set(link: String){
        self.link = link
    }
    
    func getlocation() -> CLLocation? {
        return location
    }
    
    func set(location: CLLocation){
        self.location = location
    }
    
    func getimageLink() -> String {
        return imageLink
    }
    
    func set(imageLink: String){
        self.imageLink = imageLink
    }
    
    func getparkDescription() -> String {
        return parkDescription
    }
    
    func set(parkDescription: String){
        self.parkDescription = parkDescription
    }
    
    func getimageName()-> String{
        return imageName
    }
    
    func set(imageName: String){
        self.imageName = imageName
    }
    
    func getimageSize()-> String{
        return imageSize
    }
    
    func set(imageSize: String){
        self.imageSize = imageSize
    }
    
    func getimageType()-> String{
        return imageType
    }
    
    func set(imageType: String){
        self.imageType = imageType
    }
    
}

