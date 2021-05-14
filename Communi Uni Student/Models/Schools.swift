//
//  Schools.swift
//  Communi Uni Student
//
//  Created by BC Swift Student Loan 1 on 5/14/21.
//

import Foundation
import Firebase

class Schools {
    var schoolArray: [School] = []
    var db: Firestore!
    
    init() {
        db = Firestore.firestore()
    }
    
    func loadData(completed: @escaping () -> ()) {
        db.collection("schools").addSnapshotListener { (querySnapshot, error) in
            guard error == nil else {
                print("😡 ERROR: adding the snapshot listener \(error?.localizedDescription)")
                return completed()
            }
            self.schoolArray = [] // clean out existing schoolArray since new data will load
            // there are querySnapshot!.documents.count documents in the snapshot
            for document in querySnapshot!.documents {
                let school = School(dictionary: document.data())
                school.documentID = document.documentID
                self.schoolArray.append(school)
            }
            completed()
        }
    }
}
