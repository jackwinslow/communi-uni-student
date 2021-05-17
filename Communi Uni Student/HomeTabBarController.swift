//
//  HomeTabBarController.swift
//  Communi Uni
//
//  Created by BC Swift Student Loan 1 on 5/9/21.
//

import UIKit
import Firebase

class HomeTabBarController: UITabBarController {
    
    let userDefault = UserDefaults.standard
    let signedIn = UserDefaults.standard.bool(forKey: "usersignedin")
    let school = UserDefaults.standard.string(forKey: "userSchool")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("**** User logged in.")
        
        self.userDefault.set(true, forKey: "usersignedin")
        self.userDefault.synchronize()
        
        loadStudentData(school: school!) {
            print("Finished loading user data")
        }
    }
    
    func loadStudentData(school: String, completed: @escaping () -> ()) {
        print("Pulling user data...")
        let db = Firestore.firestore()
        print(Auth.auth().currentUser!.uid)
        db.collection("schools").document(school).collection("students").document(Auth.auth().currentUser!.uid).addSnapshotListener { (querySnapshot, error) in
            guard error == nil else {
                print("😡 ERROR: adding the snapshot listener \(error?.localizedDescription)")
                return completed()
            }
            
            let user = Student(dictionary: querySnapshot!.data()!)
            
            print(Auth.auth().currentUser!.uid)
            print(user)
            
            user.documentID = querySnapshot!.documentID
            UserDefaults.standard.set(user.firstname, forKey: "userFirstName")
            UserDefaults.standard.set(user.lastname, forKey: "userLastName")
            
            completed()
        }
    }

}
