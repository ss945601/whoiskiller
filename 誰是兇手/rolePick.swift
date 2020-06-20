//
//  rolePick.swift
//  誰是兇手
//
//  Created by PKmac on 2020/5/19.
//  Copyright © 2020 com.asher.cmp. All rights reserved.
//

import SpriteKit
import GameplayKit



class rolePick: templateSKScene {
    private var secondScene = SKSpriteNode()
    private var label : SKLabelNode?
    private var roles = ["錢貞多","吳昭音","房芊萍","艾貼摩"]
    private var storyNote = SKSpriteNode(imageNamed: "note")
    var isPickRole = false
    var isYourTurn = false
    override func didMove(to view: SKView) {
        secondScene.size = self.size
        secondScene.zPosition = 10
        addChild(secondScene)
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//Title_role_lb") as? SKLabelNode
        addTemplate()
        addRoleBtn()
        events.listenTo(eventName: "selectByOtherPlayer", action: selectByOtherPlayer)
    }
    
    func addRoleBtn(){
       
        if let url = Bundle.main.url(forResource: "roleSex", withExtension: "strings"),
            let sex = NSDictionary(contentsOf: url) as? [String: String] {
            addRoleWithName(name: roles[0]+sex[String(roles[0])]!,pos:CGPoint(x: frame.midX, y: frame.maxY-500) )
            addRoleWithName(name: roles[1]+sex[String(roles[1])]!,pos:CGPoint(x: frame.midX, y: frame.maxY-720) )
            addRoleWithName(name: roles[2]+sex[String(roles[2])]!,pos:CGPoint(x: frame.midX, y: frame.maxY-940) )
            addRoleWithName(name: roles[3]+sex[String(roles[3])]!,pos:CGPoint(x: frame.midX, y: frame.maxY-1160) )
        }
        
    }
    
    
    
    func addRoleWithName( name:String, pos:CGPoint){
        let role = SKLabelNode(text: name)
        for r in roles{
            if name.contains(r){
                role.name = r
            }
        }
        
        role.fontColor = UIColor.red
        role.fontSize = 60
        role.alpha = 0.8
        role.position = pos
        role.fontName = "SetoFont"
        role.zPosition = 2
        addChild(role)
        let mark = SKSpriteNode(imageNamed: "knifeMark")
        mark.alpha = 0
        mark.zPosition = 3
        role.addChild(mark)
        
    }
    
    func selectByOtherPlayer(information:Any?){
        let idx =  Int((information as! String).split(separator: "_")[0])
        let role =  String((information as! String).split(separator: "_")[1])
        for node in children {
            if node.name == role {
                node.alpha = 0.5
                node.children.first?.alpha = 0.8
                let player = SKLabelNode(text: playersID[idx!])
                player.fontColor = UIColor.white
                player.fontSize = 60
                player.alpha = 0
                player.fontName = "SetoFont"
                player.zPosition = 3
                node.addChild(player)
                player.position = CGPoint(x: player.position.x,y: player.position.y-70)
                player.alpha = 1
            }
        }
        if idx!+1 < playersID.count {
            if playersID[idx!+1] == UIDevice.current.name{
                isYourTurn = true
            }
        }
        
       
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            let nodesarray = nodes(at: location)
            for node in nodesarray {
                if (isMaster) {
                   isYourTurn = true
                }
                if (!isPickRole && isYourTurn) {
                    for r in roles{
                        if node.name == r && secondScene.children.count == 0 && node.children.first?.alpha != 1{
                            node.alpha = 0.5
                            node.children.first?.alpha = 0.8
                            playSound(file: "click.mp3")
                            showStory(role: r)
                            playerID_Name[UIDevice.current.name] = r
                            isPickRole = true
                            var idx = shareParam.getIndexByName(pid: UIDevice.current.name)
                            if idx != -1 {
                                sendCmd(msg:"pickRole:"+String(idx)+"_"+r)
                            }
                        }
                    }
                }
                if node.name == "note_cancel" {
                    var tmp = node.parent
                    tmp?.removeAllChildren()
                    tmp?.removeFromParent()
                    playSound(file: "click.mp3")
                }
                
            }
        }
    }
    
    
    func showStory(role:String){
        if storyNote.name == nil {
            storyNote.name = "note"
            storyNote.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
            storyNote.zPosition = 5
            storyNote.size = CGSize(width: storyNote.size.width*0.95, height: storyNote.size.height*1.1)
        }
        let cancelBtn = SKSpriteNode(imageNamed: "cancel")
        cancelBtn.name = "note_cancel"
        cancelBtn.position = CGPoint(x: storyNote.frame.maxX-150, y: storyNote.frame.maxY-150)
        cancelBtn.size = CGSize(width: cancelBtn.size.width/2, height: cancelBtn.size.height/2)
        cancelBtn.zPosition = 6
        var storyStr = ""
        if let url = Bundle.main.url(forResource: "roleIntroduction", withExtension: "strings"),
            let stringsDict = NSDictionary(contentsOf: url) as? [String: String] {
            storyStr = stringsDict[role]!
        }
        let content = SKLabelNode(text: storyStr)
        content.zPosition = 6
        content.fontColor = UIColor.black
        content.fontSize = content.fontSize * 1.2
        content.fontName = "SetoFont"
        let message = content.multilined()
        message.zPosition = 6
        storyNote.addChild(cancelBtn)
        storyNote.addChild(message)
        secondScene.addChild(storyNote)
        
    }
    
    
    
}
