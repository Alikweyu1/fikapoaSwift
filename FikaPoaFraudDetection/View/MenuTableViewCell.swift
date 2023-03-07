//
//  MenuTableViewCell.swift
//  FikaPoaFraudDetection
//
//  Created by SOFTWARE on 07/03/2023.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var profileUsename: UILabel!
    
    @IBOutlet weak var profileUser: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var lable_title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        

        // Configure the view for the selected state
    }

}
