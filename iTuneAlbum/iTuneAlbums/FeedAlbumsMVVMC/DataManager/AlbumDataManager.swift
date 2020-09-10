//
//  AlbumDataManager.swift
//  iTueneAlbums
//
//  Created by Suresh Dokula on 09/10/20.
//  Copyright © 2020 suresh. All rights reserved.
//

import Foundation

class AlbumDataManager {
    
    static var imageCache = NSCache<NSString, NSData>()

     func getFeeds(completion:@escaping ((_ feed:Feeds?, _ responseResult:ResponseResult?) -> Void)) {
        SessionManager.shared.request(url:URLDataPoint.stringUrl(path: .rssFeedAlbum), headers: HTTPHeaders.contentType(HTTPContentType.json.description)) { (data:Data?, error:Error?, responseResult:ResponseResult?) in
                guard let data = data  else { return  completion(nil, responseResult) }
                do {
                    let decoder = JSONDecoder()
                    let feed = try decoder.decode(Feeds.self, from: data)
                    completion(feed, nil)
                } catch  _ {
                        completion(nil, responseResult)
                }
            }
    }
    
     func getImage(imgUrl:String, completion:@escaping ((_ albumData:Data?, _ responseResult:ResponseResult?) -> Void)) {
        if let data = AlbumDataManager.imageCache.object(forKey: imgUrl as NSString) {
            completion(data as Data, nil)
        }else {
            SessionManager.shared.request(url:imgUrl) { (data:Data?, error:Error?, responseResult:ResponseResult?) in
                guard let data = data  else {
                    completion(nil, responseResult)
                    return
                }
                AlbumDataManager.imageCache.setObject(data as NSData, forKey: imgUrl as NSString)
            completion(data, nil)
            }
        }
    }
}
