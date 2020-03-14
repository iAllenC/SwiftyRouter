//
//  BRouter.swift
//  URLHandler
//
//  Created by iAllenC on 2020/3/13.
//  Copyright © 2020 iAllenC. All rights reserved.
//

import UIKit
import URLRouter

struct BRouter: URLRouter {
    
    var module: String { "moduleB" } 
    
    func route(_ url: URLConvertible, parameter: [String: Any]?, completion: (([String: Any]) -> Void)?) {
        let bvc = BViewController()
        bvc.value = parameter?["value"] as? String
        pushViewController(bvc, animated: true)
        completion?(["result": bvc])
    }
        
}
