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

    func fetchFollowingList(completion: @escaping (User) -> Void) {
         
        
        let db = Firestore.firestore()

        let userListRef = db.collection("userList")
        
        
        userListRef.document(currentUser!.uid).collection("FollowingList").getDocuments { (querySnapshot, error) in
            
            if let querySnapshot = querySnapshot {
                
                for document in querySnapshot.documents {
//                    要將撈出來的 followingListID 拿去正確的路徑撈 userDisplayName
                    if let uids = document.documentID {
                        
                        userListRef.document(uids).getDocument { (queryNames, error) in
                            
                            if let queryNames = queryNames {
                                
                                let names = queryNames.data()?["name"]
                                
                                let newUser = User.certainUser(uid: uids, displayName: names as! String)
                                completion(newUser)
                                
                            }
                            
                        }
                        
                       
                        
                    }
                    
                }
                
            }
            
            
        }
               
    }

}
