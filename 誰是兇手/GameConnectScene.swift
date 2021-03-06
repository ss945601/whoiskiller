//
//  GameScene.swift
//  誰是殺手
//
//  Created by PKmac on 2020/5/18.
//  Copyright © 2020 com.asher.cmp. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameConnectScene: templateSKScene {
    
    private var label : SKLabelNode?
    private var startBtn = SKLabelNode(text: "連線...")
    private var hintTxt : SKLabelNode?
    private var hintBoard = SKSpriteNode(imageNamed: "hintBoard")
    var askTimer = Timer()
    override func didMove(to view: SKView) {
        
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//Title_lb") as? SKLabelNode
        status = "gameConnect"
        askTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(askAliveConnent), userInfo: nil, repeats: true)
        addSocket()
        addStartBtn()
        addBgImage()
        addMurder()
        initHintBoard(hintStr: "人數："+"0/" + String(limit_player))
        events.listenTo(eventName: "member", action: updateMember)
        events.listenTo(eventName: "startToRolePick", action: startToRolePick)

    }
     
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         
         for touch in touches {
              let location = touch.location(in: self)
              let touchedNode = atPoint(location)
              if touchedNode.name == "startBtn" {
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
                if (isMaster){
                    
                    sendCmd(msg: "startToRolePick")
                    startToRolePick()
                }
             }
        }
      
    }

    func startToRolePick(){
        if let scene = rolePick(fileNamed: "rolePick") {
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            status = "rolePick"
            let transition = SKTransition.moveIn(with: .right, duration: 0.5)
            self.view?.presentScene(scene, transition: transition)
        }
    }
    
    
    @objc func askAliveConnent(){
        if (member != playersID.count) {
            if (member >= 1) {
                playersID.removeAll()
            }
            sendCmd(msg: "getPlayerAlive")
        }
    }
    
    func updateMember(){
        if playersID.count == 0 || playersID.count != member{
            return;
        }
        var hintStr = "人數："+String(member)+"/"+String(limit_player)
        playersID.sort()
        for name in playersID {
            if name == playersID[0] {
                hintStr = hintStr + "\n" + name + "[房主]"
            }
            else {
                hintStr = hintStr + "\n" + name + " [OK]"
            }
        }
        updateHint(hintStr: hintStr)
        enableStartBtn()
    }
    
    func addStartBtn(){
        startBtn.name = "waitlink"
        startBtn.fontColor = UIColor.gray
        startBtn.fontSize = 140
        startBtn.alpha = 0.8
        startBtn.position = CGPoint(x: frame.minX+400, y: frame.maxY-1200)
        startBtn.fontName = "Genkaimincho"
        startBtn.zPosition = 0.9
        addChild(startBtn)
       
    }
    
    func enableStartBtn(){
        if (playersID.count > 0) {
            if playersID[0] == UIDevice.current.name {
                isMaster = true
            }
            else{
                isMaster = false
                let audio = JKAudioPlayer.sharedInstance()
                audio.stopMusic()
            }
        }
        if member == limit_player && member == playersID.count && isMaster{
            startBtn.name = "startBtn"
            startBtn.text = "開始"
            startBtn.fontColor = UIColor.red
        }
        else if member > 0{
            startBtn.name = "prepare"
            startBtn.text = "準備"
            startBtn.fontColor = UIColor.green
        }
        else if member == 0 {
            startBtn.name = "waitlink"
            startBtn.text = "連線..."
            startBtn.fontColor = UIColor.gray
        }
    }
    
    
    
    func addMurder(){
        let murder = SKSpriteNode(imageNamed: "murder")
        murder.size = CGSize(width: frame.size.width/2.5,height: frame.size.width/2.5)
        murder.alpha = 1
        murder.position = CGPoint(x: frame.minX+100, y: frame.maxY-1150)
        murder.zPosition = 0
        addChild(murder)
    }
    
    func initHintBoard(hintStr:String){
        hintBoard.alpha = 1
        hintBoard.size = CGSize(width: hintBoard.size.width/11,height: hintBoard.size.width/11)
        hintBoard.atPoint(self.view!.center)
        hintBoard.zPosition = 0
        addChild(hintBoard)
        updateHint(hintStr: hintStr)
    }
    
    func updateHint(hintStr:String){
        if (hintTxt != nil){
            hintTxt?.removeFromParent()
        }
        hintTxt = SKLabelNode(text: hintStr)
        hintTxt?.name = "member"
        hintTxt?.fontColor = UIColor.black
        hintTxt?.fontSize = 45
        hintTxt?.fontName = "SetoFont"
        hintTxt = hintTxt?.multilined()
        hintBoard.addChild(hintTxt!)
        hintTxt?.zPosition = 5
    }
}
