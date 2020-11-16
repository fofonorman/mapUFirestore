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
        
        
//        寫錯了，下列方法應該要用在 followingListAPI
        userListRef.document(currentUser!.uid).collection("followingList").getDocuments { (querySnapshot, error) in
            
            if let querySnapshot = querySnapshot {
                
                for document in querySnapshot.documents {
                    
                    if let names = document.data()["name"] {
                        
                        let uids = document.documentID
                        
                        let newUser = User.certainUser(uid: uids, displayName: names as! String)
                        completion(newUser)
                        
                    }
                    
                }
                
            }
            
            
        }
        
        
      
    }
    
    
}
