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
    var search: [Character]? {get set}
    var searchOutput : SearchBarOutput? {get}
    
    func setDelegateCharacters(output: CharactersOutput)
    func allCharacters()
    func setDelegateCharacterDetail(output: CharacterDetailOutput)
    func characterDetail(id: Int)
    func setDelegateSearch(output: SearchBarOutput)
    func searchList(name: String, status: String)
}

final class CharactersViewModel: CharactersViewModelProtocol {
    
    // MARK: Properties
   
    var characters: [Character]? = []
    var services: ServiceProtocol
    var charactersOutput: CharactersOutput?
    var characterDetail: CharacterDetail?
    var characterDetailOutput: CharacterDetailOutput?
    var search: [Character]?
    var searchOutput: SearchBarOutput?
    
    // MARK: Init
    
    init() {
        services = Services()
    }
    
    func setDelegateCharacters(output: CharactersOutput) {
        charactersOutput = output
    }
    
    func setDelegateCharacterDetail(output: CharacterDetailOutput) {
        characterDetailOutput = output
    }
    
    func setDelegateSearch(output: SearchBarOutput) {
        searchOutput = output
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
        } onError: { error in
            print(error)
        }
    }
    
    func searchList(name: String, status: String) {
        services.searchCharacter(characterName: name, characterStatus: status) { [weak self] (response) in
            self?.search = response
            self?.searchOutput?.listSearch(values: self?.search ?? [])
        } onError: { error in
            print(error)
        }
    }
}
