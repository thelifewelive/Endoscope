//
//  Problem.swift
//  Endoscope
//
//  Created by Adam Smith on 2019. 05. 20..
//  Copyright © 2019. Kovács Ádám. All rights reserved.
//

import Foundation

class Problem {
    
    var userID: String
    var name: String
    var message: String
    var time: String
    
    init(){
        userID = ""
        message = ""
        time = ""
        name = ""
    }
    
    init(_ id: String, _ na: String , _ mes: String, _ ti: String){
        userID = id
        message = mes
        time = ti
        name = na
    }
    
}
