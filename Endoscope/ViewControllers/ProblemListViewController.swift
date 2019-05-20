//
//  ProblemListViewController.swift
//  Endoscope
//
//  Created by Adam Smith on 2019. 05. 19..
//  Copyright © 2019. Kovács Ádám. All rights reserved.
//

import UIKit
import Firebase

class ProblemListViewController: DoctorMenuViewController{

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ProblemListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Database.problems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? NewTableViewCell
        cell?.nameField.text = Database.problems[indexPath.row].name
        cell?.userIDLabel.text = Database.problems[indexPath.row].userID
        //36 31 64
        cell?.backgroundColor = UIColor(red: 36/255, green: 31/255, blue: 64/255, alpha: 1)
        return cell!
    }
}
