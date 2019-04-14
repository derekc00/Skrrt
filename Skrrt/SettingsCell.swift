//
//  SettingsCell.swift
//  Skrrt
//
//  Created by Derek Chang on 4/14/19.
//  Copyright © 2019 Derek Chang. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import Parse

class SettingsCell: UITableViewCell {

    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var toggleSwitch: UISwitch!
    
    var fbViewController: UIViewController = UIViewController()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func clickButton(_ sender: Any) {
        let fbLoginManager: FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["email"], from: fbViewController) { (result, error) in
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
                    print(faceDic)
                    print(result!)
                    let email = faceDic["email"] as! String
                    print(email)
                    let id = faceDic["id"] as! String
                    print(id)
                    
                    
                    
                    let currentUser = PFUser.current() as! PFUser
                    currentUser["email"] = faceDic["email"] as! String
                    currentUser["name"] = "DADADD"
                    print("Added attributes")
                    currentUser.saveInBackground()
                
                }
            })
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
