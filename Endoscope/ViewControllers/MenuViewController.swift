//
//  MenuViewController.swift
//  Endoscope
//
//  Created by Adam Smith on 2019. 05. 18..
//  Copyright © 2019. Kovács Ádám. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITextFieldDelegate {
    
    //UI elemek
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var asLabel: UILabel!
    @IBOutlet weak var userIcon: UIImageView!
    
    //Billentyűzet return gombra eltűnik
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        UIView.animate(withDuration: 0.3, animations: {
            self.view.center.y = 333.5
        })
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if(self.navigationItem.title! == "Main Menu"){
            initUI()
        }
    }
    
    func initUI() {
        mainLabel.text = Database.patient.name
        
        if(Database.doctor.name.count > 0){
            asLabel.text = "as a doctor"
            userIcon.image = UIImage(named: "doctor")
            mainLabel.text = Database.doctor.name
        }else{
            asLabel.text = "as a patient"
            //Felhasználó gender képének beállítása
            if(Database.patient.gender == "Male"){
                userIcon.image = UIImage(named: "male")
            }else{
                userIcon.image = UIImage(named: "female")
            }
        }
    }
    
    @IBAction func showUserInfo(_ sender: UIButton) {
        performSegue(withIdentifier: "showUserInfo", sender: self)
    }
    
    @IBAction func showMedical(_ sender: UIButton) {
        performSegue(withIdentifier: "medical", sender: self)
    }
    
    @IBAction func showDiagnosis(_ sender: UIButton) {
        performSegue(withIdentifier: "showDiagnosis", sender: self)
    }
    
    @IBAction func showAbout(_ sender: UIButton) {
        performSegue(withIdentifier: "showAbout", sender: self)
    }
}
