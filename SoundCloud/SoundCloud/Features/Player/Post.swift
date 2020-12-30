//
//  Post.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 12/29/20.
//  Copyright © 2020 Dang Trung Hieu. All rights reserved.
//

import UIKit

class Post: BaseFirebaseNodeObjectProtocol, ParserData {
    var uid: String
    var ownerUID: String
    
    var title: String
    var status: String
    var attachments: PostAttachments
    
    var timeStamp: Double
    
    var activities: PostActivities
    
    //To containt user infomation to show in Newfeed
    var user: YLUser?
    
    init() {
        uid = ""
        ownerUID = ""
        title = ""
        status = ""
        attachments = PostAttachments()
        timeStamp = 0
        activities = PostActivities()
        
        user = nil
    }
    
    convenience init?(dict: [String: Any], uid: String) {
        self.init()
        if let activitiesDict = dict["activities"] as? [String: Any],
            let activities = PostActivities.init(dict: activitiesDict),
            let attachmentsDict = dict["attachments"] as? [String: Any],
            let attachments = PostAttachments.init(dict: attachmentsDict),
            let ownerUID = dict["ownerUID"] as? String,
            let status = dict["status"] as? String,
            let timeStamp = dict["timeStamp"] as? Double,
            let title = dict["title"] as? String {
            
            self.uid = uid
            self.activities = activities
            self.attachments = attachments
            self.ownerUID = ownerUID
            self.status = status
            self.timeStamp = timeStamp
            self.title = title
            
        } else {
            return nil
        }
    }
    
    func transformToDictionary() -> Dictionary<String, Any> {
        return [
            "activities": activities.transformToDictionary(),
            "attachments": attachments.transformToDictionary(),
            "ownerUID": ownerUID,
            "status": status,
            "timeStamp": timeStamp,
            "title": title
        ]
    }
    
}


struct PostAttachments: ParserData {
    var dataURL: String
    var imageURL: String
    
    init() {
        dataURL = ""
        imageURL = ""
    }
    
    init?(dict: [String: Any]) {
        if let dtURL = dict["dataURL"] as? String, let imgURL = dict["imageURL"] as? String {
            dataURL = dtURL
            imageURL = imgURL
        } else {
            return nil
        }
    }
    
    func transformToDictionary() -> Dictionary<String, Any> {
        return [
            "dataURL": dataURL,
            "imageURL": imageURL
        ]
    }
}

class PostActivities: ParserData {
    var likes: [String: Bool]
    var commentCount: Int
    var playCount: Int
    var isLiked: Bool
    var saves: [String: Bool]
    var isSaved: Bool
    
    init() {
        likes = [:]
        isLiked = false
        commentCount = 0
        playCount = 0
        saves = [:]
        isSaved = false
    }
    
    convenience init?(dict: [String: Any]) {
        self.init()
        if let commentCount = dict["commentCount"] as? Int, let playCount = dict["playCount"] as? Int {
            self.likes = dict["likes"] as? [String: Bool] ?? [:]
            if self.likes[YLUser.THIS_USER.uid] != nil {
                self.isLiked = true
            }
            self.commentCount = commentCount
            self.playCount = playCount
            saves = dict["saves"] as? [String: Bool] ?? [:]
            if saves[YLUser.THIS_USER.uid] != nil {
                isSaved = true
            }
        } else {
            return nil
        }
    }
    
    func transformToDictionary() -> Dictionary<String, Any> {
        return [
            "likes": likes,
            "commentCount": commentCount,
            "playCount": playCount,
            "saves": saves
        ]
    }
}

class NewPost: Post {
    
    var image: UIImage?
    var localAudioURL: URL?
    
    override init() {
        super.init()
        
    }
}
