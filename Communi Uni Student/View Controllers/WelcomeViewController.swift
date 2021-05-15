//
//  ViewController.swift
//  Communi Uni Student
//
//  Created by BC Swift Student Loan 1 on 5/13/21.
//

import UIKit
import FirebaseAuth

class WelcomeViewController: UIViewController {
    
    let userDefault = UserDefaults.standard
    let signedIn = UserDefaults.standard.bool(forKey: "usersignedin")
    
    let email = UserDefaults.standard.string(forKey: "userEmail")
    let password = UserDefaults.standard.string(forKey: "userPassword")
    
    @IBOutlet weak var studentSignUpButton: UIButton!
    @IBOutlet weak var studentLoginButton: UIButton!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if signedIn == true {
            print("**** User already logged in. Proceeding to tab bar controller...")
            // Attempt login to firebase
            Auth.auth().signIn(withEmail: email!, password: password!) { result, error in
                
                // If no error signing in, transition to the home screen
                if error == nil {
                    
                    self.transitionToHome()
                    return
                    
                } else { // Error signing in, so locally save that user is logged out
                    
                    self.userDefault.set(false, forKey: "usersignedin")
                    self.userDefault.set("", forKey: "userEmail")
                    self.userDefault.set("", forKey: "userPassword")
                    self.userDefault.set("", forKey: "userSchool")
                    self.userDefault.synchronize()
                    
                }
                
            }
        }
        if signedIn == false {
            // Just for development purposes
            print("**** User not logged in")
        }
    }
    
    func transitionToHome() {
                
        let homeTabBarController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeTabBarController) as? HomeTabBarController
        
        view.window?.rootViewController = homeTabBarController
        view.window?.makeKeyAndVisible()
        
    }
    
    func setUpElements(){
        
        Utilities.styleFilledButton(studentSignUpButton)
        Utilities.styleHollowButton(studentLoginButton)
        
    }


}

