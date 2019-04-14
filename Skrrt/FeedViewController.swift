//
//  FeedViewController.swift
//  Skrrt
//
//  Created by Derek Chang on 4/13/19.
//  Copyright © 2019 Derek Chang. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage
import MapKit

class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    var posts = [PFObject]()
    var fbposts = [[String: Any]]()
    
    

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        
        //pull data from facebook
        let url = URL(string: "https://graph.facebook.com/2302470539844395/feed?limit=5&access_token=EAAEq2boOzVsBABi0f8WRRZBYawEuPdWAbHeRw5aLlcDlaMwGJ5BKUbvXhghycVdtGPZCZADJZBUD1VGH1IagI9jQZA0f5zyAYkjCCOA0nclBfCbm3Lv3DZCPL6gNKQuw07pZAtVQqlPHqZBRvkhMDZBdw4owQd9ZCnlwo2kqdy69zpggZDZD")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                self.fbposts = dataDictionary["data"] as? [[String:Any]] ?? []
                print(self.fbposts)
                
                //Call the functions again after downloading the data
                self.tableView.reloadData()
                
                
                // TODO: Get the array of movies
                // TODO: Store the movies in a property to use elsewhere
                // TODO: Reload your table view data
                
            }
        }
        task.resume()
    }
    
    
    @IBAction func tappedDetailsCell(_ sender: Any) {
        
        var mapItems = [MKMapItem]()
        
//        performSegue(withIdentifier: "details", sender: nil)
        
        
        let departureLatitude:CLLocationDegrees = 39.048825
        let departureLongitude:CLLocationDegrees = -120.981227
        
        let regionDistance:CLLocationDistance = 1000;
        let departureCoordinates = CLLocationCoordinate2DMake(departureLatitude, departureLongitude)
        
        let departurePlacemark = MKPlacemark(coordinate: departureCoordinates)
        let departureMapItem = MKMapItem(placemark: departurePlacemark)
//        departureMapItem.name
        mapItems.append(departureMapItem)

        
        
        
        let destinationLatitude:CLLocationDegrees = 34.039989
        let destinationLongitude:CLLocationDegrees = -118.255319
        
        let destinationCoordinates = CLLocationCoordinate2DMake(destinationLatitude, destinationLongitude)
        
        let destinationPlacemark = MKPlacemark(coordinate: destinationCoordinates)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        mapItems.append(destinationMapItem)
        
        let regionSpan = MKCoordinateRegion(center: departureCoordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        
        
        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
        
        
        
        
        
//        mapItem.openMaps(launchOptions: )
        MKMapItem.openMaps(with: mapItems, launchOptions: options)
    }
    
    
    //updates the tableview
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        let query = PFQuery(className:"Posts")
//        //Fetch the actual object
//        query.includeKeys(["author", "Comments", "Comments.author"])
//        //last 20 queries
//        query.limit = 20
//
//        query.findObjectsInBackground { (posts, error) in
//            if posts != nil{
//                self.posts = posts!
//                print(self.posts)
//                //Reload the table after the array is populated
//                self.tableView.reloadData()
//            }
//        }
//    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "details"{
            
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Posts")
        query.includeKeys(["Author, Departure, Destination, Date, Price"])
        
        
        query.limit = 20
        
        query.findObjectsInBackground { (posts, error) in
            if posts != nil{
                self.posts = posts!
                print(self.posts)
                //Reload the table after the array is populated
                self.tableView.reloadData()
            }
        }
        
        
    }
    

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return CGFloat.init(190)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsCell") as! DetailsCell
        
        let post = posts[indexPath.row]
        
        cell.departureLabel.text = (post["Departure"] as! String)
        cell.destinationLabel.text = (post["Destination"] as! String)
        
        let user = post["Author"] as! PFUser
        
        let imageFile = user["ProfilePicture"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        cell.profilePicture.af_setImage(withURL: url)
        
        //seats
        let numSeats = post["Seats"] as! Int
        if numSeats == 0{
            cell.seatsLabel.text = "O O O"
        }
        else if numSeats == 1{
            cell.seatsLabel.text = "X O O"
        }
        else if numSeats == 2{
            cell.seatsLabel.text = "X X O"
        }
        else{
            cell.seatsLabel.text = "X X X"
        }
        
        //Format the first string
        let price = post["Price"] as! Int
        let isOneWay = post["Oneway"] as! Bool
        var firstString = "$" + String(price)

        if isOneWay{
            firstString += "  -  One-Way"
        }
        else{
            firstString += "  -  Two-Way"
        }
        cell.priceLabel.text = firstString
        
        //formatting the date
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let myString = formatter.string(from: post["Date"] as! Date) // string purpose I add here
        // convert your string to date
        let yourDate = formatter.date(from: myString)
        //then again set the date format whhich type of output you need
        formatter.dateFormat = "MMM dd, yyyy  hh:mm a"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        // again convert your date to string
        let myStringafd = formatter.string(from: yourDate!)
        
        cell.dateLabel.text = myStringafd
        return cell
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
