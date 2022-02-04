//
//  ServiceManager.swift
//  RickAndMortyApplication
//
//  Created by Yasemin TOK on 30.01.2022.
//

import Foundation
import Alamofire

final class ServiceManager {
    
    public static let shared: ServiceManager = ServiceManager()
}

extension ServiceManager {
    
    func fetch<T>(path: String, parameters: [String : String]?, data: Codable?, method: HTTPMethod, onSuccess: @escaping (T) -> Void, onError: (AFError) -> Void) where T : Decodable, T : Encodable {
        
        AF.request(path, method: method, parameters: parameters, encoding: JSONEncoding.default).validate().responseDecodable(of: T.self) { response in
            print(T.self)
            guard let model = response.value else {
                print(response.error as Any)
                return
            }
            onSuccess(model)
        }
    }
}

