//
//  DetailPhotoController.swift
//  W&F
//
//  Created by Artem Firsov on 8/21/21.
//

import UIKit

class DetailPhotoController: UIViewController {
    
    var info = [PhotoInfoModel]()
    
    private lazy var addButton: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBarButton))
    }()
    @objc private func addBarButton() {
        guard let info = self.info.first else { return }
        
        var isEnablePhoto = false
        for item in FavoriteStorage.shared.favoriteImages {
            if item.id == info.id {
            isEnablePhoto = true
            }
        }
        
        if !isEnablePhoto {
            FavoriteStorage.shared.favoriteImages.append(info)
        } else {
            alertWindow(alertText: "Notification")
        }
        
        self.navigationController?.popViewController(animated: true)
        
        
    }
    
    func alertWindow(alertText: String) {
        let alertController = UIAlertController(title: "Ошибка!", message: "Это фото уже было добавлено", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        let deleteButton = UIAlertAction(title: "Удалить фото?", style: .destructive) { _ in
            guard let info = self.info.first else { return }
            for (index, item) in FavoriteStorage.shared.favoriteImages.enumerated() {
                if item.id == info.id {
                    if FavoriteStorage.shared.favoriteImages.count != 0 {
                    FavoriteStorage.shared.favoriteImages.remove(at: index)
                    } else { return }
                }
            }
            self.okAlert()
        }
        alertController.addAction(okButton)
        alertController.addAction(deleteButton)
        present(alertController, animated: true, completion: nil)
    }
    
    func okAlert() {
        let alertController = UIAlertController(title: "Ok", message: "Фото удалено!", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(okButton)
        present(alertController, animated: true, completion: nil)
    }
    
    var inputId: String = ""

    var apiService = ApiService()
    
    @IBOutlet weak var myCollection: UICollectionView! {
        didSet {
            myCollection.delegate = self
            myCollection.dataSource = self
            myCollection.register(DetailImageCell.self, forCellWithReuseIdentifier: DetailImageCell.reuseIden)
            myCollection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CellIden")

        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSaveButton()
        setNavConntroller()
        configureCompLayout()
        apiService.getPhoto(id: inputId) { response in

            guard let infoResponse = response else { return }
            self.info.append(infoResponse)
            self.myCollection.reloadData()
        }
    }

}

extension DetailPhotoController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if info.count == 1 {
        guard let cell = myCollection.dequeueReusableCell(withReuseIdentifier: DetailImageCell.reuseIden, for: indexPath) as? DetailImageCell else { return UICollectionViewCell()}
        cell.photoInfo = self.info.first
        return cell
        } else {
            let cell = myCollection.dequeueReusableCell(withReuseIdentifier: "CellIden", for: indexPath)
            return cell
        }
    }
}

extension DetailPhotoController {
    
    func configureCompLayout() {

        myCollection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CellId")
        myCollection.setCollectionViewLayout(Layout(), animated: true)
    }

    func Layout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        item.contentInsets = .init(top: 3, leading: 3, bottom: 3, trailing: 3)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 10, leading: 10, bottom: 0, trailing: 10)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

extension DetailPhotoController {
    func setNavConntroller() {
        let source = DetailPhotoController()
        let navController = UINavigationController(rootViewController: source)
    }
    
    func setupSaveButton() {
//        let titleLabel = UILabel()
//        titleLabel.text = "Photo"
//        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
//
//        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleLabel)
        navigationItem.rightBarButtonItem = addButton
    }
    
}
