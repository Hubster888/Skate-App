//
//  GameOverView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 23/02/2021.
//

import SwiftUI
import ConfettiView

struct GameOverView: View {
    
    //MARK: Variable declerations
    //Navigation variables
    @Binding var endIsLoading : Bool
    @Binding var isPresented : Bool
    
    //Related data variables
    let skateGame : SkateGamePlayLocal
    var winner : String {
        return skateGame.getPlayer1Score() > skateGame.getPlayer2Score() ? "The winner is \n" + skateGame.getPlayer2().getName() : "The winner is \n" + skateGame.getPlayer1().getName()
    }
    
    //View variables
    var lineWidth : CGFloat {
        return width * 0.05
    }
    var circleWidth : CGFloat {
        return width * 0.5
    }
    var circleWidth2 : CGFloat {
        return width * 0.6
    }
    var bottomPadding : CGFloat {
        return height * 0.1
    }
    var buttonWidth : CGFloat {
        return width * 0.8
    }
    var buttonHeight : CGFloat {
        return height * 0.08
    }
    var finishFontSize : CGFloat {
        return width * 0.08
    }
    var smallFont : CGFloat {
        return width * 0.04
    }
    var bigFont : CGFloat {
        return width * 0.05
    }
    var gifHeight : CGFloat {
        return height * 0.35
    }
    let height : CGFloat = UIScreen.main.bounds.height
    let width : CGFloat = UIScreen.main.bounds.width
    let ringColor : Color = Color(red: 66/255, green: 70/255, blue: 84/255) // Red
    let defaultColor : Color = Color(red: 66/255, green: 70/255, blue: 84/255) // Black
    let circleLineWidth : CGFloat = 7
    let cornerRadius : CGFloat = 15
    
    //Confetti view
    @State var isShowingConfetti: Bool = true// true while confetti is displayed
    
    
    //MARK: Body
    var body: some View {
        ZStack{
            VStack{
                AnimatedImageView(fileName: "PlanEndGIF") // Celebration GIF
                    .frame(width: width, height: gifHeight, alignment: .top)
                    .padding(.bottom, smallFont)
                    .shadow(color: defaultColor, radius: circleLineWidth, x: circleLineWidth, y: circleLineWidth)
                    .cornerRadius(cornerRadius)
                Spacer()
                Text(winner)
                    .font(.system(size: (winner.count < 20) ? bigFont : smallFont, weight: .bold, design: .monospaced))
                    .multilineTextAlignment(.center)
                Spacer()
                Button(action: {
                    self.isPresented = false
                }){
                    ZStack{
                        Rectangle()
                            .fill(ringColor)
                            .frame(width: buttonWidth, height: buttonHeight, alignment: .center)
                            .cornerRadius(cornerRadius)
                        Text("FINISH")
                            .font(.system(size: finishFontSize, weight: .bold, design: .rounded))
                            .foregroundColor(Color.white)
                    }
                }
                .buttonStyle(ScaleAnimationButtonEffect())
                Spacer()
            }
            let confettiCelebrationView = ConfettiCelebrationView(isShowingConfetti: $isShowingConfetti, timeLimit: 1.0)
            

            ZStack {
                if isShowingConfetti { confettiCelebrationView }
            }.onAppear{
                NotificationCenter.default.post(name: Notification.Name.playConfettiCelebration, object: Bool.self)
            }.transition(.slowFadeIn)
        }
    }
}

//MARK: Confetti view
// a timed celebration
struct ConfettiCelebrationView: View {

    @Binding var isShowingConfetti: Bool // true while confetti is displayed
    private var timeLimit: TimeInterval // how long to display confetti
    @State private var timer = Timer.publish(every: 0.0, on: .main, in: .common).autoconnect()

    init(isShowingConfetti: Binding<Bool>, timeLimit: TimeInterval = 4.0) {
        self.timeLimit = timeLimit
        _isShowingConfetti = isShowingConfetti
    }

    var body: some View {

        // define confetti cell elements & fadeout transition
        let confetti = ConfettiView( confetti: [
            .text("🎉"),
            .text("💪"),
            .shape(.triangle),
            // if using SF symbols, UIImage takes systemName to build
            .image(UIImage(systemName: "star.fill")!)
        ]).transition(.slowFadeOut)

        return ZStack {
            // show either confetti or nothing
            if isShowingConfetti { confetti } else { EmptyView() }
        }.onReceive(timer) { time in
            // timer beat is one interval then quit the confetti
            self.timer.upstream.connect().cancel()
            self.isShowingConfetti = false
        }.onReceive(NotificationCenter.default.publisher(for: Notification.Name.playConfettiCelebration)) { _ in
            // got notification so do --> reset & play
            self.resetTimerAndPlay()
        }
    }

    // reset the timer and turn on confetti
    private func resetTimerAndPlay() {
        timer = Timer.publish(every: self.timeLimit, on: .main, in: .common).autoconnect()
        isShowingConfetti = true
    }

}

// notification to start timer & display the confetti celebration view
public extension Notification.Name {
    static let playConfettiCelebration = Notification.Name("play_confetti_celebration")
}

// fade in & out transitions for ConfettiView and Play button
extension AnyTransition {
    static var slowFadeOut: AnyTransition {
        let insertion = AnyTransition.opacity
        let removal = AnyTransition.opacity.animation(.easeOut(duration: 1.5))
        return .asymmetric(insertion: insertion, removal: removal)
    }

    static var slowFadeIn: AnyTransition {
        let insertion = AnyTransition.opacity.animation(.easeIn(duration: 1.5))
        let removal = AnyTransition.opacity
        return .asymmetric(insertion: insertion, removal: removal)
    }
}
