//
//  ARouter.swift
//  URLRouter
//
//  Created by Dsee.Lab on 2020/3/13.
//  Copyright © 2020 Dsee.Lab. All rights reserved.
//

import UIKit

class ARouter: URLRouter {
    
    var module: String = "moduleA"
    
    func route(_ url: URL, parameter: [String: Any]?, completion: (([String: Any]) -> Void)?) {
        let avc = AViewController()
        avc.value = url.queryParameter?["value"]
        pushViewController(avc, animated: true)
        completion?(["result": avc])
    }
    
    func fetch(_ url: URL, parameter: [String : Any]?, completion: (([String : Any]) -> Void)?) -> UIViewController? {
        let avc = AViewController()
        avc.value = url.queryParameter?["value"]
        completion?(["result": avc])
        return avc
    }
}
