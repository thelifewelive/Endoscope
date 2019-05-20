//
//  Data.swift
//  Endoscope
//
//  Created by Adam Smith on 2019. 05. 18..
//  Copyright © 2019. Kovács Ádám. All rights reserved.
//

import Foundation
import Firebase

class Database {
    
    static var patient = Patient()
    static var doctor = Doctor()
    static var problems: [Problem] = []
    
    static func setPatient(_ newPatient: Patient){
        self.patient = newPatient
    }
    
    static func setDoctor(_ newDoctor: Doctor){
        self.doctor = newDoctor
    }
    
    static func initProblems() {
        let db = Firestore.firestore()
        
        db.collection("problems").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    var data = document.data()
                    let problem = Problem(data["userID"] as! String, data["name"] as! String, data["message"] as! String, data["time"] as! String)
                    self.problems.append(problem)
                }
            }
        }
    }
}
