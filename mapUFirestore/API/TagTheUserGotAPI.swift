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
    
    func fetchTagTheUserGotList(completion: @escaping (TagTheUserGot) -> Void) {
        
        API.UserRef.db.collection("userList").document("GOhc9KTUoSXRtPx3TKt9").collection("TagIGot").getDocuments { (snapshot, error) in
            
            guard let snapshot = snapshot else {
                return
            }

            for document in snapshot.documents {
                
               let tagContent = document.data()["tagContent"] as! String
                    
               let thumb = document.data()["thumbUp"] as! [String]
                
               let tagID = document.documentID
               let likedByYou = false
               let numberOfLiked = thumb.count
         
               let tagListMember = TagTheUserGot.TagListInMyFollowingUser(numberOfThumbs: numberOfLiked, tagID: tagID, tagContent: tagContent, thumbUpByYou: likedByYou)
                    
                    completion(tagListMember)
                    
            }
                
            }
            
        }
    
    

}
