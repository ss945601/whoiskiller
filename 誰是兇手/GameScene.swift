//
//  GameScene.swift
//  誰是殺手
//
//  Created by PKmac on 2020/5/18.
//  Copyright © 2020 com.asher.cmp. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: templateSKScene {
    
    private var label : SKLabelNode?
    private var startBtn = SKLabelNode(text: "連線")
    private var hintTxt : SKLabelNode?
    override func didMove(to view: SKView) {
        
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//Title_lb") as? SKLabelNode
        addSocket()
        addStartBtn()
        addBgImage()
        addMurder()
        addHintBoard(hintStr: "人數："+"0/4")
        events.listenTo(eventName: "isLoadDone", action: enableStartBtn)
        events.listenTo(eventName: "member", action: updateMember)
    }
     
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         
         for touch in touches {
              let location = touch.location(in: self)
              let touchedNode = atPoint(location)
              if touchedNode.name == "startBtn" && member == 4 {
                touchedNode.alpha = 0.5
                playSound(file: "flip.mp3")
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

    
    func updateMember(){
        hintTxt?.text = "人數："+String(member)+"/4"
    }
    
    func addStartBtn(){
        startBtn.name = "waitlink"
        startBtn.fontColor = UIColor.gray
        startBtn.fontSize = 140
        startBtn.alpha = 0.8
        startBtn.position = CGPoint(x: frame.minX+400, y: frame.maxY-1050)
        startBtn.fontName = "AvenirNext-Bold"
        startBtn.zPosition = 0.9
        addChild(startBtn)
       
    }
    
    func enableStartBtn(){
        startBtn.name = "startBtn"
        startBtn.text = "開始"
        startBtn.fontColor = UIColor.red
    }
    
    
    
    func addMurder(){
        let murder = SKSpriteNode(imageNamed: "murder")
        murder.size = CGSize(width: frame.size.width/2.5,height: frame.size.width/2.5)
        murder.alpha = 1
        murder.position = CGPoint(x: frame.minX+200, y: frame.maxY-1000)
        murder.zPosition = 0
        addChild(murder)
    }
    
    func addHintBoard(hintStr:String){
        let hintBoard = SKSpriteNode(imageNamed: "hintBoard")
        hintBoard.alpha = 1
        hintBoard.size = CGSize(width: hintBoard.size.width/1.2,height: hintBoard.size.width/1.2)
        hintBoard.atPoint(self.view!.center)
        hintBoard.zPosition = 0
        addChild(hintBoard)
        hintTxt = SKLabelNode(text: hintStr)
        hintTxt?.zPosition = 3
        hintTxt?.name = "member"
        hintTxt?.fontColor = UIColor.black
        hintTxt?.fontSize = 50
        hintTxt?.fontName = "AvenirNext"
        hintBoard.addChild(hintTxt!)
    }
    
    
}
