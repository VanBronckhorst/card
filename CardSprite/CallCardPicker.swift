//
//  CallCardPicker.swift
//  CardSprite
//
//  Created by Filippo Pellolio on 23/03/15.
//  Copyright (c) 2015 Filippo Pellolio. All rights reserved.
//

import UIKit
import SpriteKit


class CallCardPicker : SKSpriteNode {
    
    let turn:Turn
    
    init(turn:Turn, rect:CGRect){
        self.turn = turn
        
        super.init(texture: nil, color: UIColor.yellowColor(), size: rect.size)
        self.blendMode = SKBlendMode.Add
        self.position = rect.origin
        self.anchorPoint = CGPointZero
        self.color = UIColor.yellowColor()
        var cs:SKSpriteNode
        if let c=turn.cardCalled {
          cs = CardSprite(card: c, visible: true)
        }else{
          cs = SKSpriteNode()
        }
        
        cs.position = CGPointMake(0, rect.size.height)
        
        addChild(cs)
        
        self.zPosition = 500
        
    }
    
    required init(coder aDecoder: NSCoder) {
        assertionFailure("Not Supported, Stronzo")
    }
}