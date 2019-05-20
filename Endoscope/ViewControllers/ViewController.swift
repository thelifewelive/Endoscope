//
//  ViewController.swift
//  Endoscope
//
//  Created by Adam Smith on 2019. 05. 13..
//  Copyright © 2019. Kovács Ádám. All rights reserved.
//

import UIKit
import FirebaseUI
import FirebaseFirestore

class ViewController: UIViewController, UITextFieldDelegate {
    
    //Ui elemek
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var tajField: UITextField!
    @IBOutlet weak var motherField: UITextField!
    @IBOutlet weak var genderSelect: UISegmentedControl!
    @IBOutlet weak var birthPicker: UIDatePicker!
    @IBOutlet weak var setPage1Error: UILabel!
    @IBOutlet weak var setPage2Error: UILabel!
    @IBOutlet weak var placeField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Database.initProblems()
    }
    
    //Billentyűzet return gombra eltűnik
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        let authUI = FUIAuth.defaultAuthUI()
        
        //Megnézzük van -e error
        guard authUI != nil else {
            //Error logolás
            return
        }
        
        authUI?.delegate = self
        authUI?.providers = [FUIEmailAuth(), FUIGoogleAuth()]
        let authViewController = authUI!.authViewController()
        present(authViewController, animated: true, completion: nil)
    }
    
    /*
     A függvény az első belépésnél hívódik meg amikor a felhasználó rányom
     az adatok beállítása gombra.
     Funkciója:
        A fieldek alapján beállít egy új dokumentumot a firestore -ba.
        A következő belépésnél ez az oldal már nem fog látszani.
    */
    @IBAction func setData(_ sender: UIButton) {
        let db = Firestore.firestore()
        let usersRef = db.collection("users")
        let userID = Auth.auth().currentUser!.uid
        
        let name = nameField.text!
        let motherName = motherField.text!
        let taj = tajField.text!
        let gender = genderSelect.titleForSegment(at: genderSelect.selectedSegmentIndex)
        
        if(name.count == 0 || motherName.count == 0 || taj.count == 0){
            setPage1Error.isHidden = false
        }else {
            //Eltüntetjük az error -t felvisszük az adatbázisba az adatokat majd tovább megyünk
            setPage1Error.isHidden = true
            usersRef.document(userID).setData([
                "name": name,
                "mother": motherName,
                "born": "",
                "place": "",
                "gender": gender,
                "TAJ": taj,
                "doctor": false
            ])
            performSegue(withIdentifier: "showSetDate", sender: self)
            Database.patient = Patient(name, motherName, taj, "", "", gender!, false)
        }
    }
    
    @IBAction func finishDataSet(_ sender: UIButton) {
        //Megvizsgáljuk, hogy meg lett e adva a születési hely
        if(placeField.text!.count == 0){
            setPage2Error.isHidden = false
        }else{
            setPage2Error.isHidden = true
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMMM yyyy"

            let born = dateFormatter.string(from: birthPicker.date)
            let place = placeField.text!
            
            let db = Firestore.firestore()
            let usersRef = db.collection("users")
            let userID = Auth.auth().currentUser!.uid
            usersRef.document(userID).updateData([
                "born": born,
                "place": place,
            ])
            Database.patient.birth = born
            Database.patient.birthPlace = place
            performSegue(withIdentifier: "finishSetUp", sender: self)
        }
    }
}

extension ViewController: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        //Megnézzük van -e error
        guard error == nil else {
            //Error logolás
            return
        }
        //Usernek az id-ja (Ellenőrizve)
        let userID = Auth.auth().currentUser!.uid
        
        /*
            Megnézzük, hogy ezzel a userID -val már van -e adat a realtimeDatabase -be.
            Ha nincs akkor az azt jelenti, hogy a felhasználó még nem állította be az adatait
            így tehát az adat beállítós oldalra kell irányítanunk a felhasználót.
            Egyébként pedig a mainMenüre (jelenleg a buta welcome page).
        */
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(userID)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data()!
                //print("Document data: ", dataDescription["doctor"]!)
                
                if let dec = dataDescription["doctor"] as? Int, Bool(dec){
                    let doctor = Doctor(dataDescription["name"] as! String, dataDescription["mother"] as! String, dataDescription["TAJ"] as! String, dataDescription["place"] as! String, dataDescription["born"] as! String, dataDescription["gender"] as! String)
                    Database.setDoctor(doctor)
                    self.performSegue(withIdentifier: "showDoctor", sender: self)
                }else{
                    //Páciens objektum létrehozása
                    let patient = Patient(dataDescription["name"] as! String, dataDescription["mother"] as! String, dataDescription["TAJ"] as! String, dataDescription["place"] as! String, dataDescription["born"] as! String, dataDescription["gender"] as! String, dataDescription["doctor"] as! Bool)
                    
                    //Adatok továbbküldése
                    self.performSegue(withIdentifier: "showHome", sender: self)
                    Database.setPatient(patient)
                }
            } else {
                self.performSegue(withIdentifier: "showSetData", sender: self)
            }
        }
    }
}

extension Bool
{
    init(_ intValue: Int)
    {
        switch intValue
        {
        case 0:
            self.init(false)
        default:
            self.init(true)
        }
    }
}
