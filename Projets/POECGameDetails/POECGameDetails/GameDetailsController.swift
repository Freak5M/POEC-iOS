//
//  GameDetailsController.swift
//  POECGameDetails
//
//  Created by Apple on 20/03/2017.
//  Copyright © 2017 M2i. All rights reserved.
//

import Foundation
import UIKit

class GameDetailsController: UIViewController {

    var game : Game?
    
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var imageLoaderView: UIActivityIndicatorView!
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var nbViewersLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var nbChannelsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // on vérifie si game a été fixée par un précédent controller
        guard let myGame = game else {
            // sinon on arrète l'exécution
            return
        }
        
        self.gameNameLabel.text = myGame.name
        self.nbViewersLabel.text = "\(myGame.viewersNb)"
        self.popularityLabel.text = "\(myGame.popularity)"
        self.nbChannelsLabel.text = "\(myGame.channelsNb)"
        
        self.imageLoaderView.hidesWhenStopped = true
        
        self.imageLoaderView.startAnimating()
        DispatchQueue.main.async {
            if let bannerUrl = URL(string: myGame.bannerUrl), let imageData = NSData(contentsOf: bannerUrl) {
                self.bannerImage.image = UIImage(data: imageData as Data)
            } else {
                self.bannerImage.image = UIImage(named: "twitch-banner")
            }
            self.imageLoaderView.stopAnimating()
        }
    }

    @IBAction func incChannel(_ sender: Any) {
        self.game?.channelsNb += 1
        self.nbChannelsLabel.text = "\(game?.channelsNb ?? 0)"
    }
}

