//
//  template.swift
//  誰是兇手
//
//  Created by PKmac on 2020/5/19.
//  Copyright © 2020 com.asher.cmp. All rights reserved.
//

import SpriteKit
import GameplayKit

class templateSKScene: SKScene {
    func addTemplate(){
        addGoBackBtn()
        addGoNextBtn()
        addBgImage()
    }
    
    
    func addGoBackBtn(){
       var goBackBtn = SKSpriteNode(imageNamed: "goBack")
       goBackBtn.position = CGPoint(x: self.frame.minX+100, y: self.frame.maxY-50)
       goBackBtn.size = CGSize(width: goBackBtn.size.width/1.5,height: goBackBtn.size.height/1.5)
       goBackBtn.name = "goBack"
       self.addChild(goBackBtn)
   }
   
   func addGoNextBtn(){
       var goNextBtn = SKSpriteNode(imageNamed: "goNext")
       goNextBtn.position = CGPoint(x: self.frame.maxX-100, y: self.frame.maxY-50)
       goNextBtn.size = CGSize(width: goNextBtn.size.width/1.5,height: goNextBtn.size.height/1.5)
       goNextBtn.name = "goNext"
       self.addChild(goNextBtn)
   }
   

   func addBgImage(){
       let background = SKSpriteNode(imageNamed: "blood_bg")
       background.size = frame.size
       background.alpha = 0.5
       background.position = CGPoint(x: frame.midX, y: frame.midY)
       background.zPosition = -100
       addChild(background)
   }
}
