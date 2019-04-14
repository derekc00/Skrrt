//
//  FacebookViewController.swift
//  Skrrt
//
//  Created by Derek Chang on 4/14/19.
//  Copyright © 2019 Derek Chang. All rights reserved.
//

import UIKit
import FacebookLogin
import FBSDKCoreKit
import FBSDKLoginKit

class FacebookViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    @IBOutlet weak var tableView: UITableView!
    
    let schools = [ "CSU Bakersfield",
                        "CSU Channel Islands",
                        "CSU Chico",
                        "CSU Dominguez Hills",
                        "CSU East Bay",
                        "CSU Fresno",
                        "CSU Fullerton",
                        "Humboldt State University",
                        "CSU Long Beach",
                        "CSU Los Angeles",
                        "UC Berkeley",
                        "UC Davis",
                        "UC Irvine",
                        "UCLA",
                        "UC Merced",
                        "UC Riverside",
                        "UC San Diego",
                        "UC San Francisco"
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        self.tabBarController?.tabBar.isHidden = true
        
        tableView.rowHeight = 81
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schools.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell") as! SettingsCell
        
        if indexPath.row == 0{
            cell.label.text = "facebook"
            
            
        }
        else{
            cell.label.text = schools[indexPath.row]
            cell.label.textColor = .black
            cell.label.font = UIFont(name: "HelveticaNeue", size: 14)
        }
        cell.fbViewController = self
        
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
