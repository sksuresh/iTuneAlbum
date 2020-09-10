//
//  AlbumDetailCoordinator.swift
//  iTueneAlbums
//
//  Created by Suresh Dokula on 09/10/20.
//  Copyright © 2020 suresh. All rights reserved.
//

import Foundation
import UIKit

protocol  AlbumDetailCoordinatorDelegate {
    func goToAppstore(url:URL)
}

class AlbumDetailCoordinator {
    private var viewController:ViewController? = nil
    private var album:Album?
    init(presenter:ViewController?, album:Album?) {
        self.viewController = presenter
        self.album = album
    }
}

extension AlbumDetailCoordinator: BaseCoordinatorProtocol {
     func start()
     {
        if let albumVC = self.viewController, let navigationVC = albumVC.navigationController {
            let albumDetailVC = AlbumDetailViewController()
            albumDetailVC.viewModel = AlbumDetailsViewModel(album: self.album, imageCache: AlbumDataManager.imageCache,delegate: self)
            navigationVC.pushViewController(albumDetailVC, animated: true)
        }
     }
}

extension AlbumDetailCoordinator: AlbumDetailCoordinatorDelegate {
    func goToAppstore(url: URL) {
       if   UIApplication.shared.canOpenURL(url)  {
        UIApplication.shared.open(url)
        }
    }
}
