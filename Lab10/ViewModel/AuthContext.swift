//
//  Auth.swift
//  Lab10
//
//  Created by Elard Huaraca on 10/6/21.
//

import Foundation
import UIKit
import Firebase

class AuthContext{
    
    static func user() -> User {
        let user = Auth.auth().currentUser
        let id = user?.uid
        let email = user?.email
        return User(email: email!, id: id!, username: "", url: "");
    }
}
