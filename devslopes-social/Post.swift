//
//  Post.swift
//  devslopes-social
//
//  Created by xannas on 7/18/2560 BE.
//  Copyright © 2560 xannas. All rights reserved.
//

import Foundation

class Post{
    var _caption: String!
    var _imageUrl: String!
    var _likes: Int!
    var _postKey: String!
    
    var caption: String{
        return _caption
    }
    var imageUrl: String!{
        return _imageUrl
    }
    var likes: Int{
        return _likes
    }
    var postKey: String{
        return _postKey
    }
    init(caption: String, imageUrl: String, likes: Int){
        self._caption = caption
        self._imageUrl = imageUrl
        self._likes = likes
    }
    init(postKey: String, postData: Dictionary<String,Any>) {
        self._postKey = postKey
        
        if let caption = postData["caption"] as? String{
            self._caption = caption
        }
        if let imageUrl = postData["imageUrl"] as? String{
            self._imageUrl = imageUrl
        }
        if let likes = postData["likes"] as? Int{
            self._likes = likes
        }
    }
}
