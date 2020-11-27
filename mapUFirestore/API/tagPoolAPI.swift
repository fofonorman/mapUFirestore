//
//  tagPoolAPI.swift
//  mapUFirestore
//
//  Created by ting pan on 2020/10/28.
//

import Foundation
import FirebaseDatabase
import FirebaseFirestore

class TagPoolAPI {
    
      
    let db = Firestore.firestore()
    
    
    func observeTagPool(completion: @escaping (Tag) -> Void) {
   
        let tagPoolRef = db.collection("tagPoolDefault")
       
        
        tagPoolRef.getDocuments { (querySnapshot, error) in
           if let querySnapshot = querySnapshot {
              for document in querySnapshot.documents {
                
                if let tagContent = document.data()["tagContent"] {
                    
                    let tagIDs = document.documentID
                    let newTag = Tag.typeOneTag(ID: tagIDs, tagContent: tagContent as! String)
                        completion(newTag)
                    
                    
                }
                
                
                
              }
           }
        }

        
        
        
//        tagPoolRef.observe(.childAdded, with: {(snapshot) in
//
//            if let dic = snapshot.value as? [String: Any] {
//                let tagIDs = snapshot.key
//                let newTag = Tag.typeOneTag(ID: tagIDs, dic: dic)
//                completion(newTag)
//
//            }
//
//        })
    }
    }
    
