//
//  CardViewController.swift
//  DeckOfOneCard
//
//  Created by Omri Horowitz on 1/26/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var cardValueSuitLabel: UILabel!
    @IBOutlet weak var cardImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //MARK: - Actions
    @IBAction func drawButtonTapped(_ sender: Any) {
        CardController.fetchCard { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let card):
                    self.fetchImageAndUpdateViews(for: card)
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
            
    // MARK: - Helper Functions
    func fetchImageAndUpdateViews(for card: Card) {
        CardController.fetchImage(for: card) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self.cardValueSuitLabel.text = "\(card.value) of \(card.suit)"
                    self.cardImageView.image = image
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
}
    
    

