//
//  Player.swift
//  CardSprite
//
//  Created by Filippo Pellolio on 17/03/15.
//  Copyright (c) 2015 Filippo Pellolio. All rights reserved.
//

import Foundation


class Player : Hashable{
    let name : String
    var cards:[Card] = [Card]()
    var hashValue : Int{
        return name.hashValue
    }
    
    init (name:String)
    {
        self.name = name
        
    }
    
    func takeCard(card:Card)
    {
        self.cards.append(card)
    }
    
}

func ==(lhs: Player, rhs: Player) -> Bool{
    return lhs.hashValue==rhs.hashValue
}