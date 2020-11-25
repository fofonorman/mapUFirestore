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
    
//    let currentUser = Auth.auth().currentUser
//
//    func fetchTagTheUserGot(numberOfThumbs: Int, tagID: String, tagContent: String, thumbUpOrNot: Bool,  completion: @escaping (TagTheUserGot) -> Void) {
//
//
//        let db = Firestore.firestore()
//
//        let userListRef = db.collection("userList")
//
//
//        //      要補上else處理方式
//        userListRef.document(currentUser!.uid).collection("TagIGot").addSnapshotListener { (querySnapshot, error) in
//
//           guard let existingSnapshot = querySnapshot else {
//
//            return }
//
////            querySnapshot?.documentChanges.forEach({
//                { (documentChange) in
//                      if documentChange.type == .added {
//                         print(documentChange.document.data())
//                      }
//
//
//
//            })
            
            
//
//
//                for i in existingSnapshot.documents {
//
//                   let tagID = i.documentID
//                    //要確定怎麼撈欄位裡的陣列有多少值的數量
//                    let numberOfThumbs = i.data()["thumbUp"]
////                    let tagContent = i.data().k
//
//
//                    API.UserRef.observeUser(withID: i.documentID) {
//
//                        (followingUser) in
//
//                        completion(followingUser)
//
//                    }
//
//                }
//
//                        }
//
//    }}
//
//
//}

//func observeTagPool(completion: @escaping (Tag) -> Void) {
//
//    let tagPoolRef = db.collection("tagPoolDefault")
//
//
//    tagPoolRef.getDocuments { (querySnapshot, error) in
//       if let querySnapshot = querySnapshot {
//          for document in querySnapshot.documents {
//
//            if let tagContent = document.data()["tagContent"] {
//
//                let tagIDs = document.documentID
//                let newTag = Tag.typeOneTag(ID: tagIDs, tagContent: tagContent as! String)
//                    completion(newTag)
//
//
//            }
//
//
//
//          }
//       }
//    }
//
//}

}
