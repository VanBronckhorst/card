//
//  Deck.swift
//  CardSprite
//
//  Created by Filippo Pellolio on 17/03/15.
//  Copyright (c) 2015 Filippo Pellolio. All rights reserved.
//

import UIKit
import SpriteKit

class Deck{
    var cards:[Card]
    
    init(){
        cards = [Card]()
        for suit in Suit.allValues{
            for val in CardValue.allValues{
                cards.append(Card(v: val,s: suit))
            }
        }
        shuffle()
    }
    
    func shuffle(){
        var i:Int = 0
        for _ in 1...100{
            let swap = Int(arc4random_uniform(UInt32(cards.count)))
            let el = cards.removeAtIndex(swap)
            cards.append(el)
        }
    }
    
    func draw()->Card?{
        if cards.count > 0 {
            return cards.removeAtIndex(0)
        }
        return nil
    }
    
    func isEmpty()-> Bool{
        return cards.count == 0
    }
}

class DeckSprite: SKSpriteNode {
    let deck:Deck
    var lastZ:CGFloat = 0
    
    required init(coder aDecoder: NSCoder) {
        assertionFailure("Not Supported")
    }
    
    override init() {
        deck = Deck()
        super.init(texture: SKTexture(imageNamed: "Spaceship"), color: nil, size: CardSprite(card: deck.cards.first!, visible : true).size)
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        if (!deck.isEmpty()){
        
            let card = CardSprite(card:deck.draw()! , visible: true)
            card.position.y = self.position.y
            card.position.x = self.position.x + self.size.width + 5
            card.userInteractionEnabled = true
            card.zPosition = lastZ
            lastZ++
            scene?.addChild(card)
        
            
        }
        
    }
}
