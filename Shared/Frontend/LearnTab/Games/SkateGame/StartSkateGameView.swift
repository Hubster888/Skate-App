//
//  StartSkateGameView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 15/01/2021.
//

import SwiftUI

struct StartSkateGameView: View{
    //MARK: Variable Declerations
    //Timer variables
    @State var isTimerRunning = false
    @State private var startTime =  Date()
    @State var interval = TimeInterval()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    //Game variables
    @State var stateOfGame : StateOfGame = .start
    @State var skateGame : SkateGamePlayLocal
    @State var player1LossPressed = false
    @State var player2LossPressed = false
    let winningScore : Int = 5
    var userName : String {
        return (stateOfGame == .player1Set || stateOfGame == .player1Try) ? skateGame.getPlayer1().getName() : skateGame.getPlayer2().getName()
    }
    
    //Presenting view Booleans
    @Binding var isPresented: Bool
    @State private var isLoading = false
    @State private var endIsLoading = false
    
    //View variables
    var offsetFromMid : CGFloat {
        return width * 0.25
    }
    var heightOfTopBox : CGFloat {
        return height * 0.4
    }
    var fontSize : CGFloat {
        return width * 0.08
    }
    var timerTopPadding : CGFloat {
        return height * 0.1
    }
    var playerNamePadding : CGFloat {
        return height * 0.02
    }
    var endButtonHeight : CGFloat {
        return height * 0.08
    }
    var endButtonWidth : CGFloat {
        return width * 0.8
    }
    var smallFont : CGFloat {
        return width * 0.04
    }
    let loosingColor : Color = Color(red: 0.96, green: 0.96, blue: 0.96).opacity(1)
    let winingColor : Color = Color(red: 0.15, green: 0.72, blue: 0.08).opacity(0.4)
    let topBoxColor : Color = Color(red: 0.13, green: 0.15, blue: 0.22)
    let cornerRadius : CGFloat = 20
    var height: CGFloat = UIScreen.main.bounds.height
    var width: CGFloat = UIScreen.main.bounds.width
    
    //MARK: Body
    var body: some View {
        ZStack{
            if(stateOfGame == .start){
                //MARK: Loading View
                LoadingView(isLoading: self.$isLoading)
                    .onAppear(perform: {
                        self.isLoading = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            withAnimation {
                                self.stateOfGame = .player1Set
                                skateGame.setState(state: .player1Set)
                            }
                        }
                })
            }else if(stateOfGame == .end || skateGame.getPlayer1Score() == 5 || skateGame.getPlayer2Score() == 5){
                //End Game View
                GameOverView(endIsLoading: self.$endIsLoading, isPresented: self.$isPresented, skateGame: self.skateGame)
            }else{
                //MARK: Game View
                // Background colors indicating who is winning
                Rectangle()
                    .fill(skateGame.getPlayer1Score() >= skateGame.getPlayer2Score() ? loosingColor : winingColor)
                    .frame(width: width/2, height: height, alignment: .leading)
                    .offset(x: -offsetFromMid)
                Rectangle()
                    .fill(skateGame.getPlayer1Score() <= skateGame.getPlayer2Score() ? loosingColor : winingColor)
                    .frame(width: width/2, height: height, alignment: .trailing)
                    .offset(x: offsetFromMid)
                
                VStack{
                    //MARK: Top Of VIew
                    ZStack{
                        // Background of top box
                        Rectangle()
                            .fill(topBoxColor)
                            .frame(width: width, height: heightOfTopBox, alignment: .top)
                            .cornerRadius(cornerRadius)
                        VStack{
                            // Timer to show how long the game is
                            Text(interval.format(using: [.minute, .second]))
                                .font(Font.system(size: fontSize, design: .rounded))
                                .foregroundColor(loosingColor)
                                .padding(.top, timerTopPadding)
                                .onReceive(timer) { _ in
                                    if self.isTimerRunning {
                                        interval = Date().timeIntervalSince(startTime)
                                    }
                                }
                                .onAppear() {
                                    if !isTimerRunning {
                                        startTime = Date()
                                    }
                                    isTimerRunning.toggle()
                                }
                            // Name and button, display whoever's turn it is
                            Text(userName)
                                .font(.system(size: (userName.count < 8) ? fontSize : smallFont, weight: .bold, design: .rounded))
                                .foregroundColor(Color.white)
                                .padding(.top, playerNamePadding)
                                .padding(.bottom, playerNamePadding)
                            
                            //MARK: Instructions And Options
                            switch(stateOfGame){
                            case .player1Set:
                                SkateOptionSet(skateGame: self.$skateGame, stateOfGame: self.$stateOfGame, playerTurn: 1)
                            case .player2Set:
                                SkateOptionSet(skateGame: self.$skateGame, stateOfGame: self.$stateOfGame, playerTurn: 2)
                            case .player1Try:
                                SkateOptionTry(skateGame: self.$skateGame, stateOfGame: self.$stateOfGame, player1LossPressed: self.$player1LossPressed, player2LossPressed: self.$player2LossPressed, playerTurn: 1)
                            case .player2Try:
                                SkateOptionTry(skateGame: self.$skateGame, stateOfGame: self.$stateOfGame, player1LossPressed: self.$player1LossPressed, player2LossPressed: self.$player2LossPressed, playerTurn: 2)
                            default:
                                Text("")
                            }
                        }
                    }
                    //MARK: Score Display
                    SkateScoreDisplay(skateGame: self.$skateGame, player1LossPressed: self.$player1LossPressed, player2LossPressed: self.$player2LossPressed)
                    
                    // End game button
                    Button(action: {
                        if(skateGame.getPlayer1Score() != winningScore && skateGame.getPlayer2Score() != winningScore){
                            self.isPresented = false
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            withAnimation {
                                skateGame.endGame()
                            }
                        }
                    }){
                        ZStack{
                            Rectangle()
                                .fill(topBoxColor)
                                .frame(width: endButtonWidth, height: endButtonHeight, alignment: .center)
                                .cornerRadius(cornerRadius)
                            Text("FINISH")
                                .font(.system(size: fontSize, weight: .bold, design: .rounded))
                                .foregroundColor(loosingColor)
                        }
                    }
                    .buttonStyle(ScaleAnimationButtonEffect())
                    .padding(.bottom, timerTopPadding)
                }
            }
        }
    }
}

extension TimeInterval {
    func format(using units: NSCalendar.Unit) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = units
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: self) ?? ""
    }
}

