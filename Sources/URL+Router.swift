//
//  URL+Router.swift
//  URLHandler
//
//  Created by iAllenC on 2020/3/13.
//  Copyright © 2020 iAllenC. All rights reserved.
//

import Foundation

extension URL {
    public var queryParameter: [String: String]? {
        guard let query = query else {
            return nil
        }
        var parameters = [String: String]()
        query.components(separatedBy: "&").forEach { component in
            guard let separatorIndex = component.firstIndex(of: "=") else { return }
            let keyRange = component.startIndex..<separatorIndex
            let valueRange = component.index(after: separatorIndex)..<component.endIndex
            let key = String(component[keyRange])
            let value = component[valueRange].removingPercentEncoding ?? String(component[valueRange])
            parameters[key] = value
        }
        return parameters
    }
}

@objc extension NSURL {
    var queryParameter: [String: String]? {
        return (self as URL).queryParameter
    }
}
