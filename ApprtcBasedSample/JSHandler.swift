//
//  JSHandler.swift
//  omniTest
//
//  Created by Sridharan on 28/03/16.
//  Copyright © 2016 Sridharan. All rights reserved.
//

import Foundation
import UIKit
import WebKit
import XWebView

class JSHandler:NSObject {
    func OnTest(message:String, function1 callback:String, function2 func2:String) {
        dispatch_async(dispatch_get_main_queue()) {
        }
    }
    
    func getUserMedia(id:String){
         NSUserDefaults.standardUserDefaults().setValue(id, forKey: "RoomId")
         callUserMedia()
    }
    
//    func getUserMedia(callback:String, errorCallBack:String){
//        print("callback is ", callback)
//        dispatch_async(dispatch_get_main_queue()) {
//            self.performSelector("callUserMedia", withObject: nil, afterDelay: 2.0)
//        }
//    }
    
    func callUserMedia() {
        dispatch_async(dispatch_get_main_queue()) {
            NSNotificationCenter.defaultCenter().postNotificationName("startUserMedia", object: nil)
        }
    }
}