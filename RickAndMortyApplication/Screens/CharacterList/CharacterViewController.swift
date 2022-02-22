//
//  CharacterViewController.swift
//  RickAndMortyApplication
//
//  Created by Yasemin TOK on 30.01.2022.
//

import UIKit

protocol SearchBarOutput {
    
    func listSearchName(values: [Character])
    func listSearchStatus(values: [Character])
    func searchTextingName(searchTextName: String)
    func searchTextingStatus(searchTextStatus: String)
}

class CharacterViewController: UIViewController {
    
    // MARK: Properties
    
    private let charactersViewModel: CharactersViewModelProtocol = CharactersViewModel(service: Services())
    private let charactersCollectionViewFeatures: CharactersCollectionViewFeatures = CharactersCollectionViewFeatures()
    private let characterDetailVC: CharacterDetailViewController = CharacterDetailViewController()
    private var reloadCharacters: [Character] = []
    
    // MARK: View
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = Path.PropertiesPath.SEARCH
        searchBar.sizeToFit()
        return searchBar
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.register(CharactersCollectionViewCell.self, forCellWithReuseIdentifier: Path.CellIdentifierPath.CELL)
        return collectionView
    }()
    
    private let noResultsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.text = Path.PropertiesPath.NO_RESULTS
        return label
    }()
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(
            title: Path.PropertiesPath.CANCEL_FILTER,
            style: .plain,
            target: self,
            action: #selector(clearFilter)
        )
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        
        charactersCollectionViewFeatures.delegate = self
        searchBar.delegate = self
        
        setUpDelegate()
        setUpView()
    }
    
    // MARK: Func
    
    func setUpDelegate() {
        
        collectionView.delegate = charactersCollectionViewFeatures
        collectionView.dataSource = charactersCollectionViewFeatures
        
        charactersViewModel.setDelegateCharacters(output: self)
        charactersViewModel.allCharacters()
    }
    
    func setUpView() {
        
        noResultsLabel.isHidden = true
        
        view.backgroundColor = .white
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        view.addSubview(noResultsLabel)
        
        setUpConstraint()
    }
    
    private func setUpConstraint() {
        
        let padding: CGFloat = 4
        
        NSLayoutConstraint.activate([
        
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: padding),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            
            noResultsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noResultsLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    
        ])
    }
    
    @objc func clearFilter() {
        
        self.charactersCollectionViewFeatures.characters.removeAll()
        collectionView.reloadData()
        if charactersCollectionViewFeatures.characters.isEmpty == true {
            
            self.listCharacters(values: reloadCharacters)
            collectionView.reloadData()
            navigationItem.rightBarButtonItem?.isEnabled = false
            noResultsLabel.isHidden = true
        }
    }
}

// MARK: Extension

extension CharacterViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        navigationItem.rightBarButtonItem?.isEnabled = true
        
        searchBar.endEditing(true)

        searchTextingName(searchTextName: searchBar.text!)
        searchTextingStatus(searchTextStatus: searchBar.text!)
        
        searchBar.text = nil
    }
}

extension CharacterViewController: CharactersOutput {
  
    func getHeight() -> CGFloat {
        return view.bounds.height
    }
    
    func onSelected(characterID: Int) {
        charactersViewModel.characterDetail(id: characterID)
        charactersViewModel.setDelegateCharacterDetail(output: characterDetailVC)
        charactersViewModel.setDelegateLastEpisode(output: characterDetailVC)
        self.navigationController?.pushViewController(characterDetailVC, animated: true)
    }
    
     func listCharacters(values: [Character]) {
         charactersCollectionViewFeatures.characters = values
         reloadCharacters = values
         collectionView.reloadData()
     }
}

extension CharacterViewController: SearchBarOutput {
    
    func searchTextingName(searchTextName: String) {
        charactersViewModel.searchList(searchResults: searchTextName)
        charactersViewModel.setDelegateSearch(output: self)
        collectionView.reloadData()
    }
    
    func searchTextingStatus(searchTextStatus: String) {
        charactersViewModel.searchList(searchResults: searchTextStatus)
        charactersViewModel.setDelegateSearch(output: self)
        collectionView.reloadData()
    }
    
    func listSearchName(values: [Character]) {
        charactersCollectionViewFeatures.characters = values
        collectionView.reloadData()
        noResultsLabel.isHidden = true
    }
    
    func listSearchStatus(values: [Character]) {
        charactersCollectionViewFeatures.characters = values
        collectionView.reloadData()
        noResultsLabel.isHidden = true
    }
}
