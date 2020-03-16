//
//  CRouter.swift
//  RouterDemo
//
//  Created by Dsee.Lab on 2020/3/14.
//  Copyright © 2020 Dsee.Lab. All rights reserved.
//

import Foundation

struct CRouter: Router {
    
    static var module: String { "moduleC" }
    
    func route(_ url: URLConvertible, parameter: RouteParameter?, completion: RouteCompletion?) {
        let cvc = CViewController()
        pushViewController(cvc, animated: true)
        completion?(["result": cvc, "info": "Pushed View Controller:\(cvc)"])
    }
    
    
}
