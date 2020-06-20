//
//  cmdProcessor.swift
//  誰是兇手
//
//  Created by PKmac on 2020/6/20.
//  Copyright © 2020 com.asher.cmp. All rights reserved.
//

import Foundation
import WebKit
import UIKit
extension templateSKScene: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        var msg = message.body as! String
        processCommand(cmd: msg)
    }
    
    func processCommand(cmd:String){
        if !cmd.contains("[Server]") {
            print(cmd)
        }
        var msg = ""
        if cmd.contains("[CMD]"){
            msg = String(cmd.split(separator: "]")[1])
        }
        else {
            msg = cmd
        }
        if msg.contains("人數"){ // 取得連線人數
            let num = String(msg.split(separator: ":")[1])
            member = Int(num)!
            events.trigger(eventName: "member")
            if status != "gameConnect" && member < limit_player{ // 突然斷線 回連線頁面
                events.trigger(eventName: "startToWaitConnect")
            }
        }
        if msg.contains("加入遊戲"){ // ID 確認加入
            var name = msg.split(separator: "加")[0]
            if !playersID.contains(String(name)) {
                playersID.append(String(name))
            }
        }
        if msg.contains("getPlayerAlive"){ // 回應ID是否連線中
            sendCmd(msg: UIDevice.current.name + "加入遊戲")
        }
        if msg.contains("startToRolePick"){ // 非房主等待房主指令跳頁
            if (!isMaster) {
                events.trigger(eventName: "startToRolePick")
            }
        }
        if msg.contains("pickRole:"){
            let info = String(msg.split(separator: ":")[1])
            let idx =  Int(info.split(separator: "_")[0])
            let role =  String(info.split(separator: "_")[1])
            playerID_Name[playersID[idx!]] = role
            events.trigger(eventName: "selectByOtherPlayer", information: info)
        }
    }
}


