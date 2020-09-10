//
//  AlbumsTableViewCell.swift
//  iTueneAlbums
//
//  Created by Suresh Dokula on 09/10/20.
//  Copyright © 2020 suresh. All rights reserved.
//

import UIKit

class AlbumsTableViewCell: UITableViewCell {

    func presentData(viewModel:AlbumViewModel, album:Album){
        self.textLabel?.text = album.name
        self.detailTextLabel?.text = album.artistName
        if let imgUrl = album.artworkUrl100 as NSString?, let imgData =  viewModel.imageCache?.object(forKey: imgUrl), let img = UIImage(data:  imgData as Data)   {
            self.imageView?.image = img
        } else {
            self.imageView?.image = UIImage(named: "gallery")
            viewModel.getImage(imgUrl:album.artworkUrl100 ?? "", completion: { (data:Data?) in
                DispatchQueue.main.async {
                    guard let data = data  else { return }
                    self.imageView?.image = UIImage(data: data)
                }
            })
        }
    }

}
