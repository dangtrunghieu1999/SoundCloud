//
//  MusicPlayer.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 12/29/20.
//  Copyright © 2020 Dang Trung Hieu. All rights reserved.
//

import UIKit
import AVFoundation

/*
 This class manage play song. Include:
 - List song save
 */
class MusicPlayer {
    
    class var shared: MusicPlayer {
        struct Static {
            static let instance = MusicPlayer()
        }
        return Static.instance
    }
    
    private init() {
        
    }
    
    var curentSong: Post?
    var playListSong: [Post]?
    var player: AVPlayer?
    var isPlaying: Bool = false
    
    //Feature Method
    func play(newPost: Post, onSuccess: ()->Void, onError: ()->Void) {
        self.isPlaying = true
        
        let checkNewPost = self.playListSong?.contains(where: { (post) -> Bool in
            return post.uid == newPost.uid
        })
        
        self.curentSong = newPost
        if !(checkNewPost ?? false) {
            if self.playListSong == nil {
                self.playListSong = [Post]()
            }
            
            self.playListSong?.append(newPost)
        }
        
        self.play(post: newPost) {
            onError()
        }
        
        onSuccess()
    }
    
    func addToPlayList(post: Post) {
        let checkNewPost = self.playListSong?.contains(where: { (postTemp) -> Bool in
            return postTemp.uid == post.uid
        })
        
        if !(checkNewPost ?? false) {
            if self.playListSong == nil {
                self.playListSong = [Post]()
            }
             self.playListSong?.append(post)
            
        }
    }
    
    private func play(post: Post, onerror: ()->Void) {
        guard let url: URL = URL(string: post.attachments.dataURL) else {
            onerror()
            return
        }
        
        self.player = AVPlayer(url: url)
        self.player?.play()
        
    }
    
    @objc func nextPlay() {
        self.isPlaying = true
        
        let index = self.playListSong?.firstIndex(where: { (post) -> Bool in
            return post.uid == self.curentSong?.uid
        })
        
        guard let count = self.playListSong?.count else {
            self.stop()
            return
        }
        
        if index == nil {
            self.stop()
            return
        }
        
        if index == count - 1 {
            self.curentSong = self.playListSong?[0]
            guard let post = self.curentSong else { return }
            
            self.play(post: post, onerror: {
                //error
            })
        } else {
            self.curentSong = self.playListSong?[index!  + 1]
            guard let post = self.curentSong else { return }
            
            self.play(post: post, onerror: {
                //error
            })
        }
        
        //TO DO: add notification to change view play song
    }
    
    func backPlay() {
        self.isPlaying = true
        
        let index = self.playListSong?.firstIndex(where: { (post) -> Bool in
            return post.uid == self.curentSong?.uid
        })
        
        guard let count = self.playListSong?.count else {
            self.stop()
            return
        }
        
        guard let indexConfig = index else {
            self.stop()
            return
        }
        
        if indexConfig == 0 {
            self.curentSong = self.playListSong?[count - 1]
            guard let post = self.curentSong else { return }
            
            self.play(post: post, onerror: {
                //error
            })
        } else {
            self.curentSong = self.playListSong?[indexConfig - 1]
            guard let post = self.curentSong else { return }
            
            self.play(post: post, onerror: {
                //error
            })
        }
        

    }

    
    func playRandom() {
        
    }
    
    func pause() {
        if self.isPlaying {
            self.player?.pause()
            self.isPlaying = false
            
        } else {
            self.player?.play()
            self.isPlaying = true

        }
    }
    
    func stop() {
        self.isPlaying = false
        self.curentSong = nil
        self.player = nil
        
        //Stop Animation rotate dish
    }
    
    func seekToTime(_ time: Float) {
        let newTime = CMTimeMakeWithSeconds(Float64(time), preferredTimescale: 1)
        self.player?.seek(to: newTime)
    }
    
    func addNewSong(post: Post) {
        self.playListSong?.append(post)
    }
    
    func getCurrentTime()->CMTime? {
        return self.player?.currentItem?.currentTime()
    }
    
    func getDuration(completion: @escaping (CMTime?)->()) {
        let queue = DispatchQueue(label: "playerPlay")
        
        queue.async {
            let time = self.player?.currentItem?.asset.duration
            
            DispatchQueue.main.async {
                completion(time)
            }
        }
        
    }
}
