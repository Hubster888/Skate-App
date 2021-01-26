//
//  StartSkateGameView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 15/01/2021.
//

import SwiftUI

struct StartSkateGameView: View{
    
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
    
    @State var isTimerRunning = false
    @State private var startTime =  Date()
    @State var interval = TimeInterval()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    let skateGame : SkateGamePlayLocal
    @State var stateOfGame : StateOfGame = .start
    @Binding var isPresented: Bool
    
    @State private var isLoading = false
    @State private var endIsLoading = false
    
    @State var player1LossPressed = false
    @State var player2LossPressed = false
    
    var body: some View {
        ZStack{
            if(stateOfGame == .start){
                ZStack{
                    Color(red: 0.96, green: 0.96, blue: 0.96).edgesIgnoringSafeArea(.all)
                    VStack{
                        Spacer()
                        ZStack{
                            Text("Getting game ready!")
                                .font(.system(size: 20, design: .rounded))
                                .bold()
                                .offset(x: 0, y: -25)
                             
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color(.systemGray5), lineWidth: 3)
                                .frame(width: 250, height: 3)
                             
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color(red: 0.95, green: 0.32, blue: 0.34), lineWidth: 3)
                                .frame(width: 30, height: 3)
                                .offset(x: isLoading ? 110 : -110, y: 0)
                                .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                                .onAppear(perform: {
                                    self.isLoading = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                        withAnimation {
                                            stateOfGame = .player1Set
                                        }
                                    }
                                })
                        }
                        Spacer()
                        Image("skatePicModed")
                            .resizable()
                            .frame(width: width, height: height * 0.4, alignment: .bottom)
                            .offset(y: height * 0.05)
                    }
                }
                
                
            }else if(stateOfGame == .end || skateGame.getPlayer1Score() == 5 || skateGame.getPlayer2Score() == 5){
                ZStack{
                    Color.green.edgesIgnoringSafeArea(.all)
                    VStack{
                        Spacer()
                        ZStack{
                            Circle()
                                .stroke(Color(red: 66/255, green: 70/255, blue: 84/255), lineWidth: width * 0.05)
                                .frame(width: width * 0.5, height: width * 0.5)

                            Circle()
                                .trim(from: 0, to: 0.2)
                                .stroke(Color(red: 0.95, green: 0.32, blue: 0.34), lineWidth: 7)
                                .frame(width: width * 0.5, height: width * 0.5)
                                .rotationEffect(Angle(degrees: endIsLoading ? 360 : 0))
                                .animation(Animation.linear(duration: 2).repeatForever(autoreverses: false))
                                .onAppear(perform: {self.endIsLoading = true})
                            
                            Circle()
                                .stroke(Color(red: 66/255, green: 70/255, blue: 84/255), lineWidth: width * 0.05)
                                .frame(width: width * 0.6, height: width * 0.6)

                            Circle()
                                .trim(from: 0, to: 0.2)
                                .stroke(Color(red: 0.95, green: 0.32, blue: 0.34), lineWidth: 7)
                                .frame(width: width * 0.6, height: width * 0.6)
                                .rotationEffect(Angle(degrees: endIsLoading ? 0 : 360))
                                .animation(Animation.linear(duration: 2).repeatForever(autoreverses: false))
                                .onAppear(perform: {self.endIsLoading = true})
                            
                            Text(skateGame.getPlayer1Score() > skateGame.getPlayer2Score() ? "The winner is \n" + skateGame.getPlayer2().getName() : "The winner is \n" + skateGame.getPlayer1().getName())
                                .font(.system(size: width * 0.05, weight: .bold, design: .rounded))
                                .multilineTextAlignment(.center)
                        }.padding(.bottom, height * 0.1)
                        
                        Button(action: {
                            self.isPresented = false
                        }){
                            ZStack{
                                Rectangle()
                                    .fill(Color(red: 0.13, green: 0.15, blue: 0.22))
                                    .frame(width: width * 0.8, height: height * 0.08, alignment: .center)
                                    .cornerRadius(15)
                                Text("FINISH")
                                    .font(.system(size: width * 0.08, weight: .bold, design: .rounded))
                                    .foregroundColor(Color.white)
                            }
                        }
                        .buttonStyle(ScaleAnimationButtonEffect())
                        
                        Spacer()
                    }
                }
                
            }else{
                Rectangle()
                    .fill(skateGame.getPlayer1Score() >= skateGame.getPlayer2Score() ? Color(red: 0.96, green: 0.96, blue: 0.96).opacity(1) : Color(red: 0.15, green: 0.72, blue: 0.08).opacity(0.4))
                    .frame(width: width * 0.5, height: height, alignment: .leading)
                    .offset(x: -width * 0.25)
                Rectangle()
                    .fill(skateGame.getPlayer1Score() <= skateGame.getPlayer2Score() ? Color(red: 0.96, green: 0.96, blue: 0.96).opacity(1) : Color(red: 0.15, green: 0.72, blue: 0.08).opacity(0.4))
                    .frame(width: width * 0.5, height: height, alignment: .trailing)
                    .offset(x: width * 0.25)
                VStack{
                    ZStack{
                        Rectangle()
                            .fill(Color(red: 0.13, green: 0.15, blue: 0.22))
                            .frame(width: width, height: height * 0.4, alignment: .top)
                            .cornerRadius(20)
                        VStack{
                            // Time played
                            Text(interval.format(using: [.minute, .second]))
                                .font(Font.system(size: width * 0.09, design: .rounded))
                                .foregroundColor(Color.white)
                                .padding(.top, height * 0.1)
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
                               
                            // Name and button
                            Text((skateGame.getState() == .player1Set || skateGame.getState() == .player1Try) ? skateGame.getPlayer1().getName() : skateGame.getPlayer2().getName())
                                .font(.system(size: width * 0.08, weight: .bold, design: .rounded))
                                .foregroundColor(Color.white)
                                .padding(.top, height * 0.02)
                                .padding(.bottom, height * 0.02)
            
                            switch(skateGame.getState()){
                            case .player1Set:
                                Button(action: {
                                    withAnimation{
                                        skateGame.trickSet(player: skateGame.getPlayer1())
                                    }
                                }){
                                    ZStack{
                                        Rectangle()
                                            .fill(Color(red: 0.15, green: 0.72, blue: 0.08))
                                            .frame(width: width * 0.3, height: height * 0.05, alignment: .center)
                                            .cornerRadius(15)
                                        Text("Trick Set")
                                            .font(.system(size: width * 0.05, weight: .bold, design: .rounded))
                                            .foregroundColor(Color.white)
                                    }
                                }
                                .buttonStyle(ScaleAnimationButtonEffect())

                            case .player2Set:
                                Button(action: {
                                    withAnimation{
                                        skateGame.trickSet(player: skateGame.getPlayer2())
                                    }
                                }){
                                    ZStack{
                                        Rectangle()
                                            .fill(Color(red: 0.15, green: 0.72, blue: 0.08))
                                            .frame(width: width * 0.3, height: height * 0.05, alignment: .center)
                                            .cornerRadius(15)
                                        Text("Trick Set")
                                            .font(.system(size: width * 0.05, weight: .bold, design: .rounded))
                                            .foregroundColor(Color.white)
                                    }
                                }
                                .buttonStyle(ScaleAnimationButtonEffect())
                                
                            case .player1Try:
                                HStack{
                                    Button(action: {
                                        withAnimation{
                                            skateGame.trickNailed(player: skateGame.getPlayer1())
                                        }
                                    }){
                                        ZStack{
                                            Rectangle()
                                                .fill(Color(red: 0.15, green: 0.72, blue: 0.08))
                                                .frame(width: width * 0.3, height: height * 0.05, alignment: .center)
                                                .cornerRadius(15)
                                            Text("Nailed It!")
                                                .font(.system(size: width * 0.05, weight: .bold, design: .rounded))
                                                .foregroundColor(Color.white)
                                        }
                                    }
                                    .buttonStyle(ScaleAnimationButtonEffect())
                                    
                                    Button(action: {
                                        withAnimation{
                                            skateGame.trickFailed(player: skateGame.getPlayer1())
                                            player1LossPressed = true
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                                withAnimation {
                                                    player1LossPressed = false
                                                }
                                            }
                                        }
                                    }){
                                        ZStack{
                                            Rectangle()
                                                .fill(Color(red: 0.65, green: 0.15, blue: 0.03))
                                                .frame(width: width * 0.3, height: height * 0.05, alignment: .center)
                                                .cornerRadius(15)
                                            Text("FAILED")
                                                .font(.system(size: width * 0.05, weight: .bold, design: .rounded))
                                                .foregroundColor(Color.white)
                                        }
                                    }
                                    .buttonStyle(ScaleAnimationButtonEffect())
                                }
                                
                            case .player2Try:
                                HStack{
                                    Button(action: {
                                        withAnimation{
                                            skateGame.trickNailed(player: skateGame.getPlayer2())
                                        }
                                    }){
                                        ZStack{
                                            Rectangle()
                                                .fill(Color(red: 0.15, green: 0.72, blue: 0.08))
                                                .frame(width: width * 0.3, height: height * 0.05, alignment: .center)
                                                .cornerRadius(15)
                                            Text("Nailed It!")
                                                .font(.system(size: width * 0.05, weight: .bold, design: .rounded))
                                                .foregroundColor(Color.white)
                                        }
                                    }
                                    .buttonStyle(ScaleAnimationButtonEffect())
                                    
                                    Button(action: {
                                        withAnimation{
                                            skateGame.trickFailed(player: skateGame.getPlayer2())
                                            player2LossPressed = true
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                                withAnimation {
                                                    player2LossPressed = false
                                                }
                                            }
                                        }
                                    }){
                                        ZStack{
                                            Rectangle()
                                                .fill(Color(red: 0.65, green: 0.15, blue: 0.03))
                                                .frame(width: width * 0.3, height: height * 0.05, alignment: .center)
                                                .cornerRadius(15)
                                            Text("FAILED")
                                                .font(.system(size: width * 0.05, weight: .bold, design: .rounded))
                                                .foregroundColor(Color.white)
                                        }
                                    }
                                    .buttonStyle(ScaleAnimationButtonEffect())
                                }
                                
                            default:
                                Text("")
                            }
                        }
                    }
                    HStack{
                        VStack{
                            Text(skateGame.getPlayer1().getName())
                                .font(.system(size: width * 0.05, weight: .bold, design: .rounded))
                                .underline()
                                .frame(width: width * 0.45, alignment: .center)
                                .offset(x: width * 0.05)
                                .padding(.bottom, height * 0.04)
                            Text("S")
                                .foregroundColor(skateGame.getPlayer1Score() > 0 ? Color(red: 0.95, green: 0.32, blue: 0.34) : Color(red: 66/255, green: 70/255, blue: 84/255))
                                .font(.system(size: width * 0.06, weight: .bold, design: .rounded))
                                .frame(width: width * 0.45, alignment: .center)
                                .offset(x: width * 0.05)
                                .padding(.bottom, height * 0.025)
                                .scaleEffect(player1LossPressed && skateGame.getPlayer1Score() == 1 ? 1.5 : 1.0)
                            Text("K")
                                .foregroundColor(skateGame.getPlayer1Score() > 1 ? Color(red: 0.95, green: 0.32, blue: 0.34) : Color(red: 66/255, green: 70/255, blue: 84/255))
                                .font(.system(size: width * 0.06, weight: .bold, design: .rounded))
                                .frame(width: width * 0.45, alignment: .center)
                                .offset(x: width * 0.05)
                                .padding(.bottom, height * 0.025)
                                .scaleEffect(player1LossPressed && skateGame.getPlayer1Score() == 2 ? 1.5 : 1.0)
                            Text("A")
                                .foregroundColor(skateGame.getPlayer1Score() > 2 ? Color(red: 0.95, green: 0.32, blue: 0.34) : Color(red: 66/255, green: 70/255, blue: 84/255))
                                .font(.system(size: width * 0.06, weight: .bold, design: .rounded))
                                .frame(width: width * 0.45, alignment: .center)
                                .offset(x: width * 0.05)
                                .padding(.bottom, height * 0.025)
                                .scaleEffect(player1LossPressed && skateGame.getPlayer1Score() == 3 ? 1.5 : 1.0)
                            Text("T")
                                .foregroundColor(skateGame.getPlayer1Score() > 3 ? Color(red: 0.95, green: 0.32, blue: 0.34) : Color(red: 66/255, green: 70/255, blue: 84/255))
                                .font(.system(size: width * 0.06, weight: .bold, design: .rounded))
                                .frame(width: width * 0.45, alignment: .center)
                                .offset(x: width * 0.05)
                                .padding(.bottom, height * 0.025)
                                .scaleEffect(player1LossPressed && skateGame.getPlayer1Score() == 4 ? 1.5 : 1.0)
                            Text("E")
                                .foregroundColor(skateGame.getPlayer1Score() > 4 ? Color(red: 0.95, green: 0.32, blue: 0.34) : Color(red: 66/255, green: 70/255, blue: 84/255))
                                .font(.system(size: width * 0.06, weight: .bold, design: .rounded))
                                .frame(width: width * 0.45, alignment: .center)
                                .offset(x: width * 0.05)
                                .scaleEffect(player1LossPressed && skateGame.getPlayer1Score() == 5 ? 1.5 : 1.0)
                        }
                        
                        ZStack{
                            Rectangle()
                                .fill(Color(red: 0.13, green: 0.15, blue: 0.22))
                                .frame(width: width * 0.05, height: height * 0.6, alignment: .center)
                                .padding(.bottom, -height * 0.05)
                                .padding(.top, -height * 0.05)
                            ZStack{
                                Circle()
                                    .fill(Color(red: 0.95, green: 0.32, blue: 0.34))
                                    .frame(width: width * 0.15, height: width * 0.15, alignment: .center)
                                    .shadow(color: Color(red: 0.13, green: 0.15, blue: 0.22), radius: 10, x: 5, y: 5)
                                Text("VS")
                                    .font(.system(size: width * 0.07, weight: .bold, design: .rounded))
                                    .foregroundColor(Color(red: 0.13, green: 0.15, blue: 0.22))
                            }
                        }
                        VStack{
                            Text(skateGame.getPlayer2().getName())
                                .font(.system(size: width * 0.05, weight: .bold, design: .rounded))
                                .underline()
                                .frame(width: width * 0.45, alignment: .center)
                                .offset(x: -width * 0.05)
                                .padding(.bottom, height * 0.04)
                            Text("S")
                                .foregroundColor(skateGame.getPlayer2Score() > 0 ? Color(red: 0.95, green: 0.32, blue: 0.34) : Color(red: 66/255, green: 70/255, blue: 84/255))
                                .font(.system(size: width * 0.06, weight: .bold, design: .rounded))
                                .frame(width: width * 0.45, alignment: .center)
                                .offset(x: -width * 0.05)
                                .padding(.bottom, height * 0.025)
                                .scaleEffect(player2LossPressed && skateGame.getPlayer2Score() == 1 ? 1.5 : 1.0)
                            Text("K")
                                .foregroundColor(skateGame.getPlayer2Score() > 1 ? Color(red: 0.95, green: 0.32, blue: 0.34) : Color(red: 66/255, green: 70/255, blue: 84/255))
                                .font(.system(size: width * 0.06, weight: .bold, design: .rounded))
                                .frame(width: width * 0.45, alignment: .center)
                                .offset(x: -width * 0.05)
                                .padding(.bottom, height * 0.025)
                                .scaleEffect(player2LossPressed && skateGame.getPlayer2Score() == 2 ? 1.5 : 1.0)
                            Text("A")
                                .foregroundColor(skateGame.getPlayer2Score() > 2 ? Color(red: 0.95, green: 0.32, blue: 0.34) : Color(red: 66/255, green: 70/255, blue: 84/255))
                                .font(.system(size: width * 0.06, weight: .bold, design: .rounded))
                                .frame(width: width * 0.45, alignment: .center)
                                .offset(x: -width * 0.05)
                                .padding(.bottom, height * 0.025)
                                .scaleEffect(player2LossPressed && skateGame.getPlayer2Score() == 3 ? 1.5 : 1.0)
                            Text("T")
                                .foregroundColor(skateGame.getPlayer2Score() > 3 ? Color(red: 0.95, green: 0.32, blue: 0.34) : Color(red: 66/255, green: 70/255, blue: 84/255))
                                .font(.system(size: width * 0.06, weight: .bold, design: .rounded))
                                .frame(width: width * 0.45, alignment: .center)
                                .offset(x: -width * 0.05)
                                .padding(.bottom, height * 0.025)
                                .scaleEffect(player2LossPressed && skateGame.getPlayer2Score() == 4 ? 1.5 : 1.0)
                            Text("E")
                                .foregroundColor(skateGame.getPlayer2Score() > 4 ? Color(red: 0.95, green: 0.32, blue: 0.34) : Color(red: 66/255, green: 70/255, blue: 84/255))
                                .font(.system(size: width * 0.06, weight: .bold, design: .rounded))
                                .frame(width: width * 0.45, alignment: .center)
                                .offset(x: -width * 0.05)
                                .scaleEffect(player2LossPressed && skateGame.getPlayer2Score() == 5 ? 1.5 : 1.0)
                        }
                    }
                    
                    Button(action: {
                        if(skateGame.getPlayer1Score() != 5 && skateGame.getPlayer2Score() != 5){
                            self.isPresented = false
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            withAnimation {
                                skateGame.endGame()
                                stateOfGame = .end
                            }
                        }
                    }){
                        ZStack{
                            Rectangle()
                                .fill(Color(red: 0.13, green: 0.15, blue: 0.22))
                                .frame(width: width * 0.8, height: height * 0.08, alignment: .center)
                                .cornerRadius(15)
                            Text("END")
                                .font(.system(size: width * 0.08, weight: .bold, design: .rounded))
                                .foregroundColor(Color.white)
                        }
                    }
                    .buttonStyle(ScaleAnimationButtonEffect())
                    .padding(.bottom, height * 0.1)
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

