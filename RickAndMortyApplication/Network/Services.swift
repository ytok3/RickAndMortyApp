//
//  Services.swift
//  RickAndMortyApplication
//
//  Created by Yasemin TOK on 30.01.2022.
//

import Foundation
import Alamofire

protocol ServiceProtocol {
    
    func getCharacter(onSucces: @escaping ([Character]?) -> Void, onError: @escaping (AFError) -> Void)
    func searchCharacterName(searchCharacterName: String, onSuccess: @escaping ([Character]?) -> Void, onError: @escaping (AFError) -> Void)
    func searchCharacterStatus(searchCharacterStatus: String, onSuccess: @escaping ([Character]?) -> Void, onError: @escaping (AFError) -> Void)
    func getCharacterDetail(characterId: Int, onSucces: @escaping (CharacterDetail?) -> Void, onError: @escaping (AFError) -> Void)
    func getEpisodes(lastSeenEpisodePath: String, onSucces: @escaping (LastEpisode?) -> Void, onError: @escaping (AFError) -> Void)
}

final class Services: ServiceProtocol {

    func getCharacter(onSucces: @escaping ([Character]?) -> Void, onError: @escaping (AFError) -> Void) {
        ServiceManager.shared.fetch(path: Path.NetworkPath.BASE_URL + Path.FirebasePath.CHARACTERS, parameters: nil, data: nil, method: HTTPMethod.get) { (response: CharacterList) in
            onSucces(response.results)
        } onError: { error in
            onError(error)
        }
    }
    
    func searchCharacterName(searchCharacterName: String, onSuccess: @escaping ([Character]?) -> Void, onError: @escaping (AFError) -> Void) {
        ServiceManager.shared.fetch(path: Path.NetworkPath.BASE_URL + Path.FirebasePath.CHARACTERS + Path.FirebasePath.NAME + "\(searchCharacterName)", parameters: nil, data: nil, method: HTTPMethod.get) { (response: CharacterList) in
            onSuccess(response.results)
            print(response)
        } onError: { error in
            onError(error)
            print(error)
        }
    }
    
    func searchCharacterStatus(searchCharacterStatus: String, onSuccess: @escaping ([Character]?) -> Void, onError: @escaping (AFError) -> Void) {
        ServiceManager.shared.fetch(path: Path.NetworkPath.BASE_URL + Path.FirebasePath.CHARACTERS + Path.FirebasePath.STATUS + "\(searchCharacterStatus)", parameters: nil, data: nil, method: HTTPMethod.get) { (response: CharacterList) in
            onSuccess(response.results)
            print(response)
        } onError: { error in
            onError(error)
            print(error)
        }
    }
    
    func getCharacterDetail(characterId: Int, onSucces: @escaping (CharacterDetail?) -> Void, onError: @escaping (AFError) -> Void) {
        ServiceManager.shared.fetch(path: Path.NetworkPath.BASE_URL + Path.FirebasePath.CHARACTERS + "/\(characterId)", parameters: nil, data: nil, method: HTTPMethod.get) { (response: CharacterDetail) in
            onSucces(response)
        } onError: { error in
            onError(error)
        }
    }
    
    func getEpisodes(lastSeenEpisodePath: String, onSucces: @escaping (LastEpisode?) -> Void, onError: @escaping (AFError) -> Void) {
        ServiceManager.shared.fetch(path: lastSeenEpisodePath, parameters: nil, data: nil, method: HTTPMethod.get) { (response: LastEpisode) in
            onSucces(response)
            print(response)
        } onError: { error in
            onError(error)
        }
    }
}
