//
//  RandomImageCell.swift
//  W&F
//
//  Created by Artem Firsov on 8/21/21.
//

import UIKit
import SDWebImage

class RandomImageCell: UICollectionViewCell {
    static let reuseIden = "RandomImageCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var searchPhotoOut: Result! {
        didSet {
            let photoid = searchPhotoOut.id
            let photoUrl = searchPhotoOut.urls["small"]
            guard let imageUrl = photoUrl, let url = URL(string: imageUrl) else { return }
            imageView.sd_setImage(with: url, placeholderImage: UIImage())
//            imageView.sd_setImage(with: URL(string: photoUrl), placeholderImage: UIImage())
//            if let url = URL(string: photoUrl) {
//            let data = try? Data(contentsOf: url)
//            let image = UIImage(data: data!)
//            }
        }
    }

    var randomPhotoOut: RandomPhotoModel! {
        didSet {
            let photoid = randomPhotoOut.id
            let photoUrl = randomPhotoOut.urls["small"]
            guard let imageUrl = photoUrl, let url = URL(string: imageUrl) else { return }
            imageView.sd_setImage(with: url, placeholderImage: UIImage())
        }
    }
    
    func setupImageConstraints() {
        addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    }
    
   
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupImageConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        clearCell()
    }
    
    func clearCell() {
        imageView.image = nil
    }
}
