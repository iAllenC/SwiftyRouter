//
//  CRouter.swift
//  URLRouterDemo
//
//  Created by Dsee.Lab on 2020/3/14.
//  Copyright © 2020 Dsee.Lab. All rights reserved.
//

import Foundation
import URLRouter

struct CRouter: URLRouter {
    
    var module: String { "moduleC" }
    
    func route(_ url: URLConvertible, parameter: [String : Any]?, completion: RouteCompletion?) {
        let cvc = CViewController()
        pushViewController(cvc, animated: true)
    }
    
    
}
