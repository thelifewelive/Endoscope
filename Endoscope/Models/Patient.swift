//
//  Patient.swift
//  Endoscope
//
//  Created by Adam Smith on 2019. 05. 18..
//  Copyright © 2019. Kovács Ádám. All rights reserved.
//

import Foundation

class Patient {
    
    //Attributumok
    var name: String
    var motherName: String
    var taj: String
    var birthPlace: String
    var birth: String
    var gender: String
    var doctor: Bool
    
    //Adatok inicializálása
    init(){
        name = ""
        motherName = ""
        taj = ""
        birthPlace = ""
        birth = ""
        gender = ""
        doctor = false
    }
    
    init(_ initName: String, _ initMother: String, _ initTaj: String, _ initPlace: String, _ initBirth: String, _ initGender: String, _ initDoctor: Bool ){
        name = initName
        motherName = initMother
        taj = initTaj
        birthPlace = initPlace
        birth = initBirth
        gender = initGender
        doctor = initDoctor
    }
    
    func loadData(_ initName: String, _ initMother: String, _ initTaj: String, _ initPlace: String, _ initBirth: String, _ initGender: String ){
        name = initName
        motherName = initMother
        taj = initTaj
        birthPlace = initPlace
        birth = initBirth
        gender = initGender
    }
}
