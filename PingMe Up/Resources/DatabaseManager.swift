//
//  Database.swift
//  PingMe Up
//
//  Created by anshul on 15/11/23.
//

import UIKit
import Foundation
import FirebaseDatabase

final class DatabaseManager{
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
}
//Mark: - Account Management
extension DatabaseManager{
    
    public func userExists(with email: String,
                           completion: @escaping((Bool)-> Void)) {
      
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        
        database.child(safeEmail).observeSingleEvent(of: .value, with: {snapshot in
            
            guard snapshot.value as? String != nil else{
                completion(false)
                return
            }
            completion(true)
        })
        
    }
    ///Inserts new user to database
    public func insertUser(with user: ChatAppUser){
        database.child(user.safeEmail).setValue(["first_name": user.firstname,
                                             "last_name": user.lastname
                                            ])
    }
      
}

struct ChatAppUser{
    let firstname: String
    let lastname: String
    let email: String
//    let profilePictureUrl: String
    
    
    var safeEmail: String{
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
     }

}

