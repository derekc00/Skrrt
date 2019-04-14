//
//  ProfileViewController.swift
//  Skrrt
//
//  Created by Derek Chang on 4/13/19.
//  Copyright © 2019 Derek Chang. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

   
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var schoolLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profileImage.setRounded()
        
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        
        let fbLoginManager: FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if (error == nil){
                let fbLoginresult: FBSDKLoginManagerLoginResult = result!
                if fbLoginresult.grantedPermissions != nil{
                    if (fbLoginresult.grantedPermissions.contains("email")){
                        self.GetFBUserData()
                        fbLoginManager.logOut()
                    }
                }
            }
        }
        
    }
    
    func GetFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"])?.start(completionHandler: { (connection, result, error) in
                if (error == nil){
                    
                    
                    
                    let faceDic = result as! [String: AnyObject]
                    
                    let pic = faceDic["picture"] as! [String: AnyObject]
                    let picData = pic["data"]
                    let baseUrl = picData?["url"]
                    let url = URL(string: baseUrl as! String)!
                    
                    self.profileImage.af_setImage(withURL: url)
                    
                    let first_name = faceDic["fist_name"] as? String ?? "Derek"
                    let last_name = faceDic["last_name"] as? String ?? "Chang"
                    
                    self.nameLabel.text = first_name + " " + last_name
                    
                    
                    
                    
                    
//                    let currentUser = PFUser.current() as! PFUser
//                    currentUser["email"] = faceDic["email"] as! String
//                    currentUser["name"] = "DADADD"
//                    print("Added attributes")
//                    currentUser.saveInBackground()
                    
                }
            })
        }
    }
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsCell") as! ProfileHistoryCell
        if indexPath.row == 0{
            cell.isAvaliableLabel.text = "Avaliable"
            cell.departureLabel.text = "USC"
            cell.destinationLabel.text = "UCI"
            cell.seats.text = "O O O"
            cell.priceLabel.text = "$15 - One-Way"
            cell.dateLabel.text = "April 13, 2019 @ 3:00 pm"
        }else{
            cell.isAvaliableLabel.text = "Not Avaliable"
            cell.departureLabel.text = "UCI"
            cell.destinationLabel.text = "USC"
            cell.seats.text = "X X O"
            cell.priceLabel.text = "$15 - One-Way"
            cell.dateLabel.text = "April 11, 2019 @ 10:00 am"
        }
        
        
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
