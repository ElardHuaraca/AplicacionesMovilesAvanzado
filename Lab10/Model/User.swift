//
//  User.swift
//  Lab10
//
//  Created by Elard Huaraca on 10/6/21.
//

import Foundation
import UIKit

class User {
    
    var email:String
    var id:String
    var username:String
    var url:String
    
    init(email:String,id:String,username:String,url:String) {
        self.email = email
        self.id = id
        self.username = username
        self.url = url
    }
}
