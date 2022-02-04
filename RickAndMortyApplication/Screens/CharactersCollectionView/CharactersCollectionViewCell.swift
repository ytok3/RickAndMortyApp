//
//  CharactersCollectionViewCell.swift
//  RickAndMortyApplication
//
//  Created by Yasemin TOK on 31.01.2022.
//

import UIKit
import AlamofireImage

class CharactersCollectionViewCell: UICollectionViewCell {
    
    // MARK: View
    
    private let characterImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .white
        return iv
    }()
    
    private let verticalStack: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.distribution = .fillEqually
        sv.axis = .vertical
        return sv
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textColor = .black
        label.backgroundColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textColor = .black
        label.backgroundColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let speciesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textColor = .black
        label.backgroundColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
            
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: LifeCycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let margins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        contentView.frame = contentView.frame.inset(by: margins)
        contentView.layer.cornerRadius = 5
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.black.cgColor
        
        configureCells()
    }
    
    // MARK: Func
    
    func configureCells() {
        
        contentView.addSubview(characterImage)
        contentView.addSubview(verticalStack)
        verticalStack.addArrangedSubview(nameLabel)
        verticalStack.addArrangedSubview(statusLabel)
        verticalStack.addArrangedSubview(speciesLabel)
        
        characterImage.layer.cornerRadius = 5
        configureCellsConstraint()
    }
    
    func configureCellsConstraint() {
        
        let padding: CGFloat = 5
        
        NSLayoutConstraint.activate([
            
            characterImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            characterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            characterImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            characterImage.heightAnchor.constraint(equalToConstant: contentView.frame.height / 1.75),
            characterImage.widthAnchor.constraint(equalToConstant: contentView.frame.width / 2),
            
            verticalStack.topAnchor.constraint(equalTo: characterImage.bottomAnchor, constant: padding),
            verticalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            verticalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            verticalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            verticalStack.widthAnchor.constraint(equalToConstant: contentView.frame.width - padding * 2),
            
            nameLabel.topAnchor.constraint(equalTo: verticalStack.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: verticalStack.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: verticalStack.trailingAnchor),
        
            statusLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            statusLabel.leadingAnchor.constraint(equalTo: verticalStack.leadingAnchor),
            statusLabel.trailingAnchor.constraint(equalTo: verticalStack.trailingAnchor),
            
            speciesLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor),
            speciesLabel.leadingAnchor.constraint(equalTo: verticalStack.leadingAnchor),
            speciesLabel.trailingAnchor.constraint(equalTo: verticalStack.trailingAnchor),
            speciesLabel.bottomAnchor.constraint(equalTo: verticalStack.bottomAnchor, constant: -padding)
        ])
    }
    
    func showCharacters(model: Character) {
        
        nameLabel.text = model.name
        statusLabel.text = model.status
        speciesLabel.text = model.species
        characterImage.af.setImage(withURL: URL(string: (model.image!))!)
    }
}
