//
//  GameScene.swift
//  誰是殺手
//
//  Created by PKmac on 2020/5/18.
//  Copyright © 2020 com.asher.cmp. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var startBtn = SKLabelNode(text: "開始")
    
    override func didMove(to view: SKView) {
        
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//Title_lb") as? SKLabelNode

        addStartBtn()
        addBgImage()
        addMurder()
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         for touch in touches {
              let location = touch.location(in: self)
              let touchedNode = atPoint(location)
              if touchedNode.name == "startBtn" {
                touchedNode.alpha = 0.5
                // Call the function here.
              }
         }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        startBtn.alpha = 0.8
        for touch in touches {
             let location = touch.location(in: self)
             let touchedNode = atPoint(location)
             if touchedNode.name == "startBtn" {
               if let scene = rolePick(fileNamed: "rolePick") {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                    
                    let transition = SKTransition.moveIn(with: .right, duration: 0.5)
                    self.view?.presentScene(scene, transition: transition)
                }
                

             }
        }
      
    }

    func addBgImage(){
        let background = SKSpriteNode(imageNamed: "blood_bg")
        background.size = frame.size
        background.alpha = 0.5
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.zPosition = -100
        addChild(background)
    }
    
    
    func addStartBtn(){
        startBtn.name = "startBtn"
        startBtn.fontColor = UIColor.red
        startBtn.fontSize = 140
        startBtn.alpha = 0.8
        startBtn.position = CGPoint(x: frame.minX+400, y: frame.maxY-1050)
        startBtn.fontName = "AvenirNext-Bold"
        startBtn.zPosition = 0.9
        addChild(startBtn)
        
       
    }
    
    func addMurder(){
        let murder = SKSpriteNode(imageNamed: "murder")
        murder.size = CGSize(width: frame.size.width/2.5,height: frame.size.width/2.5)
        murder.alpha = 1
        murder.position = CGPoint(x: frame.minX+200, y: frame.maxY-1000)
        murder.zPosition = 0
        addChild(murder)
    }
    
    
}
