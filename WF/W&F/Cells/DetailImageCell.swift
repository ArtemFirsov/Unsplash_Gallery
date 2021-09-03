//
//  File.swift
//  W&F
//
//  Created by Artem Firsov on 8/21/21.
//

import UIKit

class DetailImageCell: UICollectionViewCell {
    
    static let reuseIden = "DetailImageCell"
    
    var photoInfo: PhotoInfoModel! {
        didSet {
            let photoUrl = photoInfo.urls["small"] ?? "nothing"
            guard let url = URL(string: photoUrl) else { return }
            imageView.sd_setImage(with: url, placeholderImage: UIImage())
            let downloadText = photoInfo.downloads
            downloadsLabel.text = "Скачиваний - " + String(downloadText)
            nameLabel.text = "Автор - " + photoInfo.user.username
            dateLabel.text = "Дата создания - " + photoInfo.created_at
            let city = photoInfo.location.city ?? "не"
            let country = photoInfo.location.country ?? "указано"
            geoLabel.text = "Местоположение - " + city + ", " + country
        }
    }
    
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    func setupImageConstraints() {
        addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 30).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -150).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    }
    
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.systemFont(ofSize: 16)
        return nameLabel
    }()
    
    func setupNameConstraints() {
        addSubview(nameLabel)
        nameLabel.bottomAnchor.constraint(equalTo: imageView.topAnchor, constant: -10).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 5).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2).isActive = true
    }
    
    private let downloadsLabel: UILabel = {
        let downloadsLabel = UILabel()
        downloadsLabel.translatesAutoresizingMaskIntoConstraints = false
        downloadsLabel.font = UIFont.systemFont(ofSize: 13)
        downloadsLabel.textColor = UIColor.black
        downloadsLabel.numberOfLines = 0
        return downloadsLabel
    }()
    
    func setupDownloadsConstraints() {
        addSubview(downloadsLabel)
        downloadsLabel.bottomAnchor.constraint(equalTo: imageView.topAnchor, constant: -10).isActive = true
        downloadsLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -5).isActive = true
    }
    
    private let geoLabel: UILabel = {
        let geoLabel = UILabel()
        geoLabel.translatesAutoresizingMaskIntoConstraints = false
        geoLabel.font = UIFont.systemFont(ofSize: 13)
        geoLabel.textColor = UIColor.black
        geoLabel.numberOfLines = 0
        return geoLabel
    }()

    func setupGeoConstraints() {
        addSubview(geoLabel)
        geoLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
        geoLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -5).isActive = true
    }
    
    private let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.font = UIFont.systemFont(ofSize: 13)
        dateLabel.textColor = UIColor.black
        dateLabel.numberOfLines = 0
        return dateLabel
    }()
    
    func setupDateConstraints() {
        addSubview(dateLabel)
        dateLabel.topAnchor.constraint(equalTo: geoLabel.bottomAnchor, constant: 10).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -5).isActive = true
//        downloadsLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageConstraints()
        setupNameConstraints()
        setupDownloadsConstraints()
        setupGeoConstraints()
        setupDateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        clearCell()
    }
    
    func clearCell() {
        imageView.image = nil
        downloadsLabel.text = nil
        dateLabel.text = nil
        geoLabel.text = nil
        nameLabel.text = nil
    }
}
