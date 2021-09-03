//
//  FavoriteImagesViewController.swift
//  W&F
//
//  Created by Artem Firsov on 8/21/21.
//

import UIKit
import SDWebImage

class FavoriteImagesViewController: UITableViewController {

    var outId: String = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FavoriteImageCell.self, forCellReuseIdentifier: FavoriteImageCell.reuseIden)
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        FavoriteStorage.shared.favoriteImages.remove(at: indexPath.row)
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FavoriteStorage.shared.favoriteImages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteImageCell.reuseIden, for: indexPath) as? FavoriteImageCell else { return UITableViewCell()}
        let favoritePhoto = FavoriteStorage.shared.favoriteImages[indexPath.row]
        cell.favoritePhoto = favoritePhoto
        cell.setupImageConstraints()
        cell.setupLabelConstraints()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}


extension FavoriteImagesViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? FavoriteImageCell else { return }
        let id = cell.favoritePhoto.id
        self.outId = id
        performSegue(withIdentifier: "Favorite-Detail", sender: nil)
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Favorite-Detail" {
            if let dst = segue.destination as? DetailPhotoController {
                dst.inputId = self.outId
            }
        }
    }
    
}
