//
//  ConfessionMakerViewController.swift
//  PVfessions
//
//  Created by Justin Matsnev on 3/13/17.
//  Copyright © 2017 PVfessions Inc. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import Firebase

class ConfessionMakerViewController : UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    @IBOutlet var submitButton : UIButton!
    @IBOutlet var storyTextView : UITextView!
    @IBOutlet var textField : UITextField!
    @IBOutlet var pickerView : UIPickerView!
    var colleges = ["Penn State", "University of Michigan", "Indiana University",
                    "UPenn","Syracuse University", "UF"]
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        self.submitButton.layer.cornerRadius = 3
        self.submitButton.layer.borderWidth = 2.0
        self.submitButton.layer.borderColor = UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1.0).cgColor
        self.storyTextView.layer.cornerRadius = 3
        self.storyTextView.layer.borderWidth = 2.0
        self.storyTextView.layer.borderColor = UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1.0).cgColor
        self.textField.delegate = self
        self.textField.returnKeyType = .done
        self.textField.layer.borderColor = UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1.0).cgColor

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool     {
        textField.resignFirstResponder()
        return true
    }

    
    @IBAction func submit() {
        
    }
   
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return colleges.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return colleges[row]
    }
    
}
