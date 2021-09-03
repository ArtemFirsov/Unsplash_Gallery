//
//  RandomPhotoModel.swift
//  W&F
//
//  Created by Artem Firsov on 8/22/21.
//
import Foundation

// MARK: - RandomPhotoModel
struct RandomPhotoModel: Decodable {
    let color: String
    let downloads: Int
    let id: String
    let urls: [Urls.RawValue:String]
    
    enum Urls: String {
        case raw
        case full
        case regular
        case small
        case thumb
    }
}



