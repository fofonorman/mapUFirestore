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
        
//        要改成即時監聽 method，置換userUid
        
        API.UserRef.db.collection("userList").document("GOhc9KTUoSXRtPx3TKt9").collection("TagIGot").addSnapshotListener { (snapshot, error) in
        
                    guard let snapshot = snapshot else {
                        return
                    }
                
                 for document in snapshot.documents {
     
                   if let tagContent = document.data()["tagContent"] as? String,
                      let thumb = document.data()["thumbUp"] as? [String]{
     
                    let tagID = document.documentID
                    let likedByYou = thumb.contains("G53HUXuPtBPvgdm2KxlR7dCE0SD3")
                    let numberOfLiked = thumb.count
     
                    let tagListMember = TagTheUserGot.TagListInMyFollowingUser(numberOfThumbs: numberOfLiked, tagID: tagID, tagContent: tagContent, thumbUpByYou: likedByYou)
     
                         completion(tagListMember)
     
                   }}
     
                 }}
 
        
        }
    
    


