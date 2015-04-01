//
//  Turn.swift
//  CardSprite
//
//  Created by Filippo Pellolio on 19/03/15.
//  Copyright (c) 2015 Filippo Pellolio. All rights reserved.
//

import Foundation

class PlayedCard{
    let player:Player
    let card:Card
    
    init(p:Player,c:Card){
        player = p
        card = c
    }
}

protocol TurnDelegate{
    func cardDealed(Turn)
    func callPhaseStarted(Turn)
    func callPhaseEnded(Turn)
    func cleanSlate(Turn)
    func turnEnded(Turn)
}


class Turn{
    var caller:Player?
    var cardCalled:Card?
    var suitCalled:Suit? = nil
    var onTable:[PlayedCard]{
        didSet{
            if onTable.count == 5 {
                computeWinner()
            }
        }
    }
    
    var deck: Deck
    
    var delegate:TurnDelegate?
    
    var takenCards:Dictionary<Player,[Card]>
    
    var toPlay:[Player]
    
    var canCall:Dictionary<Player,Bool> = Dictionary<Player,Bool> ()
    
    init(players:[Player]){
        caller = nil
        cardCalled = nil
    
        toPlay = players
        onTable = [PlayedCard]()
        
        deck = Deck()
        
        takenCards = Dictionary<Player,[Card]>()
        
       
        
    }
    
    func start(){
        for p in toPlay{
            takenCards.updateValue([Card](), forKey: p)
            canCall.updateValue(true, forKey: p)
        }
        
        while !deck.isEmpty(){
            for p in toPlay{
                p.takeCard(deck.draw()!)
            }
        }
        
        delegate?.cardDealed(self)
        delegate?.callPhaseStarted(self)
    }
    
    private func computeWinner(){
        var winner:PlayedCard = onTable[0]
        var winnerRating:Int = 0
        var firstSuit = onTable[0].card.suit
        
        for c in onTable{
            var rate = c.card.suit == suitCalled ? 20 + CardValue.VALUES[c.card.value]! : CardValue.VALUES[c.card.value]!
            rate = (c.card.suit == suitCalled) | (c.card.suit == firstSuit) ? rate : 0
            
            if (rate > winnerRating){
                winner = c
                winnerRating = rate
            }
        }

        var tak:[Card] = [Card]()
        
        for c in onTable{
            tak.append(c.card)
        }
        onTable.removeAll(keepCapacity: false)
        
        takeCards(winner.player, cards: tak)
        
        delegate?.cleanSlate(self)
        
        
    }
    
    func changeFirst(first: Player){
        while(first != toPlay[0]){
            let p=toPlay.removeAtIndex(0)
            toPlay.append(p)
        }
    }
    
    func takeCards(p:Player, cards:[Card]){
        var tak = takenCards[p]!
        
        for c in cards{
           tak.append(c)
        }
        
        takenCards.updateValue(tak , forKey: p)
    }
    
    func playCard(player:Player , card:Card){
        if (player == toPlay[0]){
            onTable.append(PlayedCard(p: player, c: card))
        }
    }
    
    func callCard(player:Player , card:Card?){
        if (player == toPlay[0])&(canCall[player]!){
            if let c=card{
                if let old=cardCalled {
                if ( (CardValue.VALUES[c.value] < CardValue.VALUES[old.value] ) | (( CardValue.VALUES[c.value] == CardValue.VALUES[old.value]) & (c.value.rawValue < old.value.rawValue) ) ){
                    cardCalled = c
                    suitCalled = c.suit
                    caller = player
                    }}
                else
                {
                    cardCalled = c
                    suitCalled = c.suit
                    caller = player
                }
            }else{
                canCall.updateValue(false, forKey: player)
            }
        
            var next:Player? = nil
            for p in toPlay{
                if (p != toPlay[0])&( canCall[p]!){
                    next = p
                }
            }
            if let n=next{
                changeFirst(n)
            }else{
                canCall.updateValue(false, forKey: player)
                changeFirst(player)
                delegate?.callPhaseEnded(self)
            }
            
        }
    }
    
    
    
}