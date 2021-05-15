//
//  Conversations.swift
//  Communi Uni Student
//
//  Created by BC Swift Student Loan 1 on 5/14/21.
//

import Foundation
import Firebase

class Conversations {
    var conversationArray: [Chat] = []
    var db: Firestore!
    
    init() {
        db = Firestore.firestore()
    }
    
    func loadData(completed: @escaping () -> ()) {
        print(Auth.auth().currentUser!.uid)
            db.collection("conversations").whereField("users", arrayContains: Auth.auth().currentUser?.uid ?? "Not Found User 1").addSnapshotListener { (querySnapshot, error) in
            guard error == nil else {
                print("😡 ERROR: adding the snapshot listener \(error?.localizedDescription)")
                return completed()
            }
            self.conversationArray = [] // clean out existing conversationArray since new data will load
            // there are querySnapshot!.documents.count documents in the snapshot
            for document in querySnapshot!.documents {
                var conversation = Chat(dictionary: document.data())
                conversation?.documentID = document.documentID
                self.conversationArray.append(conversation!)
            }
            completed()
        }
    }
}
