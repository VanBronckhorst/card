//
//  GameScene.swift
//  CardSprite
//
//  Created by Filippo Pellolio on 11/03/15.
//  Copyright (c) 2015 Filippo Pellolio. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let tx = SKTexture(imageNamed: "Table")
        
        let bk = SKSpriteNode(texture: tx, color: nil, size: self.size)
        bk.position = CGPointMake(0,0);
        addChild(bk)
        
        let p1=Player(name: "p1")
        let p2=Player(name: "p2")
        let p3=Player(name: "p3")
        let p4=Player(name: "p4")
        let p5=Player(name: "p5")
        
        let g = Game(players: [p1,p2,p3,p4,p5])
        
        let h = HandSprite(player: p1, size: CGSizeMake(self.size.width * 0.8 , 10), visible: true)
        h.position = CGPointMake(-h.size.width / 2, -size.height / 2)
        anchorPoint = CGPointMake(0.5, 0.5)
        
        let h1 = HandSprite(player: p2, size: CGSizeMake(self.size.width * 0.2 , 10), visible: false)
        h1.position = CGPointMake(-size.width * 0.3 , size.height / 2)
        
        let h2 = HandSprite(player: p3, size: CGSizeMake(self.size.width * 0.2 , 10), visible: false)
        h2.position = CGPointMake(size.width * 0.1 , size.height / 2)
        
        let h3 = HandSprite(player: p4, size: CGSizeMake( 10, self.size.height  * 0.3 ), visible: false)
        h3.position = CGPointMake(-size.width / 2 , -h3.size.width / 2)
        
        let h4 = HandSprite(player: p4, size: CGSizeMake( 10, self.size.height  * 0.3 ), visible: false)
        h4.position = CGPointMake(size.width / 2 , -h3.size.width / 2)
        
        addChild(h)
        addChild(h1)
        addChild(h2)
        addChild(h3)
        addChild(h4)
        
        let cp = CallCardPicker(turn: g.turn, rect: CGRectMake(0, h.size.height, self.size.width, 500))
        
        addChild(cp)
        
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        assertionFailure("Not Supported")
    }
}
