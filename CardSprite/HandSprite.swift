//
//  HandSprite.swift
//  CardSprite
//
//  Created by Filippo Pellolio on 17/03/15.
//  Copyright (c) 2015 Filippo Pellolio. All rights reserved.
//

import UIKit
import SpriteKit

class HandSprite: SKSpriteNode {
    let handz:CGFloat = 10
    let selz:CGFloat = 20
    let player:Player
    var selected:CardSprite?
    
    
    required init?(coder aDecoder: NSCoder) {
        assertionFailure("Not Supported")
    }
    
    init(player:Player, size: CGSize , visible: Bool) {
        self.player = player
        
        var realsize = size
        
        if (!visible & (size.height > size.width)){
            let h = size.height
            
            realsize.height = realsize.width
            realsize.width = h
        }
        
        
        super.init(texture: nil, color: nil, size: realsize)
        
        self.userInteractionEnabled = visible
        zPosition = handz
        
        
        
        let dx = (realsize.width ) / CGFloat(player.cards.count)
        
        var x = dx / 2
        
        for c in player.cards {
            let csprite = CardSprite(card: c,visible : visible)
            self.addChild(csprite)
            self.zPosition = handz
            csprite.position = CGPointMake(x, realsize.height/2)
            
            let ratio = csprite.size.height / csprite.size.width
            
            csprite.size.width = dx
            csprite.size.height = dx * ratio
            
            
            x = x + dx
        }
        
        anchorPoint = CGPointMake(0, 0)
        
        var border = self.calculateAccumulatedFrame()
        border.size.width += 20
        border.size.height += 20
        border.origin.x -= 10
        border.origin.y -= 10

        
        var tile = SKShapeNode(rect: border , cornerRadius: 3)
        tile.strokeColor = UIColor.yellowColor()
        
        
    
        addChild(tile)
        
        var label = SKLabelNode(text: player.name)
        label.position = CGPointMake(border.origin.x + border.size.width, border.origin.y + border.size.height)
        label.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Top
        label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Right
        label.fontName = "Arial"
        label.fontSize = 10
        label.fontColor = UIColor.yellowColor()
        addChild(label)
        
        var label2 = SKLabelNode(text: player.name)
        label2.position = border.origin
        label2.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Bottom
        label2.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        label2.fontName = "Arial"
        label2.fontSize = 10
        label2.fontColor = UIColor.yellowColor()
        addChild(label2)
        
        if (!visible & (size != realsize)){
            self.runAction(SKAction.rotateToAngle(CGFloat(M_PI) / 2, duration: 0))
        }
        
        

        
    }
    
    func paint(){
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch in touches{
            let location = touch.locationInNode(self)
            let touchedNode = nodeAtPoint(location)
            if let sel=touchedNode as? CardSprite{
                selected = sel
                let liftAction = SKAction.scaleTo(1.3, duration: 0.3)
                selected?.runAction(liftAction, withKey: "lift")
                selected?.zPosition = selz
            }
        }
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        for touch in touches{
            let location = touch.locationInNode(self)
            if let s = selected{
                s.position = location
            }
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        let liftAction = SKAction.scaleTo(1, duration: 0.3)
        selected?.runAction(liftAction, withKey: "liftDown")
        selected?.zPosition = handz
        
        var sprites = [CardSprite]()
        
        for child in children{
            if let c = child as? CardSprite {
                sprites.append(c)
            }
        }
        
        sprites.sort { (f:  CardSprite, s: CardSprite) -> Bool in
            return f.position.x < s.position.x
        }
        
        moveCards(sprites)
    }
    
    override func touchesCancelled(touches: NSSet!, withEvent event: UIEvent!) {
        let liftAction = SKAction.scaleTo(1, duration: 0.3)
        selected?.runAction(liftAction, withKey: "liftDown")
        selected?.zPosition = handz

    }
    
    private func moveCards(cards:[CardSprite]){
        
        let dx = (size.width ) / CGFloat(player.cards.count)
        
        var x = dx / 2
        
        anchorPoint = CGPointZero
        
        var i = 0
        
        for c in cards{
            c.zPosition = handz + CGFloat(i)
            let act = SKAction.moveTo(CGPointMake(x, size.height / 2), duration: 0.5)
            c.runAction(act)
            x = x + dx
            i++
        }
    }
}
