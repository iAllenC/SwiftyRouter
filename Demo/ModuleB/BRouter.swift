//
//  BRouter.swift
//  URLHandler
//
//  Created by iAllenC on 2020/3/13.
//  Copyright © 2020 iAllenC. All rights reserved.
//

import UIKit
import SwiftyURLRouter

struct BRouter: Router {
    
    static var module: String { "module_b" } 
    
    func route(_ url: URLConvertible, parameter: RouteParameter?, completion: RouteCompletion?) {
        let bvc = BViewController()
        bvc.value = url.queryParameter?["value"]
        bvc.image = parameter?["image"] as? UIImage
        bvc.completion = completion
        RootJumper.push(bvc, animated: true)
    }
        
}
