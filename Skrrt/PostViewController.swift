//
//  PostViewController.swift
//  Skrrt
//
//  Created by Derek Chang on 4/13/19.
//  Copyright © 2019 Derek Chang. All rights reserved.
//

import UIKit
import SearchTextField
import Parse

class PostViewController: UIViewController {

    override func viewDidLoad() {
    self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        returnDate.isHidden = true
        comingBackLabel.isHidden = true
        
    }
    
    let suggestions = [ "CSU Bakersfield",
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
    
    
    
    @IBOutlet weak var personType: UISegmentedControl!
    
    @IBOutlet weak var departureTextField: SearchTextField!
    
    @IBOutlet weak var destinationTextField: SearchTextField!
    
    
    @IBOutlet weak var departureDate: UIDatePicker!
    
    @IBOutlet weak var comingBackType: UISegmentedControl!
    
    @IBOutlet weak var returnDate: UIDatePicker!
    
    @IBOutlet weak var comingBackLabel: UILabel!
    
    @IBOutlet weak var priceTextField: UITextField!
    
    
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var seatsLabel: UILabel!
    
    @IBOutlet weak var seatsTextField: UITextField!
    
    @IBAction func valueChanged(_ sender: Any) {
        print(personType.selectedSegmentIndex)
        if personType.selectedSegmentIndex == 1{
            comingBackLabel.isHidden = true
            comingBackType.isHidden = true
            returnDate.isHidden = true
            departureDate.isHidden = true
            seatsTextField.isHidden = true
            seatsLabel.isHidden = true
        }
        else {
            print(":FDDSF")
            comingBackLabel.isHidden = true
            comingBackType.isHidden = false
            returnDate.isHidden = true
            departureDate.isHidden = false
            seatsLabel.isHidden = false
            seatsTextField.isHidden = false
        }
    }
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("A2")
        return !autoCompleteText( in : textField, using: string, suggestions: suggestions)
    }
    func autoCompleteText( in textField: UITextField, using string: String, suggestions: [String]) -> Bool {
        print("A1")
        if !string.isEmpty,
            let selectedTextRange = textField.selectedTextRange,
            selectedTextRange.end == textField.endOfDocument,
            let prefixRange = textField.textRange(from: textField.beginningOfDocument, to: selectedTextRange.start),
            let text = textField.text( in : prefixRange) {
            let prefix = text + string
            let matches = suggestions.filter {
                $0.hasPrefix(prefix)
            }
            if (matches.count > 0) {
                textField.text = matches[0]
                if let start = textField.position(from: textField.beginningOfDocument, offset: prefix.count) {
                    textField.selectedTextRange = textField.textRange(from: start, to: textField.endOfDocument)
                    return true
                }
            }
        }
        return false
    }

    @IBAction func dismissKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("A3")
        textField.resignFirstResponder()
        return true
    }
    @IBAction func isRoundTrip(_ sender: Any) {
        print("changed22")
        if comingBackType.selectedSegmentIndex == 0{
            comingBackLabel.isHidden = true
            returnDate.isHidden = true
        }
        else{
            comingBackLabel.isHidden = false
            returnDate.isHidden = false
        }
    }
   
    @IBAction func posting(_ sender: Any) {
        //pet is like a dictionary
        let post = PFObject(className: "Posts")
        post["Departure"] = departureTextField.text
        post["Destination"] = destinationTextField.text
        post["Date"] = departureDate.date
        post["Price"] = Int(priceTextField.text!) ?? 0
        post["Author"] = PFUser.current()!
        post["Seats"] = Int(seatsTextField.text ?? "1")
        
        if comingBackType.selectedSegmentIndex == 0{
             post["Oneway"] = true
        }
        else{
            post["Oneway"] = false
        }
       
        
        post.saveInBackground { (success, error) in
            if success{
                self.performSegue(withIdentifier: "post", sender: nil)
                print("saved!")
            }else{
                print("error: \(String(describing: error))")
            }
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
