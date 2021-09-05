//
//  MainVC.swift
//  W&F
//
//  Created by Artem Firsov on 9/5/21.
//

import UIKit

class MainVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imagesVC = ImagesViewController(collectionViewLayout: UICollectionViewFlowLayout())

        viewControllers = [setNavigationVC(rootVC: imagesVC, title: "Фотографии", image: UIImage(systemName: "photo") ?? UIImage()), setNavigationVC(rootVC: FavoriteImagesViewController(), title: "Сохраненные", image: UIImage(systemName: "heart.fill") ?? UIImage())]

    }
    
    private func setNavigationVC(rootVC: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navigationController = UINavigationController(rootViewController: rootVC)
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image
        return navigationController
    }
}
