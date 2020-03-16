//
//  URLConvertible.swift
//  Router
//
//  Created by Dsee.Lab on 2020/3/14.
//  Copyright © 2020 iAllenC. All rights reserved.
//

import Foundation
public protocol URLConvertible {
    var asURL: URL { get }
    var queryParameter: [String: String]? { get }
}

public extension URLConvertible {
    var queryParameter: [String: String]? {
        asURL.queryParameter
    }
}

extension URL: URLConvertible {
    public var asURL: URL {
        self
    }
}

extension String: URLConvertible {
    public var asURL: URL {
        if let url = URL(string: self) {
          return url
        }
        var set = CharacterSet()
        set.formUnion(.urlHostAllowed)
        set.formUnion(.urlPathAllowed)
        set.formUnion(.urlQueryAllowed)
        set.formUnion(.urlFragmentAllowed)
        return self.addingPercentEncoding(withAllowedCharacters: set).flatMap { URL(string: $0) }!
    }
}
