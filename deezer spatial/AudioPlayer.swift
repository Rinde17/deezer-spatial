//
//  AudioPlayer.swift
//  deezer spatial
//
//  Created by user231793 on 08/02/2023.
//

import AVFoundation
import UIKit
import MediaPlayer
import AVKit

class PlayerManager: UIViewController {
    
    static let shared = PlayerManager()
    var isPlaying = Bool()
    var isPause = Bool()
    
    var auteurAudio = ""
    var titreAudio = ""
    var live = ""
    
    var item : AVPlayerItem!
    var player = AVPlayer()
    
    var nowPlayingInfo = [String: Any]()
    
    func initMediaInfo() {
        initCommandCenter()
        initPlayingInfo()
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: player.currentItem)
    }
    
    @objc func playerDidFinishPlaying() {
        let time = CMTime(seconds: 0, preferredTimescale: 1000000)
        player.seek(to: time)
        pause()
    }
    
    func initCommandCenter() {
        let commandCenter = MPRemoteCommandCenter.shared()
        
        commandCenter.playCommand.addTarget{
            (commandCenter) -> MPRemoteCommandHandlerStatus in self.play();
            return .success
        }
        commandCenter.pauseCommand.addTarget{
            (commandCenter) -> MPRemoteCommandHandlerStatus in self.pause();
            return .success
        }
        
        commandCenter.changePlaybackPositionCommand.isEnabled = true
        commandCenter.changePlaybackPositionCommand.addTarget {
            event in
            if let event = event as? MPChangePlaybackPositionCommandEvent {
                let time = CMTime(seconds: event.positionTime, preferredTimescale: 1000000)
                self.player.seek(to: time)
            }
            return .success
        }
    }
    
    func initPlayingInfo() {
        guard let image = UIImage(named: "logo") else { print("image inexistante"); return }
        
        let imageNotification = MPMediaItemArtwork(boundsSize: image.size) { (size: CGSize) -> UIImage in
            return image
        }
        
        nowPlayingInfo = [
            MPMediaItemPropertyArtist: auteurAudio,
            MPMediaItemPropertyTitle: titreAudio,
            MPMediaItemPropertyArtwork: imageNotification,
            MPNowPlayingInfoPropertyIsLiveStream: live,
            MPNowPlayingInfoPropertyElapsedPlaybackTime: TimeInterval(player.currentTime().seconds),
            MPMediaItemPropertyPlaybackDuration: CMTimeGetSeconds(player.currentItem?.asset.duration ?? CMTime.init()),
            MPNowPlayingInfoPropertyPlaybackRate: player.rate
        ]
        
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
    
    func pause () {
        player.pause()
    }
    
    func play () {
        player.play()
    }
    
    func initPlayer (link: String) {
        guard let url = URL(string: link) else { return }
        item = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: item)
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            play()
        } catch { print("Erreur :", error) }
    }
}
