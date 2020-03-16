//
//  ToolRouter.swift
//  Router
//
//  Created by Dsee.Lab on 2020/3/14.
//  Copyright © 2020 iAllenC. All rights reserved.
//

import UIKit
import SwiftyURLRouter

struct ToolRouter: Router {
    
    static var module: String { "module_tool" }
    
    func subRouter(for module: String) -> Router? {
        return module == "alert" ? AlertRouter() : nil
    }
    
    func route(_ url: URLConvertible, parameter: RouteParameter?, completion: RouteCompletion?) {
        routeAfterSub(url, parameter: parameter, completion: completion) { _,_,_  in return }
    }
    
    
}

struct AlertRouter: Router {
    
    static var module: String { "alert" }
    
    func route(_ url: URLConvertible, parameter: RouteParameter?, completion: RouteCompletion?) {
        if let param = url.queryParameter {
            let title = param["title"]
            let message = param["message"]
            let sure = param["sure"]
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: sure, style: .cancel, handler: nil))
            topViewController?.present(alert, animated: true, completion: {
                completion?(["result": true])
            })
        }
        
    }
    
    
}
