//
//  GamesListController.swift
//  POECGameDetails
//
//  Created by Apple on 21/03/2017.
//  Copyright © 2017 M2i. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

class GameListCell : UITableViewCell {
    @IBOutlet weak var imageBoxView: UIImageView!
    @IBOutlet weak var gameTitleLabel: UILabel!
}


class GamesListController : UIViewController {
    
    @IBOutlet weak var gamesTableView: UITableView!
    @IBOutlet weak var gamesLoadingIndicator: UIActivityIndicatorView!
    
    var games : [Game] = [] {
        didSet {
            DispatchQueue.main.async {
                self.gamesTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // self.games = GameDataProvider.listGamesLocally()
        
        let gameService = GameService()
        
        DispatchQueue.main.async {
            self.gamesLoadingIndicator.startAnimating()
            gameService.listTopGames(limit: 100, callback: { successful, games in
                self.gamesLoadingIndicator.stopAnimating()
                if successful {
                    self.games = games
                } else {
                    self.games = []
                }                
            })
        }
        
        self.gamesTableView.delegate = self
        self.gamesTableView.dataSource = self
        self.gamesTableView.tableFooterView = UIView()
        
    }
    
    @IBAction func deleteGamesPressed(_ sender: Any) {
        
        let alertConfirmation = UIAlertController(
            title: "Suppression des jeux",
            message: "Êtes vous certain de vouloir supprimer tous les jeux ?",
            preferredStyle: .actionSheet
        )
        
        alertConfirmation.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))
        alertConfirmation.addAction(UIAlertAction(title: "Supprimer", style: .destructive, handler: { _ in
            GameDataProvider.removeGamesLocally()
            self.games = []
            self.gamesTableView.reloadData()
        }))
        
        self.present(alertConfirmation, animated: true, completion: nil)
    }
    
    @IBAction func gameSortTypeChanged(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            self.games = GameDataProvider.listGamesLocally(sortType: .name)
        }
        if sender.selectedSegmentIndex == 1 {
            self.games = GameDataProvider.listGamesLocally(sortType: .popularity)
        }
        if sender.selectedSegmentIndex == 2 {
            self.games = GameDataProvider.listGamesLocally(sortType: .channels)
        }
        
        self.gamesTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gameDetailsSegue" {
            let gameDetails = segue.destination as? GameDetailsController
            gameDetails?.game = sender as? Game
        }
        
        if segue.identifier == "gameFormSegue" {
            // le formulaire a été ouvert en modale -> attention la destion dans notre cas sera un UINavigationController
            let navCtrl = segue.destination as? UINavigationController
            // Après avoir récupéré le UINavigationController on accéde au premier élément : il s'agit de notre GameFormController
            let gameFormController = navCtrl?.viewControllers.first as? GameFormController
            gameFormController?.delegate = self
        }
    }
    
    @IBAction func unwindToGameList(segue: UIStoryboardSegue) {}
    
}

extension GamesListController : GameFormDelegate {
    
    func didAddGame(_ game: Game) {
        // on ajoute notre jeu locallement
        GameDataProvider.saveGameLocally(game)
        // on recharge la liste des jeux
        self.games = GameDataProvider.listGamesLocally()
    }
    
}

extension GamesListController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //on réucpère notre objet dans le tableau
        let gameForRow = self.games[indexPath.row]
        
        self.performSegue(withIdentifier: "gameDetailsSegue", sender: gameForRow)
    }
    
}



extension GamesListController : UITableViewDataSource {
    
    // Nombre de sections dans notre tableview
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Nombre de lignes par section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.games.count
    }
    
    // Logique de l'affichage de notre cellule
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //on réucpère notre objet dans le tableau
        let gameForRow = self.games[indexPath.row]
        
        // on récupère notre modèle de cellule en s'assurant qu'il n'est pas null
        guard let gameCell = tableView.dequeueReusableCell(withIdentifier: "gameCell") as? GameListCell else {
            return UITableViewCell()
        }
        
        // On fixe les valeur des éléments UI de notre cellule
        gameCell.gameTitleLabel?.text = gameForRow.name
        
        DispatchQueue.main.async {
            if let bannerUrl = URL(string: gameForRow.boxUrl), let imageData = NSData(contentsOf: bannerUrl) {
                gameCell.imageBoxView.image = UIImage(data: imageData as Data)
            } else {
                gameCell.imageBoxView.image = nil
            }
        }
        
        return gameCell
    }  
    
}
