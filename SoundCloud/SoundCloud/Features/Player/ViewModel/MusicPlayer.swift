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
    
    var curentSong: SongTrack?
    var playListSong: [SongTrack]?
    var player: AVPlayer?
    var isPlaying: Bool = false
    
    //Feature Method
    func play(newSong: SongTrack, onSuccess: ()->Void, onError: ()->Void) {
        self.isPlaying = true
        
        let checkNewPost = self.playListSong?.contains(where: { (song) -> Bool in
            return song.id == newSong.id
        })
        
        self.curentSong = newSong
        if !(checkNewPost ?? false) {
            if self.playListSong == nil {
                self.playListSong = [SongTrack]()
            }
            
            self.playListSong?.append(newSong)
        }
        
        self.play(song: newSong) {
            onError()
        }
        
        onSuccess()
    }
    
    func addToPlayList(song: SongTrack) {
        let checkNewPost = self.playListSong?.contains(where: { (songTemp) -> Bool in
            return songTemp.id == song.id
        })
        
        if !(checkNewPost ?? false) {
            if self.playListSong == nil {
                self.playListSong = [SongTrack]()
            }
             self.playListSong?.append(song)
            
        }
    }
    
    private func play(song: SongTrack, onerror: ()->Void) {
//        guard let url: URL = URL(string: song.path) else {
//            onerror()
//            return
//        }
        
        guard let url: URL = URL(string: "http://musicmd1fr.keeng.net/bucket-media-keeng/sas_01/video/2014/12/20/27e072d51bea4cb3a6d4f6271591d6ec2b17e482.mp4") else { return }
        self.player = AVPlayer(url: url)
        self.player?.play()
        
    }
    
    @objc func nextPlay() {
        self.isPlaying = true
        
        let index = self.playListSong?.firstIndex(where: { (song) -> Bool in
            return song.id == self.curentSong?.id
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
            guard let song = self.curentSong else { return }
            
            self.play(song: song, onerror: {
                //error
            })
        } else {
            self.curentSong = self.playListSong?[index!  + 1]
            guard let song = self.curentSong else { return }
            
            self.play(song: song, onerror: {
                //error
            })
        }
        
        //TO DO: add notification to change view play song
    }
    
    func backPlay() {
        self.isPlaying = true
        
        let index = self.playListSong?.firstIndex(where: { (song) -> Bool in
            return song.id == self.curentSong?.id
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
            guard let song = self.curentSong else { return }
            
            self.play(song: song, onerror: {
                //error
            })
        } else {
            self.curentSong = self.playListSong?[indexConfig - 1]
            guard let song = self.curentSong else { return }
            
            self.play(song: song, onerror: {
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
    
    func addNewSong(song: SongTrack) {
        self.playListSong?.append(song)
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


