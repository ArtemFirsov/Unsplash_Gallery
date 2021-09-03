//
//  ApiService.swift
//  W&F
//
//  Created by Artem Firsov on 8/21/21.
//

import Foundation
import Alamofire

class ApiService {
    
    let baseUrl = "https://api.unsplash.com/"
    let token = "1AoikOxOnE76wmkTiu0Fo32UmNO0T4e2Zjd3MxhBo_A"


    func getPhotos(searchTerm: String, completion: @escaping(SearchModel?) ->()) {
        let method = "/search/photos"
        let url = baseUrl + method
//        let header: HTTPHeaders = ["Autorization" : "Client-ID \(token)"]
        let parameters: Parameters = ["query": searchTerm,
                                      "page": String(1),
                                      "per_page": String(30),
                                      "client_id": token]
        
        AF.request(url, method: .get, parameters: parameters/*, headers: header*/).responseData { response in
            guard let data = response.data else { return }
//            print(data.prettyJSON as Any)
            do {
            guard let photosResponse = try? JSONDecoder().decode(SearchModel.self, from: data) else { return }
                DispatchQueue.main.async {
                completion(photosResponse)
                }
            } catch {
                print(error)
              }
        }

    }
  
        func getPhoto(id: String, completion: @escaping(PhotoInfoModel?) -> ()) {
        let method = "/photos/\(id)"
        let url = baseUrl + method
        let parameters: Parameters = ["client_id": token]
        
        AF.request(url, method: .get, parameters: parameters).responseData { response in
            guard let data = response.data else { return }
//            print(data.prettyJSON)
            do {
                guard let photoResponse = try? JSONDecoder().decode(PhotoInfoModel.self, from: data) else { return }
                DispatchQueue.main.async {
                    completion(photoResponse)
                }
            } catch {
                print(error)
            }
        }
        
    }
    
    public var randomPhotoArray: [RandomPhotoModel] = []
    func getRandomPhotos(completion: @escaping([RandomPhotoModel]) ->()) {
        let method = "/photos/random/"
        let url = baseUrl + method
        let parameters: Parameters = ["count": String(30),
                                      "client_id": token]
        
        AF.request(url, method: .get, parameters: parameters).responseData { response in
            guard let data = response.data else { return }
//            print(data.prettyJSON as Any)
            do {
            guard let photosResponse = try? JSONDecoder().decode([RandomPhotoModel].self, from: data) else { return }
                for photo in photosResponse {
                    DispatchQueue.main.async {
                        self.randomPhotoArray.append(photo)
                    }
                }
                DispatchQueue.main.async {
                    completion(self.randomPhotoArray)
                }
            } catch {
                print(error)
              }
        }

    }
    
}
