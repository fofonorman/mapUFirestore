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

        var userListRef = db.collection("userList")
        
//       待改成 firestore path
//        userListRef.child(uid).observeSingleEvent(of: .value, with: {
//            (snapshot) in
//
//            if let dic = snapshot.value as? [String: Any] {
//
//                let user = User.certainUser(uid: uid, displayName: dic["name"] as! String)
//                completion(user)
//            }
//
//        })
    }
    
    
}
