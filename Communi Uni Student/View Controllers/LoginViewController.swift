//
//  LoginViewController.swift
//  Communi Uni
//
//  Created by BC Swift Student Loan 1 on 5/8/21.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    @IBOutlet weak var studentEmailTextField: UITextField!
    @IBOutlet weak var studentPasswordTextField: UITextField!
    @IBOutlet weak var studentErrorLabel: UILabel!
    @IBOutlet weak var studentLoginButton: UIButton!
    @IBOutlet weak var studentBackButton: UIButton!
    
    
    
    let userDefault = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpElements()
        
        // hide keyboard if we tap outside of a field
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    func setUpElements() {
        
        // Hide the error label
        studentErrorLabel.alpha = 0
        
        // Style the elements
        Utilities.styleTextField(studentEmailTextField)
        Utilities.styleTextField(studentPasswordTextField)
        Utilities.styleFilledButton(studentLoginButton)
        Utilities.styleHollowButton(studentBackButton)
        
    }
    
    // Check the fields and validate that the data is correct. If everything is correct, this method returns nil. Otherwise, it returns the error message
    func validateFields() -> String? {
        
        // Check that all fields are filled in
        if studentEmailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || studentPasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields."
        }
        
        return nil
    }
    
    func showError(_ message:String) {
        studentErrorLabel.text = message
        studentErrorLabel.alpha = 1
    }
    
    func transitionToHome() {
        
        let homeTabBarController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeTabBarController) as? HomeTabBarController
        
        view.window?.rootViewController = homeTabBarController
        view.window?.makeKeyAndVisible()
        
    }
    
    @IBAction func studentLoginButtonTapped(_ sender: Any) {
        
        // Validate text fields
        let error = validateFields()
        
        if error != nil {
            
            // There's something wrong with the fields, show error message
            showError(error!)
            
        } else {
        
            // Create cleaned versions of the text fields
            let email = studentEmailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = studentPasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Signing in the user
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                
                if error != nil {
                    
                    // Couldn't sign in
                    self.studentErrorLabel.text = error!.localizedDescription
                    self.studentErrorLabel.alpha = 1
                    
                } else {
                    
                    // Save login info locally
                    self.userDefault.set(email, forKey: "userEmail")
                    self.userDefault.set(password, forKey: "userPassword")
                    self.userDefault.synchronize()
                    
                    // Transition to the home screen
                    self.transitionToHome()
                    
                }
            }
        }
    }
    

    
    @IBAction func studentBackButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

