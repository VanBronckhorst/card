//
//  Card.swift
//  CardSprite
//
//  Created by Filippo Pellolio on 11/03/15.
//  Copyright (c) 2015 Filippo Pellolio. All rights reserved.
//

import UIKit
import SpriteKit

enum Suit: Int{
    case Clubs = 1, Spades, Hearts, Diamonds
    
    static let allValues = [Clubs , Spades, Hearts, Diamonds]
}

enum CardValue:Int{
    case Ace = 1, Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten, Jack, Queen, King
    
    static let allValues = [Ace , Two, Three, Four, Five, Six, Seven, Jack, Queen, King]
    static let VALUES:Dictionary<CardValue,Int> = [ .Ace: 11 , .Three:10 , .King:4 , .Queen:3 , .Jack:2 , .Two:0 , .Four:0 , .Five:0 , .Six:0 , .Seven:0 ]
}

struct Card {
    let value: CardValue
    let suit: Suit
    
    init(v:CardValue, s:Suit){
        value = v
        suit = s
    }
}

class CardSprite: SKSpriteNode {
    
    let card:Card
    let frontTexture: UIImage
    let backTexture: UIImage
    
    
    required init(coder: NSCoder){
        fatalError("Not Supported")
    }
    
    init(card: Card , visible: Bool){
        self.card = card
        self.frontTexture = card.value == CardValue.Ace ? UIImage(named: "\(card.suit.rawValue)")! : UIImage(named: "\((14 - card.value.rawValue)*4+card.suit.rawValue)")!
        self.backTexture = UIImage(named: "back")!
        super.init(texture: SKTexture(image: visible ? frontTexture :backTexture), color: nil, size: frontTexture.size)
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        let liftAction = SKAction.scaleTo(1.3, duration: 0.3)
        self.runAction(liftAction, withKey: "lift")
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        for touch in touches{
            let loc = touch.locationInNode(parent)
            self.position = loc
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        let liftAction = SKAction.scaleTo(1, duration: 0.3)
        self.runAction(liftAction, withKey: "liftDown")
    }
   
    override func touchesCancelled(touches: NSSet!, withEvent event: UIEvent!) {
        let liftAction = SKAction.scaleTo(1, duration: 0.3)
        self.runAction(liftAction, withKey: "liftDown")
    }
}
