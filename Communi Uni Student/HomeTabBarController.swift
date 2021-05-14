//
//  HomeTabBarController.swift
//  Communi Uni
//
//  Created by BC Swift Student Loan 1 on 5/9/21.
//

import UIKit

class HomeTabBarController: UITabBarController {
    
    let userDefault = UserDefaults.standard
    let signedIn = UserDefaults.standard.bool(forKey: "usersignedin")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("**** User logged in.")
        
        self.userDefault.set(true, forKey: "usersignedin")
        self.userDefault.synchronize()
        
    }

}
