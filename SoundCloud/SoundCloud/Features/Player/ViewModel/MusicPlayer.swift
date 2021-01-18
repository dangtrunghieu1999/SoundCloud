//
//  MusicPlayer.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 12/29/20.
//  Copyright © 2020 Dang Trung Hieu. All rights reserved.
//

import UIKit
import AVFoundation

enum MusicPlayerType: Int {
    case linear            = 0
    case repeatType        = 1
    case random            = 2
}

protocol MusicPlayerDelegate : NSObject {
    func musicPlayerOnPlaySong(_ sender: MusicPlayer, _ song: Song)
}

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
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(playerDidFinishPlaying),
                                               name: .AVPlayerItemDidPlayToEndTime,
                                               object: nil)
    }
    
    private(set) var currentSong: Song?
    private(set) var playListSong: [Song] = []
    private(set) var isPlaying: Bool = false
    private(set) var playType: MusicPlayerType = .linear
    
    var delegates: [MusicPlayerDelegate] = []
    
    private var player: AVPlayer?
    
    // MARK: - Setter
    
    func setPlayType(_ type: MusicPlayerType) {
        if (type == playType) {
            playType = .linear
            return
        }
        
        playType = type;
    }
    
    // MARK: - Play EntryPoint
    
    @discardableResult
    func play(song: Song) -> Bool {
        self.isPlaying = true
        self.currentSong = song
        
        guard let url: URL = URL(string: song.path) else {
            return false
        }
    
        self.player = AVPlayer(url: url)
        self.player?.play()
        
        for delegate in delegates {
            delegate.musicPlayerOnPlaySong(self, song)
        }
        
        return true;
    }
    
    func play(with playList: [Song]) {
        if (playList.isEmpty) {
            return
        }
        
        self.isPlaying = true
        addToPlayList(playList)
        play(song: self.playListSong.first!)
    }
    
    func addToPlayList(_ playList: [Song]) {
        self.playListSong = playList
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
        self.currentSong = nil
        self.player = nil
    }
    
    @discardableResult
    func addToPlayList(_ song: Song) -> Bool {
        if (existSongInPlaylist(song) ) {
            return false
        }
        
        self.playListSong.append(song)
        return true
    }
    
    @discardableResult
    func playNext() -> Bool {
        guard !playListSong.isEmpty else {
            return false
        }
        
        var nextIndex = 0;
        if let song = self.currentSong {
            let index = indexOfSongInPlayList(song)
            
            if let currIndex = index, currIndex < playListSong.count - 1 {
                nextIndex = currIndex
                nextIndex += 1
            }
        }
        
        print("count: \(playListSong.count) play next index: \(nextIndex)")
        
        let nextSong = playListSong[nextIndex]
        play(song: nextSong)
        
        return true
    }
    
    @discardableResult
    func playBack() -> Bool {
        guard !playListSong.isEmpty else {
            return false
        }
        
        var preIndex = 0;
        if let song = self.currentSong {
            let index = indexOfSongInPlayList(song)
            
            if let currIndex = index, currIndex > 0 {
                preIndex = currIndex
                preIndex -= 1
            }
        }
        
        print("count: \(playListSong.count) play pre index: \(preIndex)")
        
        let nextSong = playListSong[preIndex]
        play(song: nextSong)
        
        return true
    }
    
    func playRandom() {
        guard !self.playListSong.isEmpty else {
            return
        }
        
        let index = Int.random(in: 0..<self.playListSong.count)
        let song = self.playListSong[index]
        self.play(song: song)
    }
    
    func seekToTime(_ time: Float) {
        let newTime = CMTimeMakeWithSeconds(Float64(time), preferredTimescale: 1)
        self.player?.seek(to: newTime)
    }
    
    func getCurrentTime() -> CMTime? {
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
    
    // MARK: - Common Helper
    
    @objc private func playerDidFinishPlaying() {
        guard let song = currentSong else {
            return
        }
        
        switch self.playType {
        case .linear:
            playNext()
        case .random:
            playRandom()
        case .repeatType:
            play(song: song)
        }
    }
    
    private func existSongInPlaylist(_ song: Song) -> Bool {
        return indexOfSongInPlayList(song) != nil
    }
    
    private func indexOfSongInPlayList(_ song: Song) -> Int? {
        return self.playListSong.firstIndex(where: { (song) -> Bool in
            return song.id == self.currentSong?.id
        })
    }
}


