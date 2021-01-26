//
//  CardController.swift
//  DeckOfOneCard
//
//  Created by Omri Horowitz on 1/26/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import UIKit

class CardController {
    
    static let baseURL = URL(string: "https://deckofcardsapi.com/api/deck/new/draw/?count=1")
    
    static func fetchCard(completion: @escaping (Result <Card, CardError>) -> Void) {
        
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL))}
        
        print(baseURL)
        
        URLSession.shared.dataTask(with: baseURL) { (data, _, error) in
            if let error = error {
                print("======== ERROR ========")
                print("Function: \(#function)")
                print("Error: \(error)")
                print("Description: \(error.localizedDescription)")
                print("======== ERROR ========")
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData)) }

            do {
                let topLevelObject = try JSONDecoder().decode(TopLevelObject.self, from: data)
                let card = topLevelObject.cards[0]
                completion(.success(card))
            } catch {
                    print("======== ERROR ========")
                    print("Function: \(#function)")
                    print("Error: \(error)")
                    print("Description: \(error.localizedDescription)")
                    print("======== ERROR ========")
                return completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    static func fetchImage(for card: Card, completion: @escaping (Result<UIImage, CardError>) -> Void) {
        
        let url = card.image
        URLSession.shared.dataTask(with: url) { (data, _, error) in
                    if let error = error {
                        print("======== ERROR ========")
                        print("Function: \(#function)")
                        print("Error: \(error)")
                        print("Description: \(error.localizedDescription)")
                        print("======== ERROR ========")
                        completion(.failure(.thrownError(error)))
                    }
                    
                    guard let data = data else {return completion(.failure(.noData))}
                    guard let image = UIImage(data: data) else {return completion(.failure(.unableToDecode))}
                    completion(.success(image))
                }.resume()
    }

} /// end class
