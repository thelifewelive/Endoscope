//
//  DoctorMenuViewController.swift
//  Endoscope
//
//  Created by Adam Smith on 2019. 05. 19..
//  Copyright © 2019. Kovács Ádám. All rights reserved.
//

import UIKit

class DoctorMenuViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var asLabel: UILabel!
    @IBOutlet weak var userIcon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = Database.doctor.name
        asLabel.text = "as a doctor"
        userIcon.image = UIImage(named: "doctor")
        print(Database.problems)
    }
    
    @IBAction func showAbout(_ sender: Any) {
        performSegue(withIdentifier: "showDocAbout", sender: self)
    }
    
    @IBAction func problems(_ sender: UIButton) {
        performSegue(withIdentifier: "showProblems", sender: self)
    }
}
