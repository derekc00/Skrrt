//
//  FilterViewController.swift
//  Skrrt
//
//  Created by Derek Chang on 4/14/19.
//  Copyright © 2019 Derek Chang. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {

    @IBOutlet weak var startingSchool: UITextField!
    @IBOutlet weak var destinationSchool: UITextField!
    @IBOutlet weak var highLowSort: UISegmentedControl!
    @IBOutlet weak var beginningDate: UIDatePicker!
    @IBOutlet weak var endingDate: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        // Do any additional setup after loading the view.
    }
    
    @IBAction func applyFilter(_ sender: Any) {
        performSegue(withIdentifier: "filteredApplied", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let view = segue.destination as? FeedViewController
            else{
                return
        }
        view.startingSchool = startingSchool.text!
        view.destinationSchool = destinationSchool.text!
        if highLowSort.selectedSegmentIndex == 0{
            view.lowtoHigh = true
        }
        else{
            view.lowtoHigh = false
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
