//
//  FeedViewController.swift
//  Skrrt
//
//  Created by Derek Chang on 4/13/19.
//  Copyright © 2019 Derek Chang. All rights reserved.
//

import UIKit
import Parse

class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var posts = [PFObject]()
    
    

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        
        // Do any additional setup after loading the view.
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
    

    
    //SOMETHING IN SECTION IS PRESSED
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //CLICK on the details cell
        if indexPath.row == 1{
            //segue into the details view controller
        }
    }
    
    //HOW MANY SECTIONS THERE ARE
    func numberOfSections(in tableView: UITableView) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0{
            return CGFloat.init(65)
        }
        return CGFloat.init(230)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //idenfication cell + Details cell
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = posts[indexPath.section]
        
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "IdentificationCell") as! IdentificationCell
            
            let user = post["Author"] as! PFUser
            
            cell.nameLabel.text = user.username
            return cell
        }
        else{
            print("AAAA")
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsCell") as! DetailsCell
            
            cell.departureLabel.text = (post["Departure"] as! String)
            cell.destinationLabel.text = (post["Destination"] as! String)
            
            
            return cell
        }
        
       
        
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
