//
//  Card.swift
//  DeckOfOneCard
//
//  Created by Omri Horowitz on 1/26/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import Foundation

struct Card: Decodable {
    let value: String
    let suit: String
    let image: URL
}

struct TopLevelObject: Decodable {
    let cards: [Card]
}
