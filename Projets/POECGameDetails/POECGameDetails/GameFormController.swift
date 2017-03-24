//
//  GameFormController.swift
//  POECGameDetails
//
//  Created by Apple on 22/03/2017.
//  Copyright © 2017 M2i. All rights reserved.
//

import Foundation
import UIKit

protocol GameFormDelegate {
    func didAddGame(_ game : Game)
}

class GameFormController : UIViewController {
    
    var delegate : GameFormDelegate?
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var popularityField: UITextField!
    @IBOutlet weak var bannerUrlField: UITextField!
    @IBOutlet weak var boxUrlField: UITextField!
    @IBOutlet weak var validateBtn: UIButton!
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.validateBtn.layer.cornerRadius = 5
    }
    
    @IBAction func validateGamePressed(_ sender: Any) {
        
        // on récupère les valeurs des champs
        let name = self.nameField.text!
        let popularity = Int(self.popularityField.text!) ?? 0
        let bannerUrl = self.bannerUrlField.text!
        let boxUrl = self.boxUrlField.text!
        
        // on valide la bonne saisie des données
        guard !name.isEmpty else {
            // on affiche une alert si une erreur est présente dans le nom du jeu
            let alert = UIAlertController(
                title: "Add Game",
                message: "Game name is required",
                preferredStyle: UIAlertControllerStyle.actionSheet
            )
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            // on arrrête l'exécution ici
            return
        }
        
        // on crée une nouvelle instance de Game avec les données saisies
        let newGame = Game(name: name, popularity: popularity)
        newGame.bannerUrl = bannerUrl
        newGame.boxUrl = boxUrl
        
        // on informe notre eventuel delegate que l'on vient de saisie un Game
        self.delegate?.didAddGame(newGame)
        
        // On ferme notre modale en appelant le segue d'exit ...
        self.performSegue(withIdentifier: "closeFormSegue", sender: nil)
        // ... ou on ferme notre ViewController avec dismiss
        // ne fonctionne que si on est en modale
        // self.dismiss(animated: true, completion: nil)
    }
    
}
