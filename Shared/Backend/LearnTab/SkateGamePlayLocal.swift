//
//  SkateGamePlay.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 15/01/2021.
//

import Foundation

enum StateOfGame{
    case start
    case player1Set
    case player2Set
    case player1Try
    case player2Try
    case end
}

class SkateGamePlayLocal{
    
    private let player1 : Player
    private let player2 : Player
    private var stateOfGame : StateOfGame = .player1Set
    
    init(player1: Player, player2: Player){
        self.player1 = player1
        self.player2 = player2
    }
    
    func startGame(){
        self.stateOfGame = .end
    }
    
    func getState() -> StateOfGame{
        return self.stateOfGame
    }
    
    func getPlayer1() -> Player{
        return self.player1
    }
    
    func getPlayer2() -> Player{
        return self.player2
    }
    
    func trickFailed(player: Player){
        switch(player.getName()){
        case player1.getName():
            player1.addLoss()
            self.stateOfGame = .player2Set
        case player2.getName():
            player2.addLoss()
            self.stateOfGame = .player1Set
        default:
            print("This player does not exist!!")
            self.stateOfGame = .end
        }
    }
    
    func endGame(){
        self.stateOfGame = .end
    }
    
    func trickNailed(player: Player){
        switch(player.getName()){
        case player1.getName():
            self.stateOfGame = .player1Set
        case player2.getName():
            self.stateOfGame = .player2Set
        default:
            print("This player does not exist!!")
            self.stateOfGame = .end
        }
    }
    
    func trickSet(player: Player){
        switch(player.getName()){
        case player1.getName():
            self.stateOfGame = .player2Try
        case player2.getName():
            self.stateOfGame = .player1Try
        default:
            print("This player does not exist!!")
            self.stateOfGame = .end
        }
    }
    
    func getPlayer1Score() -> Int{
        return self.player1.getScore()
    }
    
    func getPlayer2Score() -> Int{
        return self.player2.getScore()
    }
}

class Player{
    private let name : String
    private var score : Int = 0
    
    init(name: String){
        self.name = name
    }
    
    func getName() -> String{
        return self.name
    }
    
    func addLoss(){
        self.score += 1
    }
    
    func getScore() -> Int{
        return self.score
    }
}
