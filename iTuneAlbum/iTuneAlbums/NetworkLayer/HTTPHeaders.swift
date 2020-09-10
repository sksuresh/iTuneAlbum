//
//  HTTPHeaders.swift
//  iTueneAlbums
//
//  Created by Suresh Dokula on 09/10/20.
//  Copyright © 2020 suresh. All rights reserved.
//

import Foundation

enum HTTPContentType {
    case json
    
    var description:String  {
        switch self {
        case .json:
            return "application/json"
        }
    }
}

struct HTTPHeaders: Hashable {
    var headers:[HTTPHeaders] = []
    let name:String
    let value:String
    
    init(name:String, value:String) {
        self.name = name
        self.value = value
    }
    
    public var dictionary: [String: String] {
        let namesAndValues = headers.map { ($0.name, $0.value) }
        
        return Dictionary(namesAndValues, uniquingKeysWith: { _, last in last })
    }
}

extension HTTPHeaders {
    public static func contentType(_ value: String) -> HTTPHeaders {
        return HTTPHeaders(name: "Content-Type", value: value)
    }

}
