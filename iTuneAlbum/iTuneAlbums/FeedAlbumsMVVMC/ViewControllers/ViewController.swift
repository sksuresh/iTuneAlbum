//
//  ViewController.swift
//  iTueneAlbums
//
//  Created by Suresh Dokula on 09/10/20.
//  Copyright © 2020 suresh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var refreshControl = UIRefreshControl()
    lazy var albumTableView:UITableView =  {
         let tableView = UITableView(frame: .zero, style: .plain)
         tableView.translatesAutoresizingMaskIntoConstraints = false
         tableView.delegate = self
         tableView.dataSource = self
         return tableView
    }()
    
    var viewModel:AlbumViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Albums"
        setup()
        getAlbums()
        addPullToRefresh()
    }
    
    private func addPullToRefresh(){
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        albumTableView.addSubview(refreshControl)
    }
    
    @objc private func refresh(_ sender: Any) {
        self.getAlbums()
    }
    
    func getAlbums(){
        guard let _ = viewModel  else { return }
        self.viewModel?.jsonParsing { (result:DataFetchStatus?) in
            switch result {
            case .success(let feed)?:
                    self.viewModel?.feed = feed
                    DispatchQueue.main.async {
                            self.albumTableView.reloadData()
                            self.refreshControl.endRefreshing()
                        }
            case .fail(_)?:
                DispatchQueue.main.async {

                    let alert = UIAlertController(title: "Service Error", message: "Something went wrong", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "Ok",
                                                              style: UIAlertAction.Style.default,
                                                              handler: {(_: UIAlertAction!) in
                                }))
                                self.present(alert, animated: true, completion: nil)
                }
                
            case .none:
                break
            }
        }
    }
    
    override func loadView() {
        self.view = UIView()
    }
    
    private func setup(){
        self.view.addSubview(self.albumTableView)
        let views = ["tblAlbum": self.albumTableView]
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[tblAlbum]-0-|", options: [], metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[tblAlbum]-0-|", options: [], metrics: nil, views: views))
        self.view.setNeedsUpdateConstraints()
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.feed?.feed?.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:AlbumsTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "AlbumCell") as? AlbumsTableViewCell
        if cell == nil {
            cell = AlbumsTableViewCell(style: .subtitle, reuseIdentifier: "AlbumCell")
        }
        if let viewModel = self.viewModel, let results = viewModel.feed?.feed?.results {
            cell?.presentData(viewModel: viewModel, album: results[indexPath.row])
        }
        return cell ?? UITableViewCell()
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let delegate =  self.viewModel?.delegate else { return }
        delegate.goToAlbumDetailController(album: self.viewModel?.feed?.feed?.results?[indexPath.row])
    }
}
