//
//  CRouter.swift
//  RouterDemo
//
//  Created by Dsee.Lab on 2020/3/14.
//  Copyright © 2020 Dsee.Lab. All rights reserved.
//

import Foundation
import SwiftyURLRouter

struct CRouter: Router {
    
    static var module: String { "module_c" }
    
    func route(_ url: URLConvertible, parameter: RouteParameter?, completion: RouteCompletion?) {
        let cvc = CViewController()
        Transfer.push(cvc, animated: true)
        completion?(["result": cvc, "info": "Pushed View Controller:\(cvc)"])
    }
    
    
}
