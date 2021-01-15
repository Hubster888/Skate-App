//
//  StartSkateGameView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 15/01/2021.
//

import SwiftUI

struct StartSkateGameView: View {
    
    var height: CGFloat {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return UIScreen.main.bounds.height
        } else {
            return UIScreen.main.bounds.height
        }
    }
    
    var width: CGFloat {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return UIScreen.main.bounds.width
        } else {
            return UIScreen.main.bounds.width
        }
    }
    
    let skateGame : SkateGamePlayLocal = SkateGamePlayLocal(player1: Player(name: "User1"), player2: Player(name: "User2"))
    @State var stateOfGame : StateOfGame = .start
    @Binding var isPresented: Bool
    
    //Timer stuff
    @State var isTimerRunning = false
    @State private var startTime =  Date()
    @State var interval = TimeInterval()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack{
            Color(red: 0.96, green: 0.96, blue: 0.96).edgesIgnoringSafeArea(.all)

            if(stateOfGame == .start){
                Text("Start is active").onAppear(perform: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        stateOfGame = .player1Set
                    }
                })
            }else if(stateOfGame == .end){
                Text("done")
            }else{
                VStack{
                    
                    // Time played
                    Text(interval.format(using: [.minute, .second]))
                        .font(Font.system(.largeTitle, design: .rounded))
                        .foregroundColor(Color(red: 0.13, green: 0.15, blue: 0.22))
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
                        .padding(.top, 50)
                        .padding(.bottom, 60)
                    
                    //Top section with name, instruction and options to press
                    HStack{
                        VStack{
                            switch(skateGame.getState()){
                            case .player1Set:
                                Text(skateGame.getPlayer1().getName())
                                    .font(Font.system(.title3, design: .rounded))
                                    .foregroundColor(Color(red: 0.13, green: 0.15, blue: 0.22))
                                    .padding(.bottom, 20)
                 
                                Text("It's youre turn to set the trick")
                                    .font(Font.system(.subheadline, design: .rounded))
                                    .foregroundColor(Color(red: 0.13, green: 0.15, blue: 0.22))

                            case .player2Set:
                                Text(skateGame.getPlayer2().getName())
                                    .font(Font.system(.title3, design: .rounded))
                                    .foregroundColor(Color(red: 0.13, green: 0.15, blue: 0.22))
                                    .padding(.bottom, 20)
                                
                                Text("It's youre turn to set the trick")
                                    .font(Font.system(.subheadline, design: .rounded))
                                    .foregroundColor(Color(red: 0.13, green: 0.15, blue: 0.22))
                                
                            case .player1Try:
                                Text(skateGame.getPlayer1().getName())
                                    .font(Font.system(.title3, design: .rounded))
                                    .foregroundColor(Color(red: 0.13, green: 0.15, blue: 0.22))
                                    .padding(.bottom, 20)
                                
                                Text("Copy the trick")
                                    .font(Font.system(.subheadline, design: .rounded))
                                    .foregroundColor(Color(red: 0.13, green: 0.15, blue: 0.22))
                                
                            case .player2Try:
                                Text(skateGame.getPlayer2().getName())
                                    .font(Font.system(.title3, design: .rounded))
                                    .foregroundColor(Color(red: 0.13, green: 0.15, blue: 0.22))
                                    .padding(.bottom, 20)
                                
                                Text("Copy the trick")
                                    .font(Font.system(.subheadline, design: .rounded))
                                    .foregroundColor(Color(red: 0.13, green: 0.15, blue: 0.22))
                                
                            default:
                                Text("")
                            }
                        }
                        .frame(width: width * 0.3, alignment: .topLeading)
                        .offset(x: -width * 0.15)
                        
                        VStack{
                            switch(skateGame.getState()){
                            case .player1Set:
                                Button(action: {skateGame.trickSet(player: skateGame.getPlayer1())}){
                                    Text("Trick set")
                                }.buttonStyle(GradientButtonStyle())
                            case .player2Set:
                                Button(action: {skateGame.trickSet(player: skateGame.getPlayer2())}){
                                    Text("Trick set")
                                }.buttonStyle(GradientButtonStyle())
                            case .player1Try:
                                Button(action: {skateGame.trickNailed(player: skateGame.getPlayer1())}){
                                    Text("Trick Nailed")
                                }.buttonStyle(GradientButtonStyle())
                                Button(action: {skateGame.trickFailed(player: skateGame.getPlayer1())}){
                                    Text("Trick Failed")
                                }.buttonStyle(GradientButtonStyle())
                            case .player2Try:
                                Button(action: {skateGame.trickNailed(player: skateGame.getPlayer2())}){
                                    Text("Trick Nailed")
                                }.buttonStyle(GradientButtonStyle())
                                Button(action: {skateGame.trickFailed(player: skateGame.getPlayer2())}){
                                    Text("Trick Failed")
                                }.buttonStyle(GradientButtonStyle())
                            default:
                                Text("")
                            }
                        }
                        .frame(width: width * 0.3, alignment: .topTrailing)
                        .offset(x: width * 0.15)
                        .padding(.trailing, 20)
                    }
                    
                    // Player 1 stats section
                    VStack{
                        Rectangle()
                            .fill(Color(red: 0.13, green: 0.15, blue: 0.22))
                            .frame(width: width * 0.9, height: 5, alignment: .center)

                        Text(skateGame.getPlayer1().getName())
                        HStack{
                            Text("S")
                            Spacer()
                            Text("K")
                            Spacer()
                            Text("A")
                            Spacer()
                            Text("T")
                            Spacer()
                            Text("E")
                        }
                    }
                    
                    // Player 2 stats section
                    VStack{
                        Rectangle()
                            .fill(Color(red: 0.13, green: 0.15, blue: 0.22))
                            .frame(width: width * 0.9, height: 5, alignment: .center)
                        
                        Text(skateGame.getPlayer2().getName())
                        HStack{
                            Text("S")
                            Spacer()
                            Text("K")
                            Spacer()
                            Text("A")
                            Spacer()
                            Text("T")
                            Spacer()
                            Text("E")
                        }
                    }
                    
                    // End button
                    Spacer()
                    Button(action: {
                        skateGame.endGame()
                        stateOfGame = .end
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            self.isPresented = false
                        }
                    }){
                        Text("End").frame(width: width * 0.8, height: height * 0.05, alignment: .center)
                    }
                    .buttonStyle(GradientButtonStyle())
                    .padding(.bottom, 20)
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

