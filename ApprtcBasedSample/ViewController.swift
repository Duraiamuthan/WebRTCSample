/*
 Copyright 2015 XWebView

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
*/

import CoreFoundation
import UIKit
import WebKit
import XWebView


class ViewController: UIViewController, ARDAppClientDelegate, RTCEAGLVideoViewDelegate  {
    
    var webview:WKWebView?
    var localVideoView:RTCEAGLVideoView?
    var remoteVideoView:RTCEAGLVideoView?
    var appClient:ARDAppClient?
    var localVideoTrack:RTCVideoTrack?
    var remoteVideoTrack:RTCVideoTrack?
    var btnDisconnect:UIButton?
    var frameLocalVideoView:CGRect?
    var frameRemoteVideoView:CGRect?
    var frameBtnDisconnect:CGRect?
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        
        MapItemsOnInterface(size)
        
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
    }
    
    func MapItemsOnInterface(let size:CGSize!)
    {
        let width = size.width
        let height = size.height
        let btnHeight:CGFloat=90.0
        
        frameLocalVideoView = CGRectMake(0,0,width,(height/2)-(btnHeight/2))
        frameRemoteVideoView = CGRectMake(0,(height/2)-(btnHeight/2),width,(height/2)-(btnHeight/2))
        frameBtnDisconnect = CGRectMake(0,height-btnHeight,width,btnHeight)
        
        localVideoView?.frame = frameLocalVideoView!
        remoteVideoView?.frame = frameRemoteVideoView!
        btnDisconnect!.frame = frameBtnDisconnect!
    
        webview?.frame=view.frame
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        webview = WKWebView(frame: view.frame, configuration: WKWebViewConfiguration())
        webview!.scrollView.bounces = false
        view.addSubview(webview!)
        
        
        
        localVideoView = RTCEAGLVideoView()
        
        remoteVideoView = RTCEAGLVideoView()
        
        btnDisconnect = UIButton(type:UIButtonType.Custom) as UIButton
        btnDisconnect?.setBackgroundImage(UIImage(named: "EndCall.png"), forState: UIControlState.Normal)
        btnDisconnect!.addTarget(self, action: "disconnect", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        MapItemsOnInterface(view.frame.size)
        
        //localVideoView?.delegate = self
        
        view.addSubview(localVideoView!)
        view.addSubview(remoteVideoView!)
        view.addSubview(btnDisconnect!)
        
        
        localVideoView?.hidden = true;
        remoteVideoView?.hidden = true;
        btnDisconnect?.hidden=true;
        webview?.hidden=false;

        webview!.loadPlugin(JSHandler(), namespace: "myWebRTC")
    
        let root = NSBundle.mainBundle().resourceURL!
        
        let url1 = root.URLByAppendingPathComponent("index.html")
       
        if #available(iOS 9.0, * ){
            webview!.loadFileURL(url1, allowingReadAccessToURL: root)
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "OnGetUserMedia", name: "startUserMedia", object: nil)
    }


    func loadRequestWithUrl(url:String) {
        let request:NSURLRequest? = NSURLRequest(URL: NSURL(string: url)!, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 10)
        webview?.loadRequest(request!)
    }
    
    
    func videoView(videoView: RTCEAGLVideoView!, didChangeVideoSize size: CGSize) {
        print("videoView changed")
    }
    
    
    func appClient(client: ARDAppClient!, didChangeState state: ARDAppClientState) {
        print("client didChangeState",state)
        
    }

    
    func appClient(client: ARDAppClient!, didReceiveLocalVideoTrack localVideoTrack: RTCVideoTrack!) {
        print("client local track")
        self.localVideoTrack = localVideoTrack
        self.localVideoTrack!.addRenderer(self.localVideoView)
    }
    
    
    func appClient(client: ARDAppClient!, didReceiveRemoteVideoTrack remoteVideoTrack: RTCVideoTrack!) {
        print("remote video track")
        self.remoteVideoTrack = remoteVideoTrack
        self.remoteVideoTrack!.addRenderer(self.remoteVideoView)
    }
    
    
    func appClient(client: ARDAppClient!, didError error: NSError!) {
        
    }
    
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    func OnGetUserMedia()
    {
        print(" start user Media")
        if let roomId=NSUserDefaults.standardUserDefaults().valueForKey("RoomId"){
        appClient = ARDAppClient(delegate: self)
        appClient?.createLocalMediaStream()
        appClient?.connectToRoomWithId(String(roomId), options: nil)
        localVideoView?.hidden = false;
        remoteVideoView?.hidden = false;
        btnDisconnect?.hidden = false;
        webview?.hidden = true;
        }
    }
    
    func disconnect(){
        appClient?.disconnect()
        if let remoteVideoTrack=self.remoteVideoTrack {
        self.remoteVideoTrack!.removeRenderer(self.remoteVideoView)
        }
        self.localVideoTrack!.removeRenderer(self.localVideoView)
        self.remoteVideoTrack=nil;
        self.localVideoTrack=nil;
        localVideoView?.hidden = true;
        remoteVideoView?.hidden = true;
        btnDisconnect?.hidden = true;
        webview?.hidden=false;
    }
    
    func createUDID()
    {
        let obj:CFUUIDRef = CFUUIDCreate(kCFAllocatorDefault)
        let str:String = CFUUIDCreateString(kCFAllocatorDefault, obj) as String
        var js:String = "alert("
        js = js+"'"
        js = js+str
        js=js+"'"
        js=js+")"
        do{
        try webview?.evaluateJavaScript("test()")
        }
        catch{
            
        }
    }
}
