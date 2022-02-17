//
//  CharacterDetailViewController.swift
//  RickAndMortyApplication
//
//  Created by Yasemin TOK on 31.01.2022.
//

import UIKit
import AlamofireImage

protocol CharacterDetailOutput {
    func listCharacterDetail(model: CharacterDetail?)
    func lastEpisode(value: String)
    
}
protocol EpisodeDetailOutput {
    func episodeDetail(model: LastEpisode?)
}

class CharacterDetailViewController: UIViewController {
    
    var lastSeenEpisode: String?
    private let charactersViewModel: CharactersViewModelProtocol = CharactersViewModel(service: Services())
    
    // MARK: View
    
    private let scrollView: UIScrollView = {
            let scrollView = UIScrollView()
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.isScrollEnabled = true
            return scrollView
        }()
        
        private let characterImage: UIImageView = {
            let image = UIImageView()
            image.translatesAutoresizingMaskIntoConstraints = false
            image.contentMode = .scaleToFill
            image.clipsToBounds = true
            image.backgroundColor = .white
            return image
        }()
        
        private var nameLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.clipsToBounds = true
            label.textColor = .black
            label.font = UIFont.boldSystemFont(ofSize: 22)
            label.numberOfLines = 0
            label.backgroundColor = .white
            return label
        }()
        
        private var statusLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.clipsToBounds = true
            label.textColor = .black
            label.font = UIFont.boldSystemFont(ofSize: 16)
            label.numberOfLines = 0
            label.backgroundColor = .white
            return label
        }()
        
        private var speciesLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.clipsToBounds = true
            label.textColor = .black
            label.font = UIFont.boldSystemFont(ofSize: 16)
            label.numberOfLines = 0
            label.backgroundColor = .white
            return label
        }()
        
        private var numberOfEpisodesLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.clipsToBounds = true
            label.textColor = .black
            label.font = UIFont.boldSystemFont(ofSize: 16)
            label.numberOfLines = 0
            label.backgroundColor = .white
            return label
        }()
        
        private var genderLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.clipsToBounds = true
            label.textColor = .black
            label.font = UIFont.boldSystemFont(ofSize: 16)
            label.numberOfLines = 0
            label.backgroundColor = .white
            return label
        }()
        
        private var originLocationNameLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.clipsToBounds = true
            label.textColor = .black
            label.font = UIFont.boldSystemFont(ofSize: 16)
            label.numberOfLines = 0
            label.backgroundColor = .white
            return label
        }()
        
        private var lastKnownLocationNameLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.clipsToBounds = true
            label.textColor = .black
            label.font = UIFont.boldSystemFont(ofSize: 16)
            label.numberOfLines = 0
            label.backgroundColor = .white
            return label
        }()
        
        private var lastSeenEpisodeNameLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.clipsToBounds = true
            label.textColor = .black
            label.font = UIFont.boldSystemFont(ofSize: 16)
            label.numberOfLines = 0
            label.backgroundColor = .white
            return label
        }()

    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setUpView()
    }
    
    // MARK: Func
    
    func setUpView() {
        
        self.navigationController?.isNavigationBarHidden = false
                
            view.backgroundColor = .white
                
            view.addSubview(scrollView)
            scrollView.addSubview(characterImage)
            scrollView.addSubview(nameLabel)
            scrollView.addSubview(statusLabel)
            scrollView.addSubview(speciesLabel)
            scrollView.addSubview(numberOfEpisodesLabel)
            scrollView.addSubview(genderLabel)
            scrollView.addSubview(originLocationNameLabel)
            scrollView.addSubview(lastKnownLocationNameLabel)
            scrollView.addSubview(lastSeenEpisodeNameLabel)
        
        characterImage.layer.cornerRadius = 4
        
        setUpConstraint()
    }
    
    func setUpConstraint() {
        
        let padding: CGFloat = 4
                
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                        
            characterImage.topAnchor.constraint(equalTo: scrollView.topAnchor,  constant: padding),
            characterImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            characterImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            characterImage.heightAnchor.constraint(equalToConstant: view.frame.height/2),
                        
            nameLabel.topAnchor.constraint(equalTo: characterImage.bottomAnchor, constant: padding * 2),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding * 2),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding * 2),
                        
            statusLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: padding * 2),
            statusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding * 2),
            statusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding * 2),
                        
            speciesLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: padding * 2),
            speciesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding * 2),
            speciesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding * 2),
                        
            numberOfEpisodesLabel.topAnchor.constraint(equalTo: speciesLabel.bottomAnchor, constant: padding * 2),
            numberOfEpisodesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding * 2),
            numberOfEpisodesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding * 2),
                        
            genderLabel.topAnchor.constraint(equalTo: numberOfEpisodesLabel.bottomAnchor, constant: padding * 2),
            genderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding * 2),
            genderLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding * 2),
                        
            originLocationNameLabel.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: padding * 2),
            originLocationNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding * 2),
            originLocationNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding * 2),
                        
            lastKnownLocationNameLabel.topAnchor.constraint(equalTo: originLocationNameLabel.bottomAnchor, constant: padding * 2),
            lastKnownLocationNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding * 2),
            lastKnownLocationNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding * 2),
                        
            lastSeenEpisodeNameLabel.topAnchor.constraint(equalTo: lastKnownLocationNameLabel.bottomAnchor, constant: padding * 2),
            lastSeenEpisodeNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding * 2),
            lastSeenEpisodeNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding * 2),
            lastSeenEpisodeNameLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -padding * 2)
        ])
    }
}

// MARK: Extension

extension CharacterDetailViewController: CharacterDetailOutput {
   
    func listCharacterDetail(model: CharacterDetail?) {
        
        nameLabel.text = (model?.name)!
        statusLabel.text = Path.CharacterDetailPath.STATUS + (model?.status)!
        speciesLabel.text = Path.CharacterDetailPath.SPECIES + (model?.species)!
        numberOfEpisodesLabel.text = Path.CharacterDetailPath.EPISODES + "\(model?.episode?.count ?? 0)"
        genderLabel.text = Path.CharacterDetailPath.GENDER + (model?.gender)!
        originLocationNameLabel.text = Path.CharacterDetailPath.ORIGIN_LOCATION + (model?.origin?.name)!
        lastKnownLocationNameLabel.text = Path.CharacterDetailPath.KNOWN_LOCATION + (model?.location?.name)!
        characterImage.af.setImage(withURL: URL(string: (model?.image)!)!)
    }
    
    func lastEpisode(value: String) {
        lastSeenEpisode = value
        print(lastSeenEpisode ?? "" )
        charactersViewModel.setDelegateLastEpisode(output: self)
        charactersViewModel.episodeDetail(episode: lastSeenEpisode ?? "")
    }
}

extension CharacterDetailViewController: EpisodeDetailOutput {
    
    func episodeDetail(model: LastEpisode?) {
        lastSeenEpisodeNameLabel.text = Path.CharacterDetailPath.LAST_EPISODES + "\n"
            + Path.CharacterDetailPath.LAST_EPISODES_NAME + ((model?.name)!) + "\n"
            + Path.CharacterDetailPath.LAST_EPISODES_AIR_DATE + ((model?.airDate ?? ""))
    }
}
