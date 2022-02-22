//
//  CharacterViewModel.swift
//  RickAndMortyApplication
//
//  Created by Yasemin TOK on 31.01.2022.
//

import Foundation

protocol CharactersViewModelProtocol {
    
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
   
    private var characters: [Character]? = []
    private var service: ServiceProtocol
    private var charactersOutput: CharactersOutput?
    private var characterDetail: CharacterDetail?
    private var characterDetailOutput: CharacterDetailOutput?
    private var searchName: [Character]?
    private var searchStatus: [Character]?
    private var searchOutput: SearchBarOutput?
    private var lastEpisode: LastEpisode?
    private var episodeDetailOutput: EpisodeDetailOutput?

    
    // MARK: Init
    
    init(service: ServiceProtocol) {
        self.service = service
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
        service.getCharacter { [weak self] (response) in
            self?.characters = response ?? []
            self?.charactersOutput?.listCharacters(values: self?.characters ?? [])
        } onError: { error in
            print(error)
        }
    }
    
    func characterDetail(id: Int) {
        service.getCharacterDetail(characterId: id) { [weak self] (response) in
            self?.characterDetail = response
            self?.characterDetailOutput?.listCharacterDetail(model: self?.characterDetail)
            self?.episodeDetail(episode: self?.characterDetail?.episode?.last ?? "")
        } onError: { error in
            print(error)
        }
    }
    
    func searchList(searchResults: String) {
        service.searchCharacterName(searchCharacterName: searchResults) { [weak self] (response) in
            self?.searchName = response
            self?.searchOutput?.listSearchName(values: self?.searchName ?? [])
        } onError: { error in
            self.service.searchCharacterStatus(searchCharacterStatus: searchResults) { [weak self] (response) in
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
        service.getEpisodes(lastSeenEpisodePath: episode) { [weak self] (response) in
            self?.lastEpisode = response
            self?.episodeDetailOutput?.episodeDetail(model: self?.lastEpisode)
        } onError: { error in
            print(error)
        }
    }
}
