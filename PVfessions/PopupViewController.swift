//
//  PopupViewController.swift
//  PVfessions
//
//  Created by Justin Matsnev on 3/13/17.
//  Copyright © 2017 PVfessions Inc. All rights reserved.
//

import Foundation
import UIKit
import CNPPopupController

class PopupViewController : UIViewController, CNPPopupControllerDelegate {
    
    var popupController : CNPPopupController?

    func showPopup(_ popupStyle: CNPPopupStyle) {

        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont(name: "HelveticaNeue", size: 18)
        titleLabel.text = "Share a story"
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1.0)
        
        let closeButton = CNPPopupButton.init(frame: CGRect(x: 0, y: 0, width: 300, height: 60))
        closeButton.setTitleColor(UIColor.white, for: UIControlState())
        closeButton.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 18)
        closeButton.setTitle("Back", for: UIControlState())
        closeButton.layer.borderColor = UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1.0).cgColor
        closeButton.layer.borderWidth = 3.0
        closeButton.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        
        closeButton.layer.cornerRadius = 4
        closeButton.selectionHandler = { button in
            self.popupController?.dismiss(animated: true)
        }
        let textField = UITextView.init(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
        textField.layer.cornerRadius = 4.0
        textField.textAlignment = .center
        
        let joinButton = CNPPopupButton.init(frame: CGRect(x: 0, y: 0, width: 300, height: 60))
        joinButton.setTitleColor(UIColor.white, for: UIControlState())
        joinButton.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 18)
        joinButton.setTitle("Join Event", for: UIControlState())
        joinButton.layer.borderColor = UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1.0).cgColor
        joinButton.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        joinButton.layer.borderWidth = 3.0
        joinButton.layer.cornerRadius = 4
        joinButton.selectionHandler = { (button) -> Void in
            
        }
        
        let popupController = CNPPopupController(contents:[titleLabel,textField, joinButton, closeButton])
        popupController.theme = CNPPopupTheme.default()
        popupController.theme.popupStyle = popupStyle
        popupController.delegate = self
        self.popupController? = popupController
        popupController.present(animated: true)
    }
    
    
    
    func popupControllerWillDismiss(_ controller: CNPPopupController) {
        print("Popup controller will be dismissed")
    }
    
    func popupControllerDidPresent(_ controller: CNPPopupController) {
        print("Popup controller presented")
    }
}

