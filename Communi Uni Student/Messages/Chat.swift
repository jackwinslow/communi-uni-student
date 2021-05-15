//
//  Chat.swift
//  Communi Uni Student
//
//  Created by BC Swift Student Loan 1 on 5/14/21.
//

import UIKit

struct Chat {
    
    var userName: String
    var userUID: String
    var studentName: String
    var studentUID: String
    var studentSchool: String
    var users: [String]
    var documentID: String
    
    var dictionary: [String: Any] {
        return [
            "userName": userName, "userUID": userUID, "studentName": studentName, "studentUID": studentUID, "studentSchool": studentSchool, "users": users
        ]
    }
}

extension Chat {
    
    init?(dictionary: [String:Any]) {
        let userName = dictionary["userName"] as! String? ?? ""
        let userUID = dictionary["userUID"] as! String? ?? ""
        let studentName = dictionary["studentName"] as! String? ?? ""
        let studentUID = dictionary["studentUID"] as! String? ?? ""
        let studentSchool = dictionary["studentSchool"] as! String? ?? ""
        guard let chatUsers = dictionary["users"] as? [String] else {return nil}
        
        self.init(userName:userName, userUID:userUID, studentName:studentName, studentUID:studentUID, studentSchool:studentSchool, users: chatUsers, documentID: "")
    }
    
}
