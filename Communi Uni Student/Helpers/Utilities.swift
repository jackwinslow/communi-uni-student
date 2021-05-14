//
//  Utilities.swift
//  Communi Uni
//
//  Created by BC Swift Student Loan 1 on 5/8/21.
//

import Foundation
import UIKit

class Utilities {
    
    static func styleTextField(_ textfield:UITextField){
        
        // Create the bottom line
        let bottomLine = CALayer()

        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)

        bottomLine.backgroundColor = UIColor(named: "PrimaryColor")?.cgColor

        // Remove border on text field
        textfield.borderStyle = .none
        
        textfield.layer.masksToBounds = true

        // Add the line to the text field
        textfield.layer.addSublayer(bottomLine)
        
    }
    
    static func styleFilledButton(_ button:UIButton) {
        
        // Filled rounded corner style
        button.backgroundColor = UIColor(named: "PrimaryColor")
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.white
        
    }
    
    static func styleHollowButton(_ button:UIButton) {
        
        // Hollow rounded corner style
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor(named: "SecondaryColor")?.cgColor
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor(named: "PrimaryColor")
        
    }
    
    static func isPasswordValid(_ password:String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&]).{8,}$")
        return passwordTest.evaluate(with: password)
        
    }
}
