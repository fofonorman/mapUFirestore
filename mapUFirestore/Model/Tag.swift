//
//  Tag.swift
//  mapUFirestore
//
//  Created by ting pan on 2020/10/28.
//

import Foundation

class Tag {
    var tagContent: String?
    var tagID: String?
    }

extension Tag{
    
    static func typeOneTag(ID: String, dic: [String: Any]) -> Tag {
           
        let tag = Tag()
        tag.tagContent = dic["tag"] as? String
        tag.tagID = ID
        
        return tag
        }
    }
   
