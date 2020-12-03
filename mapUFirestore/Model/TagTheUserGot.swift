//
//  TagTheUserGot.swift
//  mapUFirestore
//
//  Created by ting pan on 2020/11/25.
//

import Foundation

class TagTheUserGot: Codable {
    var numberOfThumbs: Int?
    var tagID: String?
    var tagContent: String?
    var thumbUpByYou: Bool?
    }


extension TagTheUserGot {
    
    static func TagListInMyFollowingUser(numberOfThumbs: Int, tagID: String, tagContent: String, thumbUpByYou: Bool) -> TagTheUserGot {
        
        let tagList = TagTheUserGot()
        
        tagList.numberOfThumbs = numberOfThumbs
        tagList.tagContent = tagContent
        tagList.tagID = tagID
        tagList.thumbUpByYou = thumbUpByYou
        
        return tagList

    }
    
}
