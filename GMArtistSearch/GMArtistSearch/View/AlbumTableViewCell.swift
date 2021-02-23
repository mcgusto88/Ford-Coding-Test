//
//  AlbumCell.swift
//  GMArtistSearch
//
//  Created by Augustus Wilson on 02/18/21.
//  Copyright © 2021 Augustus Wilson. All rights reserved.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    
    internal let albumImage : UIImageView = {
        let imageView =  UIImageView(frame: .zero)
        imageView.accessibilityIdentifier = "Album Image"
        imageView.translatesAutoresizingMaskIntoConstraints = false;
        imageView.backgroundColor = .lightGray;
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        return imageView;
    }()
    
    internal let albumName : UILabel  = {
        let label  =  UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.accessibilityIdentifier = "Album Name"
        label.font = UIFont.init(name: "AvenirNext-Regular", size: 18.0)
        return label;
    }()
    
    internal let artistName : UILabel  = {
        let label  =  UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.accessibilityIdentifier = "Artist Name"
        label.font = UIFont.init(name: "AvenirNext-Regular", size: 16.0)
        label.textColor = .gray
        return label;
    }()

    internal let releaseDate : UILabel  = {
        let label  =  UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.accessibilityIdentifier = "Release Date"
        label.font = UIFont.init(name: "AvenirNext-Regular", size: 14.0)
        label.textColor = .gray
        return label;
    }()

    
    internal let genre : UILabel  = {
        let label  =  UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.accessibilityIdentifier = "Genre"
        label.font = UIFont.init(name: "AvenirNext-Regular", size: 14.0)
        label.textColor = .gray
        return label;
    }()

    internal let trackPrice : UILabel  = {
        let label  =  UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.accessibilityIdentifier = "Track Price"
        label.font = UIFont.init(name: "AvenirNext-Regular", size: 14.0)
        label.textColor = .gray
        return label;
    }()

    
    
    private var placeholderView : UIStackView =   {
        let view =  UIStackView()
        view.axis = .vertical
        view.distribution = .fillProportionally
        view.translatesAutoresizingMaskIntoConstraints = false;
        return view;
    }()
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupContraints();
        accessoryType = .none
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupContraints();
        accessoryType = .none
    }
    
    deinit {
        print("Albumcell deinit")
    }
        
    internal func setupContraints() {
        addSubview(albumImage)
        addSubview(placeholderView)
        placeholderView.addArrangedSubview(albumName)
        placeholderView.addArrangedSubview(artistName)
        placeholderView.addArrangedSubview(releaseDate)
        placeholderView.addArrangedSubview(genre)
        placeholderView.addArrangedSubview(trackPrice)


        NSLayoutConstraint.activate([
            albumImage.topAnchor.constraint(equalTo: self.topAnchor,constant: 8),
            albumImage.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 8),
            albumImage.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -8),
            albumImage.widthAnchor.constraint(equalToConstant: 100),
        ])
        
        NSLayoutConstraint.activate([
            placeholderView.topAnchor.constraint(equalTo:self.topAnchor),
            placeholderView.leadingAnchor.constraint(equalTo: albumImage.trailingAnchor,constant: 8),
            placeholderView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            placeholderView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        accessoryType = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    internal func refreshWith(album: Album) {
        albumImage.loadImageUsingCache(withUrl: album.imageUrl)
        albumName.text = album.name
        artistName.text = album.artistName
        releaseDate.text = String(album.releaseDate.prefix(10))
        genre.text = album.primaryGenreName
        trackPrice.text = (album.trackPrice != nil) ? "$ " + String(album.trackPrice!) : "NA"
    }
}
