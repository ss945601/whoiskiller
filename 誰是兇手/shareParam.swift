//
//  shareParm.swift
//  誰是兇手
//
//  Created by PKmac on 2020/6/20.
//  Copyright © 2020 com.asher.cmp. All rights reserved.
//

import Foundation
import WebKit
var isMaster = false; // 是不是房主
var status = "" // 遊戲目前狀態
var member = 0 // 連線人數
var playersID = Array<String>() // 連線手機名稱

class shareParam {
    static func getIndexByName(pid:String)->Int{
        var idx = 0
        playersID.sort()
        for pName in playersID{
            if pid ==  pName {
                break
            }
            idx += 1
        }
        if idx == playersID.count{
            return -1
        }else{
            return idx
        }
    }
}
