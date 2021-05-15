//
//  ProfileViewController.swift
//  Communi Uni Student
//
//  Created by BC Swift Student Loan 1 on 5/14/21.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let userDefault = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // Call to send user back to welcome screen
    func transitionToWelcome() {
                
        let welcomeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.welcomeViewController) as? WelcomeViewController
        
        view.window?.rootViewController = welcomeViewController
        view.window?.makeKeyAndVisible()
        
    }

    @IBAction func studentSignOutButtonPressed(_ sender: Any) {
        print("**** User logged out.")
        
        self.userDefault.set(false, forKey: "usersignedin")
        self.userDefault.set("", forKey: "userEmail")
        self.userDefault.set("", forKey: "userPassword")
        self.userDefault.set(false, forKey: "userSchool")
        self.userDefault.synchronize()
        
        transitionToWelcome()
    }
    
}
