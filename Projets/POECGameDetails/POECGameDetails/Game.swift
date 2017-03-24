//
//  Game.swift
//  POECGameDetails
//
//  Created by Apple on 20/03/2017.
//  Copyright © 2017 M2i. All rights reserved.
//

import Foundation


class Game : NSObject, NSCoding {
    
    var id : String = UUID().uuidString
    
    var name = ""
    var popularity = 0
    var channelsNb = 0
    var viewersNb = 0
    var boxUrl = ""
    var bannerUrl = ""
    
    // constructeur vide
    override init() {}
    
    // constructeur d'attributs
    init(name: String, popularity : Int = 0, channelsNb : Int = 0, viewersNb : Int = 0) {
        self.name = name
        self.popularity = popularity
        self.channelsNb = channelsNb
        self.viewersNb = viewersNb        
    }
    
    // constructeur depuis json dictionnary
    init(json : [String : Any]) {

        self.viewersNb = json["viewers"] as! Int // top[i].viewers
        self.channelsNb = json["channels"] as! Int // top[i].channels
        
        if let gameJson = json["game"] as? [String: Any] {
            
            // top[i].game
            self.name = gameJson["name"] as! String // top[i].game.name
            self.popularity = gameJson["popularity"] as! Int // top[i].game.popularity
            
            if let boxImage = gameJson["box"] as? [String: Any] {
                // top[i].game.box
                self.boxUrl = boxImage["medium"] as! String // top[i].game.box.medium
            }
            
            if let bannerImage = gameJson["logo"] as? [String: Any] {
                // top[i].game.logo
                self.bannerUrl = bannerImage["large"] as! String // top[i].game.logo.large
            }
        }
    }
    
    // constructeur depuis memoire interne -> decodage
    required init?(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeObject(forKey: "id") as! String
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.popularity = aDecoder.decodeInteger(forKey: "popularity")
        self.channelsNb = aDecoder.decodeInteger(forKey: "channelsNb")
        self.viewersNb = aDecoder.decodeInteger(forKey: "viewersNb")
        self.boxUrl = aDecoder.decodeObject(forKey: "boxUrl") as! String
        self.bannerUrl = aDecoder.decodeObject(forKey: "bannerUrl") as! String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.id, forKey: "id")
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.popularity, forKey: "popularity")
        aCoder.encode(self.channelsNb, forKey: "channelsNb")
        aCoder.encode(self.viewersNb, forKey: "viewersNb")
        aCoder.encode(self.boxUrl, forKey: "boxUrl")
        aCoder.encode(self.bannerUrl, forKey: "bannerUrl")
    }
}
