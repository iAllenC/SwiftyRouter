//
//  URL+Router.swift
//  URLHandler
//
//  Created by 陈元兵 on 2020/3/13.
//  Copyright © 2020 陈元兵. All rights reserved.
//

import Foundation

extension URL {
    var queryParameter: [String: String]? {
        guard let query = query else {
            return nil
        }
        return query.components(separatedBy: "&").map {
            $0.components(separatedBy: "=")
        }.filter {
            $0.count == 2
        }.reduce([:]) { result, element -> [String: String] in
            var mutResult = result
            mutResult[element[0]] = element[1]
            return mutResult
        }
    }
}

@objc extension NSURL {
    var queryParameter: [String: String]? {
        return (self as URL).queryParameter
    }
}
