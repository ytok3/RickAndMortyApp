//
//  CharacterViewModel.swift
//  RickAndMortyApplication
//
//  Created by Yasemin TOK on 31.01.2022.
//

import Foundation

protocol CharactersViewModelProtocol {
    
    var characters: [Character]? {get set}
    var services: ServiceProtocol {get}
    var charactersOutput: CharactersOutput? {get}
    var characterDetail: CharacterDetail? {get set}
    var characterDetailOutput: CharacterDetailOutput? {get}
    var searchName: [Character]? {get set}
    var searchStatus: [Character]? {get set}
    var searchOutput : SearchBarOutput? {get}
    var lastEpisode: LastEpisode? {get set}
    var episodeDetailOutput: EpisodeDetailOutput? {get}
    
    func setDelegateCharacters(output: CharactersOutput)
    func allCharacters()
    func setDelegateCharacterDetail(output: CharacterDetailOutput)
    func characterDetail(id: Int)
    func setDelegateSearch(output: SearchBarOutput)
    func searchList(searchResults: String)
    func setDelegateLastEpisode(output: EpisodeDetailOutput)
    func episodeDetail(episode: String)
}

final class CharactersViewModel: CharactersViewModelProtocol {
   
    // MARK: Properties
   
    var characters: [Character]? = []
    var services: ServiceProtocol
    var charactersOutput: CharactersOutput?
    var characterDetail: CharacterDetail?
    var characterDetailOutput: CharacterDetailOutput?
    var searchName: [Character]?
    var searchStatus: [Character]?
    var searchOutput: SearchBarOutput?
    var lastEpisode: LastEpisode?
    var episodeDetailOutput: EpisodeDetailOutput?
    
    // MARK: Init
    
    init() {
        services = Services()
    }
    
    // MARK: Func
    
    func setDelegateCharacters(output: CharactersOutput) {
        charactersOutput = output
    }
    
    func setDelegateCharacterDetail(output: CharacterDetailOutput) {
        characterDetailOutput = output
    }
    
    func setDelegateSearch(output: SearchBarOutput) {
        searchOutput = output
    }
    
    func setDelegateLastEpisode(output: EpisodeDetailOutput) {
        episodeDetailOutput = output
    }
    
    func allCharacters() {
        services.getCharacter { [weak self] (response) in
            self?.characters = response ?? []
            self?.charactersOutput?.listCharacters(values: self?.characters ?? [])
        } onError: { error in
            print(error)
        }
    }
    
    func characterDetail(id: Int) {
        services.getCharacterDetail(characterId: id) { [weak self] (response) in
            self?.characterDetail = response
            self?.characterDetailOutput?.listCharacterDetail(model: self?.characterDetail)
            self?.characterDetailOutput?.lastEpisode(value: self?.characterDetail?.episode?.last ?? "")
        } onError: { error in
            print(error)
        }
    }
    
    func searchList(searchResults: String) {
        services.searchCharacterName(searchCharacterName: searchResults) { [weak self] (response) in
            self?.searchName = response
            self?.searchOutput?.listSearchName(values: self?.searchName ?? [])
        } onError: { error in
            self.services.searchCharacterStatus(searchCharacterStatus: searchResults) { [weak self] (response) in
                self?.searchStatus = response
                self?.searchOutput?.listSearchStatus(values: self?.searchStatus ?? [])
            } onError: { error in
                self.searchOutput?.listSearchStatus(values: [])
                print(error)
            }
            print(error)
        }
    }
    
    func episodeDetail(episode: String) {
        services.getEpisodes(lastSeenEpisodePath: episode) { [weak self] (response) in
            self?.lastEpisode = response
            self?.episodeDetailOutput?.episodeDetail(model: self?.lastEpisode)
        } onError: { error in
            print(error)
        }
    }
}
