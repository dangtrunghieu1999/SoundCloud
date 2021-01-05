//
//  User.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 12/29/20.
//  Copyright © 2020 Dang Trung Hieu. All rights reserved.
//

import UIKit

protocol BaseUserProtocol: BaseFirebaseNodeObjectProtocol {
    var displayName: String { get set }
    var profileImageURL: String { get set }
}

//used for display Owner of post in findRoomatePosts, photoPosts, textPosts
struct MiniUser: ParserData, BaseUserProtocol {
    
    //stored on firebase
    var displayName: String
    var profileImageURL: String
    
    //get from firebase key
    var uid: String
    
    init(user: YLUser) {
        displayName = user.displayName
        profileImageURL = user.profileImageURL
        uid = user.uid
    }

    
    init(dict: [String: Any], uid: String) {
        self.uid = uid
        displayName = dict["displayName"] as! String
        profileImageURL = dict["profileImageURL"] as! String
    }
    
    internal func transformToDictionary() -> Dictionary<String, Any> {
        return [
            "displayName": displayName,
            "profileImageURL": profileImageURL
        ]
    }
}

//used for full function
@objc class YLUser: NSObject, ParserData, BaseUserProtocol {
    
    static var THIS_USER: YLUser = YLUser()
    
    
    //get from firebase key
    var uid: String
    
    //get from observe new node
    var isFollowing: Bool
    
    
    //stored on firebase
    var displayName: String
    var email: String
    var profileImageURL: String
    var about: String
    var joinAt: Double
    
    
    //used for download full user
    var isFull: Bool
    
    override init() {
        uid = ""
        displayName = ""
        email =  ""
        profileImageURL = ""
        about = ""
        isFollowing = false
        joinAt = 0
        
        isFull = false
    }
    
    convenience init(uid: String, displayName: String) {
        self.init()
        self.uid = uid
        self.displayName = displayName
    }
    
    static func instanceFrom(dict: [String: Any], uid: String) -> YLUser {
        let new = YLUser()
        new.uid = uid
        new.displayName = dict["displayName"] as! String //?? ""
        new.email = dict["email"] as! String// ?? ""
        new.profileImageURL = dict["profileImageURL"] as? String ?? ""
        new.about = dict["about"] as? String ?? ""
        new.joinAt = dict["joinAt"] as? Double ?? 0
        
        new.isFull = true
        return new
    }
    
    func transformToDictionary() -> [String: Any] {
        var new = Dictionary<String, Any>()
        new["displayName"] = displayName
        new["email"] = email
        new["profileImageURL"] = profileImageURL
        new["about"] = about
        new["joinAt"] = joinAt
        return new
    }
    
    
    static func instanceFrom(miniUser: MiniUser) -> YLUser {
        let new = YLUser.init()
        new.displayName = miniUser.displayName
        new.uid = miniUser.uid
        new.profileImageURL = miniUser.profileImageURL
        
        new.isFull = false
        return new
    }
    
    
    static func instances(fromApiArr arr: [[String: Any]]) -> [YLUser] {
        var result = [YLUser]()
        arr.forEach { (dict) in
            let user = instanceFromApiDict(dict: dict)
            result.append(user)
        }
        return result
    }
    
    private static func instanceFromApiDict(dict: [String: Any]) -> YLUser {
        let new = YLUser.init()
        new.uid = dict["id"] as? String ?? ""
        new.displayName = dict["display_name"] as? String ?? ""
        new.profileImageURL = dict["profile_image_url"] as? String ?? ""
        new.isFull = false
        
        return new
    }
    
    func transferToSQLDict() -> [String: Any] {
        var dict = [String: Any]()
        dict["id"] = uid
        dict["about"] = about
        dict["display_name"] = displayName
        dict["email"] = email
        dict["profile_image_url"] = profileImageURL.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        dict["join_at"] = joinAt
        return dict
    }
    
    static func == (a: YLUser, b: YLUser) -> Bool {
        return a.uid == b.uid
    }
    
    static func != (a: YLUser, b: YLUser) -> Bool {
        return !(a.uid == b.uid)
    }
}

class SignUpUser: YLUser {
    var password: String
    var profileImage: UIImage?
    
    override init() {
        password = ""
        super.init()
    }
}
