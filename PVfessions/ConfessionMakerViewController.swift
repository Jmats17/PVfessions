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

class ConfessionMakerViewController : UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UITextViewDelegate{
    
    @IBOutlet var submitButton : UIButton!
    @IBOutlet var storyTextView : UITextView!
    @IBOutlet var textField : UITextField!
    @IBOutlet var pickerView : UIPickerView!
    var colleges = ["Penn State", "University of Michigan", "Indiana University",
                    "UPenn","Syracuse University", "UF"]
    let ref = FIRDatabase.database().reference().child("confessions")
    var schoolChosen : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        self.submitButton.layer.cornerRadius = 4
       
        self.storyTextView.layer.cornerRadius = 4
        self.storyTextView.layer.borderWidth = 1.0
        self.storyTextView.layer.borderColor = UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1.0).cgColor
        
        self.textField.delegate = self
        self.textField.returnKeyType = .done
        self.textField.layer.borderWidth = 1.0

        self.textField.layer.borderColor = UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1.0).cgColor
        
        storyTextView.delegate = self

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool     {
        textField.resignFirstResponder()
        return true
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        let college = colleges[row]
        return NSAttributedString(string: college, attributes: [NSForegroundColorAttributeName:UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1.0)])
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    
    @IBAction func submit() {
        let schoolChosenIndexValue = pickerView.selectedRow(inComponent: 0)
        let school = colleges[schoolChosenIndexValue]
        if let text = storyTextView.text {
            if let textFromTextField = textField.text {
                let confession = [
                    "story" : text,
                    "school" : school,
                    "henna" : textFromTextField
                    ] as [String : Any]
                ref.childByAutoId().setValue(confession)
                self.dismiss(animated: true, completion: nil)
            }
            else {
                let confession = [
                    "story" : text,
                    "school" : school,
                    "henna" : ""
                    ] as [String : Any]
                ref.childByAutoId().setValue(confession)
                self.dismiss(animated: true, completion: nil)
            }
            
        }
        else {
            
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        schoolChosen = colleges[row]
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
