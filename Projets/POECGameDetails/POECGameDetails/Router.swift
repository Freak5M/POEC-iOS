//
//  Router.swift
//  POECGameDetails
//
//  Created by Apple on 23/03/2017.
//  Copyright © 2017 M2i. All rights reserved.
//

import Foundation


class Router {
    
    static private let apiScheme = "https"
    static private let apiHost = "api.twitch.tv"
    static private let apiClientKey = "6hm2yim0mbt2vzsk6ss7fzgsjv6e94"
    
    static func addGame() -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = self.apiScheme
        urlComponents.host = self.apiHost
        urlComponents.path = "/games/add"
        return urlComponents
    }
    
    static func getlistTopGames(limit : Int) -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = self.apiScheme
        urlComponents.host = self.apiHost
        urlComponents.path = "/kraken/games/top"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: self.apiClientKey),
            URLQueryItem(name: "limit", value: "\(limit)")
        ]
        return urlComponents
    }
    
}
