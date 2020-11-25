//
//  TagTheUserGotAPI.swift
//  mapUFirestore
//
//  Created by ting pan on 2020/11/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore


class TagTheUserGotAPI{
    
    let currentUser = Auth.auth().currentUser

    func fetchTagTheUserGot(numberOfThumbs: Int, tagID: String, tagContent: String, thumbUpOrNot: Bool,  completion: @escaping (TagTheUserGot) -> Void) {
         
        
        let db = Firestore.firestore()

        let userListRef = db.collection("userList")
        
        
        //      要補上else處理方式
        userListRef.document(currentUser!.uid).collection("TagIGot").getDocuments { (querySnapshot, error) in
            
           if let existingSnapshot = querySnapshot  {
                        
                for i in existingSnapshot.documents {
                    
                    i.description
                    
                    
                    API.UserRef.observeUser(withID: i.documentID) {
                        
                        (followingUser) in
                        
                        completion(followingUser)
                        
                    }
                    
                }


                        }
        
    }}

    
}


