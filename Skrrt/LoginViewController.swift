//
//  LoginViewController.swift
//  Skrrt
//
//  Created by Derek Chang on 4/13/19.
//  Copyright © 2019 Derek Chang. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signIn(_ sender: Any) {
        let username = usernameTextField.text!
        let password = passwordTextField.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            if user != nil{
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }else{
                print("error: \(error?.localizedDescription)")
            }
        }
        
    }
    @IBAction func signUp(_ sender: Any) {
        let user = PFUser()
        
        user.username = usernameTextField.text!
        user.password = passwordTextField.text!
        
        user.signUpInBackground { (success, error) in
            if success {
                self.performSegue(withIdentifier: "login", sender: nil)
            }else{
                print("Error:  \(String(describing: error?.localizedDescription))")
            }
            
        }
    }
    
    @IBAction func screenTap(_ sender: Any) {
        self.view.endEditing(true)
        print("ended Editing")
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
