//
//  NewTableViewCell.swift
//  Endoscope
//
//  Created by Adam Smith on 2019. 05. 19..
//  Copyright © 2019. Kovács Ádám. All rights reserved.
//

import UIKit

class NewTableViewCell: UITableViewCell {

    @IBOutlet weak var nameField: UILabel!
    @IBOutlet weak var userIDLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func showProblemDetails(_ sender: UIButton) {
        print(userIDLabel.text!)
    }
}
