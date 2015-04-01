//
//  Game.swift
//  CardSprite
//
//  Created by Filippo Pellolio on 19/03/15.
//  Copyright (c) 2015 Filippo Pellolio. All rights reserved.
//

import Foundation


class Game : TurnDelegate{
    var standing:Dictionary<Player,Int> = Dictionary<Player,Int>()
    var players:[Player]
    var turn:Turn
    
    
    
    init(players:[Player]){
        if (players.count==5){
            self.players = players
        }else{
            assertionFailure("Not enough Players")
        }
        
        standing = Dictionary<Player,Int>()
        
        for player in self.players{
            standing.updateValue(0, forKey: player)
        }
        
     
        turn = Turn(players: self.players)
        turn.delegate = self
        
        turn.start()
    }
    
    
    func cardDealed(Turn){
        
    }
    func callPhaseStarted(Turn){}
    func callPhaseEnded(Turn){}
    func cleanSlate(Turn){}
    func turnEnded(Turn){}
}