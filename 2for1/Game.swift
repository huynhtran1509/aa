//
//  Game.swift
//  2for1
//
//  Created by Douglas Galante on 12/25/16.
//  Copyright © 2016 Flatiron. All rights reserved.
//

import Foundation

class Game {
    
    var players: [Player] = []
    var player: Player?
    var dice: [Die] = [Die()]
    var playerRoll: Int = 0
    var score: Int = 0
    var drinks: Int = 0
    var action: PlayerAction = .roll
    var turn = 1
    var instructions = ""

    
    func playerAction() {
        switch self.action {
        case .roll: roll()
        case .rollAddedDie: rollAddedDie()
        case .passDice: passDice()
        case .drink: drink()
        }
        
    }
    
}

//MARK: Player Actions
extension Game {
    
    func roll() {
        for die in dice {
            die.roll()
        }
        playerRoll = dice.reduce(0) { (result, nextDie) -> Int in
            return result + nextDie.value
        }
        if playerRoll < score {
            instructions = "rolled too low... tap to add a die or drink"
        } else if playerRoll == score {
            instructions = "roll matched score... tap to make \(player!.tag) drink"
            action = .drink
        } else {
            instructions = "roll is higher than score... tap to pass the dice"
            action = .passDice
        }
    }
    
    
    func passDice() {
        if turn < players.count {
            player = players[turn]
        } else {
            player = players[turn % players.count]
        }
        turn += 1
        drinks += 1
        score = playerRoll
        action = .roll
        instructions = "Dice were passed to \(player!.tag)... tap to roll"
    }
    
    
    func rollAddedDie() {
        dice.last?.roll()
        playerRoll = dice.reduce(0) { (result, nextDie) -> Int in
            return result + nextDie.value
        }
        if playerRoll <= score {
            action = .drink
            instructions = "rolled too low... tap to make \(player!.tag) drink"
        } else {
            instructions = "roll is higher than score... tap to pass the dice"
            action = .passDice
        }
    }
    
    func drink() {
        dice = [Die()]
        score = 0
        drinks = 0
        action = .roll
        instructions = "tap to have \(player!.tag) re-start the game"
    }
    
    func addDie() {
        dice.append(Die())
        drinks *= 2
        action = .rollAddedDie
        instructions = "Extra die added... tap to have \(player!.tag) roll added die!"
    }
    
}




