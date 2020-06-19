//
//  template.swift
//  誰是兇手
//
//  Created by PKmac on 2020/5/19.
//  Copyright © 2020 com.asher.cmp. All rights reserved.
//

import SpriteKit
import GameplayKit
import WebKit

public struct Queue<T> {
    fileprivate var array = [T]()
    public var isEmpty: Bool {
        return array.isEmpty
    }
    public var count: Int {
        return array.count
    }
    public mutating func enqueue(_ element: T) {
        array.append(element)
    }
    public mutating func dequeue() -> T? {
        if isEmpty {
           return nil
        } else {
           return array.removeFirst()
        }
     }
    public var front: T? {
        return array.first
    }
}

extension SKLabelNode {
  func multilined() -> SKLabelNode {
    let substrings: [String] = self.text!.components(separatedBy: "\n")
    return substrings.enumerated().reduce(SKLabelNode()) {
      let label = SKLabelNode(fontNamed: self.fontName)
      label.text = $1.element
      label.fontColor = self.fontColor
      label.fontSize = self.fontSize
      label.position = self.position
      label.horizontalAlignmentMode = self.horizontalAlignmentMode
      label.verticalAlignmentMode = self.verticalAlignmentMode
        let y = CGFloat($1.offset - substrings.count / 2) * self.fontSize*1.62
      label.position = CGPoint(x: 0, y: -y)
      $0.addChild(label)
      return $0
    }
  }
}


extension templateSKScene: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        let msg = message.body as! String
        //processBuffer.enqueue(msg)
        if msg.contains("人數"){
            let num = String(msg.split(separator: ":")[1])
            member = Int(num)!
            events.trigger(eventName: "member")
        }
        if msg.contains("加入遊戲"){
            var name = msg.split(separator: "加")[0]
            if !playersName.contains(String(name)) {
                playersName.append(String(name))
            }
        }
        if msg.contains("getPlayerAlive"){
            sendCmd(msg: UIDevice.current.name + "加入遊戲")
        }
        if (member == limit_player){
            events.trigger(eventName: "isLoadDone")
        }
        
        print(msg)
    }
}

class templateSKScene: SKScene,WKNavigationDelegate {
    
    var webView = WKWebView()
    var isLoadDone = false
    var processBuffer = Queue<String>()
    var playersName = Array<String>()
    let events = EventManager();
    var member = 0
    var timer = Timer()

    let limit_player = 2

    func addTemplate(){
        addGoNextBtn()
        addBgImage()
    }
    
    func addSocket(){
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = WKUserContentController()
        configuration.userContentController.add(self, name: "ToApp")
        self.webView = WKWebView(frame: .zero, configuration: configuration)
        webView.navigationDelegate = self
        let url = URL(string: "https://whoiskiller.herokuapp.com/")!
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    func sendCmd(msg:String){
        webView.evaluateJavaScript("sendCmd('"+msg+"')", completionHandler: { (value,error)in
            print(value as Any)
        })
    }
    
    @objc func getClientsNum(){
        webView.evaluateJavaScript("getClientsNum()", completionHandler: { (value,error)in
            print(value as Any)
        })
    }
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        isLoadDone = true
        sendCmd(msg: UIDevice.current.name + "加入遊戲")
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(getClientsNum), userInfo: nil, repeats: true)
    }
    
    func addGoBackBtn(){
       let goBackBtn = SKSpriteNode(imageNamed: "goBack")
       goBackBtn.position = CGPoint(x: self.frame.minX+100, y: self.frame.maxY-50)
       goBackBtn.size = CGSize(width: goBackBtn.size.width/1.5,height: goBackBtn.size.height/1.5)
       goBackBtn.name = "goBack"
       self.addChild(goBackBtn)
   }
   
   func addGoNextBtn(){
       let goNextBtn = SKSpriteNode(imageNamed: "goNext")
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
    
    
    func playSound(file:String){
        let sound = SKAction.playSoundFileNamed(file, waitForCompletion: false)
        run(sound)
    }
}
