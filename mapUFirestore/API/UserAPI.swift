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

    let db = Firestore.firestore()
    let currentUserUID = Auth.auth().currentUser?.uid
    
    
    func observeUser(withID uid: String, completion: @escaping (User) -> Void ) {
        
        

        let userListRef = db.collection("userList")
        
        
//      將uid輸入後撈出name & userAvatarURL 再填入 certainUser class
        userListRef.document(uid).getDocument { (document, error) in
            
            if let name = document?.data()?["name"] {
                
                let uid = document?.documentID
                let userAvatar = document?.data()!["ProfileImage"]
                let certainUser = User.certainUser(uid: uid!, displayName: name as! String, userAvatarURL: userAvatar as! String)
                        completion(certainUser)

            } else {
                
                print(error)
            }

                }
                
    }
    
//    嘗試寫一個API來擔任“確保用戶為currentUser登入狀態
//    func checkIfValidCurrentUser(completion: @escaping () -> Void) {
//
//        if let currentUserUID = currentUser?.uid {
//            completion
//        }
//
//    }
            
            
        }

        

