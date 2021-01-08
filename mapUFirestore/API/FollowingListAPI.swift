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

    func fetchFollowingList(withID uid: String, completion: @escaping (User) -> Void) {
        
        //      要補上else處理方式
        API.UserRef.db.collection("userList")
.document(uid).collection("FollowingList").getDocuments { (querySnapshot, error) in
            
           if let existingSnapshot = querySnapshot  {
                        
                for i in existingSnapshot.documents {
                    
                    API.UserRef.observeUser(withID: i.documentID) {
                        
                        (followingUser) in
                                           
                        completion(followingUser)
                        
                    }
                    
                }


                        }
        
    }
        
    }
               
    }



