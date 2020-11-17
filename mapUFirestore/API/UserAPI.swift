//
//  UserAPI.swift
//  mapUFirestore
//
//  Created by ting pan on 2020/10/28.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore


class UserAPI {

    let currentUser = Auth.auth().currentUser
    
    func observeUser(withID uid: String, completion: @escaping (User) -> Void ) {
        
        
        let db = Firestore.firestore()

        let userListRef = db.collection("userList")
        
        
//      將uid輸入後撈出name再填入 certainUser class
        userListRef.document(uid).getDocument { (document, error) in
            
            if let name = document?.data()?["name"], (name as AnyObject).exists {
                

                let uid = document?.documentID

                let certainUser = User.certainUser(uid: uid!, displayName: name as! String)
                        completion(certainUser)

                    }

                }
                
            }
            
            
        }
        
        
      
    }
    
    
}
