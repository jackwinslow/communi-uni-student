//
//  ProfileViewController.swift
//  Communi Uni Student
//
//  Created by BC Swift Student Loan 1 on 5/14/21.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var studentImageView: UIImageView!
    
    let userDefault = UserDefaults.standard
    
    let firstname = UserDefaults.standard.string(forKey: "userFirstName")
    let lastname = UserDefaults.standard.string(forKey: "userLastName")

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        nameLabel.text = "\(firstname ?? "Name Not Found") \(lastname ?? "")"
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
        self.userDefault.set("", forKey: "userFirstName")
        self.userDefault.set("", forKey: "userLastName")
        self.userDefault.synchronize()
        
        transitionToWelcome()
    }
    
}
