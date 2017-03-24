//
//  GameService.swift
//  POECGameDetails
//
//  Created by Apple on 22/03/2017.
//  Copyright © 2017 M2i. All rights reserved.
//

import Foundation

class GameService {
    
    var session : URLSession = URLSession.shared
    
    func addGame(game: Game, callback : @escaping (_ successful : Bool) -> Void) {
        
        let urlComponents = Router.addGame()
        guard let urlAddGame = urlComponents.url else {
            return
        }
        
        var request = URLRequest(url: urlAddGame)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: ["name" : game.name], options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        self.session.dataTask(with: request, completionHandler: { data, request, error in
            
            // ......
            
            callback(error != nil)
            
        })
    }
    
    
    func listTopGames(limit: Int, callback : @escaping (_ successful : Bool, _ games : [Game]) -> Void) {
        
        let urlComponents = Router.getlistTopGames(limit: limit)
        
        // self.urlComponents.url
        // ---> https://api.twitch.tv/kraken/games/top?client_id=6hm2yim0mbt2vzsk6ss7fzgsjv6e94&limit=10
        
        // on vérifie que notre url est bien formée
        guard let urlTopGames = urlComponents.url else {
            return
        }
        
        var request = URLRequest(url: urlTopGames)
        request.httpMethod = "GET" // pas obligatoire en GET
        
        // on exécute la requête sur l'API
        self.session.dataTask(with: request, completionHandler: { data, request, error in
            
            // on vérifie que la requête s'est bien bassée
            guard let d = data else {
                print("Error : listTopGames request failed")
                callback(false, [])
                return
            }
            
            // si on arrive à parser la réponse serveur (string) en Dictionnaire swift
            // [String : Any] <===> HashMap<String, Object>
            if let json = try? JSONSerialization.jsonObject(with: d, options: []) as? [String : Any] {
                
                // si la clé "top" existe dans notre dictionnaire ...
                // ... on la récupère en liste de dictionnaire
                guard let topGames = json?["top"] as? [ [String: Any] ] else {
                    print("Error : listTopGames unable to find and cast top key")
                    callback(false, [])
                    return
                }                
                
                var games : [Game] = []
                // on parcours la liste des jeux
                for top in topGames {
                    let newGame = Game(json : top)
                    games.append(newGame)
                }
                // on retourne les jeux parsés
                callback(true, games)

            } else {
                print("Error : listTopGames data to json dictionnary failed")
                callback(false, [])
                return
            }
            
        }).resume()
    }
}
