//
//  FeedViewController.swift
//  Skrrt
//
//  Created by Derek Chang on 4/13/19.
//  Copyright © 2019 Derek Chang. All rights reserved.
//

import UIKit
import Parse
import MapKit

class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var posts = [PFObject]()
    
    

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        
        // Do any additional setup after loading the view.
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
        
        //idenfication cell + Details cell
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsCell") as! DetailsCell
        
        //            cell.departureLabel.text = (post["Departure"] as! String)
        //            cell.destinationLabel.text = (post["Destination"] as! String)
        //
        
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
