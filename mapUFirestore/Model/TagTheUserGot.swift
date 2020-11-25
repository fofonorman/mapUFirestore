//
//  TagTheUserGot.swift
//  mapUFirestore
//
//  Created by ting pan on 2020/11/25.
//

import Foundation

class TagTheUserGot {
    var numberOfThumbs: Int?
    var tagID: String?
    var tagContent: String?
    var thumbUpOrNot: Bool?
    }


extension TagTheUserGot {
    
    static func TagListInMyFollowingUser(numberOfThumbs: Int, tagID: String, tagContent: String, thumbUpOrNot: Bool) -> TagTheUserGot {
        
        let tagList = TagTheUserGot()
        
        tagList.numberOfThumbs = numberOfThumbs
        tagList.tagContent = tagContent
        tagList.tagID = tagID
        tagList.thumbUpOrNot = thumbUpOrNot
        
        
    }
    
    
    
    
}
