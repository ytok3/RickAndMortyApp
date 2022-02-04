//
//  CharactersCollectionViewFeatures.swift
//  RickAndMortyApplication
//
//  Created by Yasemin TOK on 31.01.2022.
//

import UIKit

protocol CharactersOutput: AnyObject {
    
    func getHeight() -> CGFloat
    func onSelected(characterID: Int)
    func listCharacters(values: [Character])
}

class CharactersCollectionViewFeatures: NSObject {
    
    var characters: [Character] = []
    weak var delegate: CharactersOutput?
}

// MARK: Extension

extension CharactersCollectionViewFeatures: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(characters.count)
        return characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Path.CellIdentifierPath.CELL, for: indexPath) as? CharactersCollectionViewCell else { return UICollectionViewCell() }
        cell.showCharacters(model: characters[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.onSelected(characterID: characters[indexPath.item].id ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let colums: CGFloat = 2
        let collectioViewWith = collectionView.bounds.width
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let spaceBetweenCells = flowLayout.minimumInteritemSpacing * (colums - 1)
        let adjustedWith = collectioViewWith - spaceBetweenCells
        let width: CGFloat = floor(adjustedWith / colums)
        let height = (delegate?.getHeight() ?? 300.0 ) / 4
        return CGSize(width: width, height: height)
    }
}
