//
//  DataService.swift
//  devslopes-social
//
//  Created by xannas on 7/18/2560 BE.
//  Copyright © 2560 xannas. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference()
let STORAGE_BASE = Storage.storage().reference()

class DataService{
    static let ds = DataService()
    //DB references
    private var _REF_BASE = DB_BASE
    private var _REF_POSTS = DB_BASE.child("posts")
    private var _REF_USERS = DB_BASE.child("users")

    // Storage references
    private var _REF_POSTS_IMAGES = STORAGE_BASE.child("post-pics")
    
    var REF_BASE: DatabaseReference{
        return _REF_BASE
    }
    
    var REF_POSTS: DatabaseReference{
        return _REF_POSTS
    }
    var REF_USERS: DatabaseReference{
        return _REF_USERS
    }
    var REF_POSTS_IMAGES: StorageReference{
        return _REF_POSTS_IMAGES
    }
    
    func createFirebaseDBUser(uid: String, userData: Dictionary<String,String>){
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
}
