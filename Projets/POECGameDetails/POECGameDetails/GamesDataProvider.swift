//
//  GamesDataProvider.swift
//  POECGameDetails
//
//  Created by Apple on 22/03/2017.
//  Copyright © 2017 M2i. All rights reserved.
//

import Foundation

class GameDataProvider {
    
    static let gamesKey = "games"
    
    // Add game locally
    static func saveGameLocally(_ game : Game) {
        // on récupère notre liste de Games
        var currentGames = self.listGamesLocally()
        // on ajoute notre nouveau Game
        currentGames.append(game)
        // on sauvegarde la nouvelle liste de Game
        self.saveGamesLocally(currentGames)
    }
    
    // Add a game list locally
    static func saveGamesLocally(_ games: [Game]) {
        // on sérialise nos objets Game
        let gamesData = NSKeyedArchiver.archivedData(withRootObject: games)
        // On ajoute les données dans le storage local en l'associant à la clé "games"
        UserDefaults.standard.set(gamesData, forKey: gamesKey)
    }
    
    // Removes all games from local storage
    static func removeGamesLocally() {
        // On supprime les données associées à la clé "games"
        UserDefaults.standard.removeObject(forKey: gamesKey)
    }
    
    // List all games from local storage
    static func listGamesLocally(sortType : GameSortType = .name) -> [Game] {
        // on récupère les données associées à la clé "games"
        if let gamesData = UserDefaults.standard.object(forKey: gamesKey) {
            // on désérialise les données en liste de Game
            if let data = NSKeyedUnarchiver.unarchiveObject(with: gamesData as! Data) {
                
                let games = data as! [Game]
                
                switch sortType {
                case .name:
                    return games.sorted(by: { g1, g2 in g1.name < g2.name })
                case .popularity:
                    return games.sorted(by: { g1, g2 in g1.popularity > g2.popularity })
                case .channels:
                    return games.sorted(by: { $0.channelsNb > $1.channelsNb })
                }
            }
        }
        return []
    }
    
    
    
    
    
    
    static func getFakeData() -> [Game] {
        
        var games : [Game] = []
        
        let game1 = Game(name: "League of Legends", popularity: 85165, channelsNb: 45, viewersNb: 35425)
        game1.boxUrl = "https://static-cdn.jtvnw.net/ttv-boxart/League%20of%20Legends-136x190.jpg"
        game1.bannerUrl = "https://static-cdn.jtvnw.net/ttv-logoart/League%20of%20Legends-240x144.jpg"
        games.append(game1)
        
        let game2 = Game(name: "Heathstone", popularity: 45540, channelsNb: 54, viewersNb: 2540)
        game2.boxUrl = "https://static-cdn.jtvnw.net/ttv-boxart/Hearthstone-136x190.jpg"
        game2.bannerUrl = "https://static-cdn.jtvnw.net/ttv-logoart/Hearthstone-240x144.jpg"
        games.append(game2)
        
        let game3 = Game(name: "DOTA 2", popularity: 45547, channelsNb: 67, viewersNb: 2840)
        game3.boxUrl = "https://static-cdn.jtvnw.net/ttv-boxart/Dota%202-136x190.jpg"
        game3.bannerUrl = "https://static-cdn.jtvnw.net/ttv-logoart/Dota%202-240x144.jpg"
        games.append(game3)
        
        let game4 = Game(name: "Halo 5", popularity: 574, channelsNb: 12, viewersNb: 542)
        game4.bannerUrl = "http://cdn.gamecloud.net.au/wp-content/uploads/2015/11/HALO5_Multiplayer_-Banner.jpg"
        games.append(game4)
        
        for i in 1...50 {
            let tmpGame = Game(name: "My game #\(i)")
            games.append(tmpGame)
        }
        
        return games
    }
    
}
