//
//  GameViewController.swift
//  誰是殺手
//
//  Created by PKmac on 2020/5/18.
//  Copyright © 2020 com.asher.cmp. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit


class GameSettingVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            let audio = JKAudioPlayer.sharedInstance()
            audio.playMusic(fileName: "bgm", withExtension: "mp3")
            if let scene = GameConnectScene(fileNamed: "GameConnectScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            
            view.ignoresSiblingOrder = true
            view.showsFPS = false
            view.showsNodeCount = false
        }
    }
    

    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
