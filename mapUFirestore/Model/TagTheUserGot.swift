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
    var thumbUpByYou: Bool?
    var thumbByWhom: [String]?
    var ifRead: Bool?
    }


extension TagTheUserGot {
    
    static func TagListInMyFollowingUser(numberOfThumbs: Int, tagID: String, tagContent: String, thumbUpByYou: Bool, ifRead: Bool) -> TagTheUserGot {
        
        let tagList = TagTheUserGot()
        
        tagList.numberOfThumbs = numberOfThumbs
        tagList.tagContent = tagContent
        tagList.tagID = tagID
        tagList.thumbUpByYou = thumbUpByYou
        tagList.ifRead = ifRead

        return tagList

    }
    
}

//
//extension TagTheUserGot {
//
//    static func myTagList(numberOfThumbs: Int, tagID: String, tagContent: String, thumbUpByYou: Bool, ifRead: Bool) -> TagTheUserGot {
//
//        let tagList = TagTheUserGot()
//
//        tagList.numberOfThumbs = numberOfThumbs
//        tagList.tagContent = tagContent
//        tagList.tagID = tagID
//        tagList.thumbUpByYou = thumbUpByYou
//        tagList.ifRead = ifRead
//
//        return tagList
//
//
//    }
//
//
//}

