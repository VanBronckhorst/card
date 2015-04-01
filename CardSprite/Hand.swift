//
//  Hand.swift
//  CardSprite
//
//  Created by Filippo Pellolio on 17/03/15.
//  Copyright (c) 2015 Filippo Pellolio. All rights reserved.
//

import Foundation

class Hand{
    let owner:Player
    var cards:[Card]
    
    init(p:Player){
        self.owner = p
        self.cards = [Card]()
    }
    
    func takeCard(card:Card)
    {
        self.cards.append(card)
    }
}