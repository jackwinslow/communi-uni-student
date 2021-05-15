//
//  MessageListViewController.swift
//  Communi Uni Student
//
//  Created by BC Swift Student Loan 1 on 5/13/21.
//

import UIKit

class MessageListViewController: UIViewController {
    @IBOutlet weak var studentTableView: UITableView!
    
    let userDefault = UserDefaults.standard
    let school = UserDefaults.standard.string(forKey: "userSchool")
    
    var conversations: Conversations!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        conversations = Conversations()
        studentTableView.delegate = self
        studentTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        conversations.loadData {
            self.studentTableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowChat" {
            print("doing segue ****************************")
            let destination = segue.destination as! ContainerViewController
            let selectedIndexPath = studentTableView.indexPathForSelectedRow!
            print(conversations.conversationArray[selectedIndexPath.row])
            destination.currentUserName = "BOBBY STUDENT"
            destination.user2Name = conversations.conversationArray[selectedIndexPath.row].userName
            destination.user2UID = conversations.conversationArray[selectedIndexPath.row].userUID
            destination.studentSchool = conversations.conversationArray[selectedIndexPath.row].studentSchool
            destination.hidesBottomBarWhenPushed = true
        }
    }


}

extension MessageListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversations.conversationArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = studentTableView.dequeueReusableCell(withIdentifier: "ConvCell", for: indexPath) as! MessageListTableViewCell
        cell.collegeNameLabel.text = conversations.conversationArray[indexPath.row].userName
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
