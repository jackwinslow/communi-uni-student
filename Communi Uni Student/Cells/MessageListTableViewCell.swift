//
//  MessageListTableViewCell.swift
//  Communi Uni Student
//
//  Created by BC Swift Student Loan 1 on 5/14/21.
//

import UIKit

class MessageListTableViewCell: UITableViewCell {
    @IBOutlet weak var collegeView: UIView!
    @IBOutlet weak var collegeImageView: UIImageView!
    @IBOutlet weak var collegeNameLabel: UILabel!
    @IBOutlet weak var collegeSchoolLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        collegeView.layer.cornerRadius = 10
        collegeView.layer.shadowRadius = 3
        collegeView.layer.shadowOpacity = 0.2
        collegeView.layer.shadowOffset = .zero
    }

}
