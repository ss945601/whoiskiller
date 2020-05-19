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
    
    private var label : SKLabelNode?
    
    
    override func didMove(to view: SKView) {
        
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//Title_role_lb") as? SKLabelNode
        addTemplate()
        addRoleBtn()
    }
    
    func addRoleBtn(){
        addRoleWithName(name: "遊戲公司CEO(男)",pos:CGPoint(x: frame.midX, y: frame.maxY-500) )
        addRoleWithName(name: "KTV老闆(女)",pos:CGPoint(x: frame.midX, y: frame.maxY-700) )
        addRoleWithName(name: "大地主(女)",pos:CGPoint(x: frame.midX, y: frame.maxY-900) )
        addRoleWithName(name: "貼膜專業員(男)",pos:CGPoint(x: frame.midX, y: frame.maxY-1100) )
        
    }
    
    

    func addRoleWithName( name:String, pos:CGPoint){
        let role = SKLabelNode(text: name)
        role.name = name
        role.fontColor = UIColor.red
        role.fontSize = 60
        role.alpha = 0.8
        role.position = pos
        role.fontName = "AvenirNext-Bold"
        role.zPosition = 2
        addChild(role)
        let mark = SKSpriteNode(imageNamed: "knifeMark")
        mark.alpha = 0
        mark.zPosition = 3
        role.addChild(mark)
        
    }
    
    

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            let nodesarray = nodes(at: location)
             
            for node in nodesarray {
                if node.name == "goBack" {
                    let firstScene = GameScene(fileNamed: "GameScene")
                    let transition = SKTransition.doorsCloseHorizontal(withDuration: 0.5)
                    firstScene?.scaleMode = .aspectFill
                    scene?.view?.presentScene(firstScene!, transition: transition)
                 }
                if node.zPosition == 2 {
                    node.alpha = 0.5
                    node.children.first?.alpha = 1
                }
            }
        }
    }
    
    
    
}
