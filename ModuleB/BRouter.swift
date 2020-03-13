//
//  BRouter.swift
//  URLHandler
//
//  Created by iAllenC on 2020/3/13.
//  Copyright © 2020 iAllenC. All rights reserved.
//

import UIKit

class BRouter: URLRouter {
    
    var module: String = "moduleB"
    
    var subRouters: [String : URLRouter]?

    func route(_ url: URL, parameter: [String: Any]?, completion: (([String: Any]) -> Void)?) {
        let bvc = BViewController()
        bvc.value = url.queryParameter?["value"]
        pushViewController(bvc, animated: true)
        completion?(["result": bvc])
    }
    
    func fetch(_ url: URL, parameter: [String : Any]?, completion: (([String : Any]) -> Void)?) -> UIViewController? {
        let bvc = BViewController()
        bvc.value = url.queryParameter?["value"]
        completion?(["result": bvc])
        return bvc
    }
    
}
