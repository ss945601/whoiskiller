import Foundation
import SpriteKit
import AVFoundation

    public let audio = JKAudioPlayer.sharedInstance()


    private let JKAudioInstance = JKAudioPlayer()


    public class JKAudioPlayer {


    var musicPlayer: AVAudioPlayer!


    static var canShareAudio = false {
        didSet {
            canShareAudio ? try! AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.ambient) : try! AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.soloAmbient)
        }
    }

    public class func sharedInstance() -> JKAudioPlayer {
        return JKAudioInstance
    }
    public func playMusic(fileName: String, withExtension type: String = "") {
        if let url = Bundle.main.url(forResource: fileName, withExtension: type) {
            musicPlayer = try? AVAudioPlayer(contentsOf: url)
            musicPlayer.numberOfLoops = -1
            musicPlayer.prepareToPlay()
            musicPlayer.play()
        }
    }


    public func stopMusic() {
        if musicPlayer != nil && musicPlayer!.isPlaying {
            musicPlayer.currentTime = 0
            musicPlayer.stop()
        }
    }


    public func pauseMusic() {
        if musicPlayer != nil && musicPlayer!.isPlaying {
            musicPlayer.pause()
        }
    }

    public func resumeMusic() {
        if musicPlayer != nil && !musicPlayer!.isPlaying {
            musicPlayer.play()
        }
    }

    public func playSound(fileName: String) -> SKAction? {
        return SKAction.playSoundFileNamed(fileName, waitForCompletion: false)
    }
}

