//
//  FavoriteStorage.swift
//  W&F
//
//  Created by Artem Firsov on 9/2/21.
//

import Foundation

class FavoriteStorage: NSObject {
    static let shared = FavoriteStorage()
    private override init() {
        super.init()
    }
    
    var favoriteImages = [PhotoInfoModel]()
}
