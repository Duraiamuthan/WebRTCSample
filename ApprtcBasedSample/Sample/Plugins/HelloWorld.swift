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

import UIKit
import XWebView

class HelloWorld {
    @objc func show(text: AnyObject?) {
        dispatch_async(dispatch_get_main_queue()) {
            alert(title: text as? String, message: nil)
        }
    }
}

private func alert(title title: String?, message: String?) {
    guard let root = UIApplication.sharedApplication().keyWindow?.rootViewController else { return }
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
    root.presentViewController(alert, animated: true, completion: nil)
}
