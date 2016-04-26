How to work with this ?

1.Open the project by clicking Sample.xcworkspace as we use cocoapods 
2.Set up cocoapods to work with this project..we're using Apprtc sdk using Cocoapods
3.Choose Sample in Xcode Schemes

List of Frameworks used:

1.Xwebview -> To make interaction with WkWevView easier
2.Apprtc -> To establish WebRTC call

What is this ?

I am trying to create WebRTC(https://webrtc.org/) based hybrid iOS app.

In short:

WebRTC is HTML5 standard.
Using this we can make a VOIP call,Send message or transfer between two WebRTC supported Browsers,WebViews using Peer to Peer methodology.

What about iOS ?

iOS WebKit as of now doesn't support WebRTC APIs completely.

But there is a native SDK called APPRTC that supports all WebRTC APIs using this we can build pure WebRTC based VOIP applications in iOS ... I haven't explored it completely though.


Can you give a demo with so far what you have done ?

Yes ... 

1. Compile and run the project in iOS device 
2. Got to https://apprtc.appspot.com/ not the room name and click join
3. In device ...enter the noted Room name in the page and click VOIP Call

that's it you'll get connected !

What I am trying to do ?

I am trying to create a WebRTC based VOIP application which is hybrid.

I have a webapplication that will facilitate WebRTC Calls between devices ,It works with Android 5.0+ as its webview supports WebRTC APIs completely.But in iOS as it doesn't support ....I am going to support the APIs which are not supported using native AppRTC sdk.

For example In the project if you explore index.html you will see I have intercepted a WebRTC API navigator.getusermedia which is not supported in WebView and given the implementation using AppRTC native SDK.

So plan is to support functions natively that are not supported in webkit and make a complete WebRTC based Hybrid VOIP app.

Any help to achieve this is highly appreciated !
