//
//  UserInfoViewController.swift
//  Endoscope
//
//  Created by Adam Smith on 2019. 05. 18..
//  Copyright © 2019. Kovács Ádám. All rights reserved.
//

import UIKit
import FirebaseUI
import FirebaseFirestore

class UserInfoViewController: MenuViewController {
    
    //Segédattributumok
    var activeTextfield = UITextField()
    
    //UI elements
    @IBOutlet weak var tajNumber: UILabel!
    @IBOutlet weak var motherName: UILabel!
    @IBOutlet weak var birthDate: UILabel!
    @IBOutlet weak var birthPlace: UILabel!
    @IBOutlet weak var gender: UILabel!
    
    //Módosító inputok
    @IBOutlet weak var erroLabel: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var motherField: UITextField!
    @IBOutlet weak var tajField: UITextField!
    @IBOutlet weak var placeField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(self.navigationItem.title! == "User information"){
            tajNumber.text = Database.patient.taj
            motherName.text = Database.patient.motherName
            birthDate.text = Database.patient.birth
            birthPlace.text = Database.patient.birthPlace
            gender.text = Database.patient.gender
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if(self.navigationItem.title! == "Modify information"){
            if(textField.placeholder == "TAJ number" || textField.placeholder == "Place of birth"){
                //333.5
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.center.y = 133.5
                })
            }else{
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.center.y = 333.5
                })
            }
        }
    }
    
    @IBAction func modify(_ sender: UIButton) {
        performSegue(withIdentifier: "showModify", sender: self)
    }
    
    @IBAction func modifyData(_ sender: Any) {
        
        //Ha nevet szeretne változtatni
        if(nameField.text!.count > 0){
            let db = Firestore.firestore()
            let userID = Auth.auth().currentUser!.uid
            db.collection("users").document(userID).setData([ "name": nameField.text! ], merge: true)
            Database.patient.name = nameField.text!
        }
        
        //Ha az anyja nevét akarja megváltoztatni
        if(motherField.text!.count > 0){
            let db = Firestore.firestore()
            let userID = Auth.auth().currentUser!.uid
            db.collection("users").document(userID).setData([ "mother": motherField.text! ], merge: true)
            Database.patient.motherName = motherField.text!
        }
        
        //Ha a taj számát szeretné megváltoztatni
        if(tajField.text!.count > 0){
            let db = Firestore.firestore()
            let userID = Auth.auth().currentUser!.uid
            db.collection("users").document(userID).setData([ "TAJ": tajField.text! ], merge: true)
            Database.patient.taj = tajField.text!
        }
        
        //Ha a születési helyét szeretné megváltoztatni
        if(placeField.text!.count > 0){
            let db = Firestore.firestore()
            let userID = Auth.auth().currentUser!.uid
            db.collection("users").document(userID).setData([ "place": placeField.text! ], merge: true)
            Database.patient.birthPlace = placeField.text!
        }
        
        //Visszadobjuk magunkat a rootra
        self.navigationController?.popToRootViewController(animated: true)
    }
}
