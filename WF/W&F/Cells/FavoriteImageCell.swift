//
//  FavoriteImageCell.swift
//  W&F
//
//  Created by Artem Firsov on 9/2/21.
//

import UIKit

class FavoriteImageCell: UITableViewCell {

    static let reuseIden = "FavoriteCell"
    
    var favoritePhoto: PhotoInfoModel! {
        didSet {
            nameLabel.text = "Автор - " + favoritePhoto.user.username
            let photoUrl = favoritePhoto.urls["small"] ?? "nothing"
            guard let url = URL(string: photoUrl) else { return }
            photoView.sd_setImage(with: url, placeholderImage: UIImage())
        }
    }
    
    private let photoView: UIImageView = {
        let photoView = UIImageView()
        photoView.translatesAutoresizingMaskIntoConstraints = false
        photoView.contentMode = .scaleAspectFill
        photoView.clipsToBounds = true
        return photoView
    }()
    
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.systemFont(ofSize: 16)
        return nameLabel
    }()
    
    func setupImageConstraints() {
        addSubview(photoView)
        photoView.topAnchor.constraint(equalTo: self.topAnchor, constant: 3).isActive = true
        photoView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -3).isActive = true
        photoView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        let aspectRatio = NSLayoutConstraint(item: photoView, attribute: .height, relatedBy: .equal, toItem: photoView, attribute: .width, multiplier: (1/1), constant: 0)
        photoView.addConstraint(aspectRatio)
    }
    
    func setupLabelConstraints() {
        addSubview(nameLabel)
        nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: photoView.trailingAnchor, constant: 12).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clearCell()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func clearCell() {
        nameLabel.text = nil
        photoView.image = nil
    }
    
}
