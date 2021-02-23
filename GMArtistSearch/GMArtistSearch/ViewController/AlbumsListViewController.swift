//
//  ViewController.swift
//  GMArtistSearch
//
//  Created by Augustus Wilson on 2/18/21.
//  Copyright © 2021 Augustus Wilson. All rights reserved.
//

import UIKit

typealias AlbumSelectionHandler = ((_ album:Album)->Void)

protocol AlbumListSummaryUI : UIViewController {
    var dataLoader : AlbumsDataLoader { get }
    var selectionHandler : AlbumSelectionHandler { get }
    func getAlbums(artistName:String)
}

class AlbumsListViewController: UITableViewController , AlbumListSummaryUI {
    
    private var albums : [Album] = []
    private let numberOfAlbumsToFetch = 100
    let dataLoader : AlbumsDataLoader
    var selectionHandler: AlbumSelectionHandler
    
    private let reuseIdentifier = "albumCell"
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    let searchController = UISearchController(searchResultsController: nil)

    
    init(dataLoader:AlbumsDataLoader,selectionHandler:@escaping AlbumSelectionHandler) {
        self.dataLoader = dataLoader
        self.selectionHandler = selectionHandler
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        setupUI()
        getAlbums(artistName:"michael-jackson")
    }
    
    private func setupUI() {
        self.tableView.accessibilityLabel = "Albums List"
        self.tableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false;
        activityIndicator.center = self.view.center
        activityIndicator.accessibilityLabel = "Album Loading Indicator"
        self.view.addSubview(activityIndicator)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Albums"
        navigationItem.searchController = searchController
    }
    
    func getAlbums(artistName: String) {
        self.activityIndicator.startAnimating()
        dataLoader.getAlbums(searchTerm: artistName) { [weak self] result in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
            }
            switch result {
            case .success(let albums ):
                self.albums = albums
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            case .failure(let error):
                let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle:.alert)
                let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(alertAction)
                DispatchQueue.main.async {
                    self.present(alertController, animated: true, completion: nil)
                }
                break
            }
        }
    }
}

//DataSource
extension AlbumsListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        albums.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell : AlbumTableViewCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? AlbumTableViewCell else {
            return UITableViewCell()
        }
        let album = albums[indexPath.row]
        cell.refreshWith(album: album)
        return cell
    }
        
}

//Delegate
extension AlbumsListViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let album = albums[indexPath.row]
        selectionHandler(album)
    }
}


extension AlbumsListViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    guard let searchTerm = searchController.searchBar.text,searchTerm.count > 0 else { return }
    getAlbums(artistName:searchTerm)
  }
}
