//
//  Student.swift
//  Communi Uni Student
//
//  Created by BC Swift Student Loan 1 on 5/17/21.
//

import Foundation
import Firebase

class Student {
    var firstname: String
    var lastname: String
    var school: String
    var date: Date
    var uid: String
    var documentID: String
    
    var dictionary: [String: Any] {
        let timeIntervalDate = date.timeIntervalSince1970
        return ["firstname": firstname, "lastname": lastname, "school": school, "date": timeIntervalDate, "uid": uid]
    }

    init(firstname: String, lastname: String, school: String, date: Date, uid: String, documentID: String) {
        self.firstname = firstname
        self.lastname = lastname
        self.school = school
        self.date = date
        self.uid = uid
        self.documentID = documentID
    }
    
    convenience init(dictionary: [String: Any]) {
        let firstname = dictionary["firstname"] as! String? ?? ""
        let lastname = dictionary["lastname"] as! String? ?? ""
        let school = dictionary["school"] as! String? ?? ""
        let timeIntervalDate = dictionary["date"] as! TimeInterval? ?? TimeInterval()
        let date = Date(timeIntervalSince1970: timeIntervalDate)
        let uid = dictionary["uid"] as! String? ?? ""
        
        self.init(firstname: firstname, lastname: lastname, school: school, date: date, uid: uid, documentID: "")
    }
}
