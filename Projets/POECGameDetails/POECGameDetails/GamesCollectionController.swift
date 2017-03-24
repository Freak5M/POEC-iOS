//
//  GamesCollectionController.swift
//  POECGameDetails
//
//  Created by Apple on 23/03/2017.
//  Copyright © 2017 M2i. All rights reserved.
//

import Foundation
import UIKit

class GameCollectionCell : UICollectionViewCell {
    @IBOutlet weak var gameImage: UIImageView!
}

class GamesCollectionController : UIViewController {
    
    let cellGap : CGFloat = 1.0
    let cellPerLine : CGFloat = 3.0
    let imageRatio : CGFloat = 190.0 / 136.0
    
    var games : [Game] = [] {
        didSet {
            DispatchQueue.main.async {
                self.gamesCollection.reloadData()
            }
        }
    }
    
    @IBOutlet weak var gamesCollection: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gameService = GameService()
        self.activityIndicator.startAnimating()
        gameService.listTopGames(limit: 50, callback: { successful, games in
            self.activityIndicator.stopAnimating()
            if successful {
                self.games = games
            } else {
                self.games = []
            }
        })
        
        self.gamesCollection.dataSource = self
        self.gamesCollection.delegate = self        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gameDetailsSegue" {
            let gameDetails = segue.destination as? GameDetailsController
            gameDetails?.game = sender as? Game
        }
    }
}

extension GamesCollectionController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gameCell", for: indexPath) as? GameCollectionCell
        let gameForRow = self.games[indexPath.row]
        
        DispatchQueue.main.async {
            if let bannerUrl = URL(string: gameForRow.boxUrl), let imageData = NSData(contentsOf: bannerUrl) {
                cell?.gameImage.image = UIImage(data: imageData as Data)
            } else {
                cell?.gameImage.image = nil
            }
        }
        
        return cell!
    }
}


extension GamesCollectionController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let gameForRow = self.games[indexPath.row]
        self.performSegue(withIdentifier: "gameDetailsSegue", sender: gameForRow)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.cellGap
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return self.cellGap
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let colViewWidth = collectionView.frame.width - (cellPerLine - 1) * cellGap
        
        let imageWidth = colViewWidth / self.cellPerLine
        
        return CGSize(width: imageWidth, height: imageWidth * imageRatio)
    }
}



