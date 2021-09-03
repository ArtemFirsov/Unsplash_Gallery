//
//  ImagesViewController.swift
//  W&F
//
//  Created by Artem Firsov on 8/21/21.
//

import UIKit

private let reuseIdentifier = "Cell"

class ImagesViewController: UICollectionViewController {
    var outId: String = ""
//    var inputPhotosArray: [String] = []
    var randomPhotoArray = [RandomPhotoModel]()
    var searchPhotoArray = [Result]()
//    var info = [PhotoInfoModel]()
    
    
    var isSearching = false
    private var timer: Timer?
    var apiService = ApiService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        configureCompLayout()
        
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CellId")
        self.collectionView.register(RandomImageCell.self, forCellWithReuseIdentifier: RandomImageCell.reuseIden)
        
        self.apiService.getRandomPhotos { [weak self] response in
            guard let self = self else { return }
            self.randomPhotoArray = response
//            response.map { (photo) in
//                self.inputPhotosArray.append(photo.urls["small"] ?? "nothing")
//            }
            self.collectionView.reloadData()

        }
        
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearching {
            return searchPhotoArray.count
        } else {
            return randomPhotoArray.count
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isSearching {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RandomImageCell.reuseIden, for: indexPath) as? RandomImageCell else { return UICollectionViewCell()}

            let searchPhoto = searchPhotoArray[indexPath.item]
            cell.searchPhotoOut = searchPhoto
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RandomImageCell.reuseIden, for: indexPath) as? RandomImageCell else { return UICollectionViewCell()}
            let randomPhoto = randomPhotoArray[indexPath.item]
            cell.randomPhotoOut = randomPhoto
            return cell
        }
    }
    
//    func setupSaveButton() {
//        let titleLabel = UILabel()
//        titleLabel.text = "Photos"
//        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
//
//        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleLabel)
//        navigationItem.rightBarButtonItem = addButton
//    }
    
    private func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
    }
    
}

extension ImagesViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        isSearching = true
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.apiService.getPhotos(searchTerm: searchText) { [weak self] (searchResponse) in
                guard let response = searchResponse else { return }
                self?.searchPhotoArray = response.results
                self?.collectionView.reloadData()
                }
        })
        }
    
}


extension ImagesViewController {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? RandomImageCell else {return}
        if isSearching {
            let id = cell.searchPhotoOut.id
            self.outId = id
        } else {
            let id = cell.randomPhotoOut.id
            self.outId = id
        }
        performSegue(withIdentifier: "Images-Detail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Images-Detail" {
            if let dst = segue.destination as? DetailPhotoController {
                dst.inputId = outId
            }
        }
    }

}

extension ImagesViewController {

    func configureCompLayout() {

        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CellId")
        collectionView.setCollectionViewLayout(firstLayout(), animated: true)
    }

    func firstLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(0.5))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 3, leading: 3, bottom: 3, trailing: 3)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(400))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
//        section.orthogonalScrollingBehavior = .continuous
//        return section
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }

}
