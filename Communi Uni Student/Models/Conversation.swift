//
//  Conversation.swift
//  Communi Uni Student
//
//  Created by BC Swift Student Loan 1 on 5/14/21.
//

import Foundation
import Firebase

class Conversation {
    var firstname: String
    var id: String
    var documentID: String
    
    var dictionary: [String: Any] {
        return ["firstname": firstname, "id": id]
    }

    init(firstname: String, id: String, documentID: String) {
        self.firstname = firstname
        self.id = id
        self.documentID = documentID
    }
    
    convenience init(dictionary: [String: Any]) {
        let firstname = dictionary["firstname"] as! String? ?? ""
        let id = dictionary["id"] as! String? ?? ""
        
        self.init(firstname: firstname, id: id, documentID: "")
    }
}
