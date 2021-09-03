//
//  RandomPhotoModel.swift
//  W&F
//
//  Created by Artem Firsov on 8/22/21.
//
import Foundation

struct PhotoInfoModel: Decodable {
    let id: String
    let created_at: String
    let downloads: Int
    let urls: [Urls.RawValue:String]
    let user: User
    let location: Geo
    
    enum Urls: String {
        case raw
        case full
        case regular
        case small
        case thumb
    }
}

struct User: Decodable {
    let id: String
    let username: String
}

struct Geo: Decodable {
    let city: String?
    let country: String?
}
