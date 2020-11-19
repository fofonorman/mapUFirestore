//
//  FollowingListAPI.swift
//  mapUFirestore
//
//  Created by ting pan on 2020/10/28.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseAuth


class FollowingListAPI {

    let currentUser = Auth.auth().currentUser

    func fetchFollowingList(withID uid: String, completion: @escaping (User) -> Void) {
         
        
        let db = Firestore.firestore()

        let userListRef = db.collection("userList")
        
        
        //      將uid輸入後撈出name再填入 certainUser class
        userListRef.document(uid).collection("FollowingList").getDocuments { (querySnapshot, error) in
            
           if let existingSnapshot = querySnapshot  {
                        
                for i in existingSnapshot.documents {
                    
                    API.UserRef.observeUser(withID: i.documentID) {
                        
                        (followingUser) in
                        
                        completion(followingUser)
                        
                    }
                    
                }
//
//                        let uid = document?.documentID
//
//                        let certainUser = User.certainUser(uid: uid!, displayName: name as! String)
//                                completion(certainUser)
//
//                    } else {
//
//                        print(error)
//                    }

                        }
        
    }}
               
//if let names = document.data()["name"]


}
