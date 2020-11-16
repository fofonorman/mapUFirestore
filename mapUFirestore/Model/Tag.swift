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
    
    static func typeOneTag(ID: String, tagContent: String) -> Tag {
           
        let tag = Tag()
        tag.tagContent = tagContent
        tag.tagID = ID
        
        return tag
        }
    }
   
