//
//  AlbumDetailsViewModel.swift
//  iTueneAlbums
//
//  Created by Suresh Dokula on 09/10/20.
//  Copyright © 2020 suresh. All rights reserved.
//

import Foundation

struct AlbumDetailsViewModel {
    var album:Album?
    var imageCache:NSCache<NSString, NSData>?
    var delegate:AlbumDetailCoordinatorDelegate?
    
    init(album:Album?, imageCache:NSCache<NSString, NSData>?, delegate:AlbumDetailCoordinatorDelegate?) {
        self.album = album
        self.imageCache = imageCache
        self.delegate = delegate
    }
    
    func getImage(imgUrl:String, completion:@escaping ((_ data:Data?) -> Void)){
        AlbumDataManager().getImage(imgUrl: imgUrl) { (data:Data?, responseResult:ResponseResult?) in
                guard let data = data  else { return completion(nil)}
                completion(data)
            }
        }
    
    func openUrl() {
        guard let album = self.album,let urlString = album.url, let url = URL(string: urlString)  else { return }
        if let delegate = self.delegate {
             delegate.goToAppstore(url: url)
        }
    }
}
