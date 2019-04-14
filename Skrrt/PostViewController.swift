//
//  PostViewController.swift
//  Skrrt
//
//  Created by Derek Chang on 4/13/19.
//  Copyright © 2019 Derek Chang. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {

    @IBOutlet weak var personType: UISegmentedControl!
    
    @IBOutlet weak var departureTextField: UITextField!
    
    @IBOutlet weak var destinationTextField: UITextField!
    
    @IBOutlet weak var departureDate: UIDatePicker!
    
    @IBOutlet weak var comingBackType: UISegmentedControl!
    
    @IBOutlet weak var returnDate: UIDatePicker!
    
    @IBOutlet weak var comingBackLabel: UILabel!
    
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if comingBackType.selectedSegmentIndex == 0{
            comingBackLabel.isHidden = true
            returnDate.isHidden = true
        }
        else{
            comingBackLabel.isHidden = false
            returnDate.isHidden = false
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
