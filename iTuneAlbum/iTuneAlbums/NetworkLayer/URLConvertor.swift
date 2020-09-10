//
//  URLConvertor.swift
//  iTueneAlbums
//
//  Created by Suresh Dokula on 09/10/20.
//  Copyright © 2020 suresh. All rights reserved.
//

import Foundation

struct URLDataPoint {
    static func stringUrl(host:HostType = HostType.https, domain: HostDomains = HostDomains.rssFeed, path:URLPaths) -> String {
        return host.rawValue + domain.rawValue + path.rawValue
    }
}

public extension DispatchQueue {
    func wait(seconds: Double, completion: @escaping () -> Void) {
        asyncAfter(deadline: .now() + seconds) { completion() }
    }
}

public enum HostDomains:String {
    case rssFeed = "rss.itunes.apple.com"
}


public enum URLPaths:String {
    case rssFeedAlbum = "/api/v1/us/apple-music/coming-soon/all/100/explicit.json"
}

public enum HostType:String {
    case https = "https://"
}
