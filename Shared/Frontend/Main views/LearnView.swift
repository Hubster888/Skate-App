//
//  LearnView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 09/12/2020.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct LearnView: View {
    
    @State private var tricksIsActive = false
    @State private var gamesIsActive = false
    @State private var planIsActive = false
    @State private var planIntroIsActive = false
    
    @State private var planStarted : Bool = false
    
    var width: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    var height: CGFloat {
        return UIScreen.main.bounds.height
    }

    init(){
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.0)]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.0)]
        navBarAppearance.barTintColor = UIColor(red: 0.13, green: 0.15, blue: 0.22, alpha: 1.0)
        
        UITabBar.appearance().backgroundColor = UIColor(red: 0.13, green: 0.15, blue: 0.22, alpha: 1.0)
        
        UITabBar.appearance().barTintColor = UIColor(red: 0.13, green: 0.15, blue: 0.22, alpha: 1.0)
    }
    
    var body: some View {
        NavigationView {
            ZStack{
                Color(red: 0.96, green: 0.96, blue: 0.96).edgesIgnoringSafeArea(.all)
                Rectangle()
                    .fill(Color(red: 0.13, green: 0.15, blue: 0.22))
                    .frame(width: 30, height: UIScreen.screenHeight)
                    .offset(x: width * -0.25)
                VStack{
                    if(planStarted){
                        NavigationLink(destination: PlanView(rootIsActive: self.$planIsActive), isActive: $planIsActive) {
                            VStack{
                                Text("PLAN")
                                    .font(.system(size: width * 0.1, weight: .bold, design: .monospaced))
                                    .foregroundColor(Color(red: 0.13, green: 0.15, blue: 0.22))
                                                
                                Text("Personalise your learning!")
                                    .font(.system(size: width * 0.03, weight: .bold, design: .default))
                                    .foregroundColor(Color(red: 0.28, green: 0.32, blue: 0.37))
                                    .frame(width: width * 0.4, alignment: .center)
                                    .multilineTextAlignment(.center)
                                    
                            }.frame(alignment: .trailing)
                        }.buttonStyle(LearnButtonEffectButtonStyle(image: Image("learnPlanButton"), action: { self.planIsActive.toggle()}))
                    }else{
                        NavigationLink(destination: PlanIntroView(rootIsActive: self.$planIntroIsActive), isActive: $planIntroIsActive) {
                            VStack{
                                Text("PLAN")
                                    .font(.system(size: width * 0.1, weight: .bold, design: .monospaced))
                                    .foregroundColor(Color(red: 0.13, green: 0.15, blue: 0.22))
                                                
                                Text("Personalise your learning!")
                                    .font(.system(size: width * 0.03, weight: .bold, design: .default))
                                    .foregroundColor(Color(red: 0.28, green: 0.32, blue: 0.37))
                                    .frame(width: width * 0.4, alignment: .center)
                                    .multilineTextAlignment(.center)
                                    
                            }.frame(alignment: .trailing)
                        }
                        .isDetailLink(false)
                        .buttonStyle(LearnButtonEffectButtonStyle(image: Image("learnPlanButton"), action: {self.planIntroIsActive.toggle()}))
                    }
                    
                            
                    NavigationLink(destination: TrickSelectView(), isActive: $tricksIsActive) {
                        VStack{
                            Text("TRICKS")
                                .font(.system(size: width * 0.1, weight: .bold, design: .monospaced))
                                .foregroundColor(Color(red: 0.13, green: 0.15, blue: 0.22))
                                                
                            Text("Find the tricks here!")
                                .font(.system(size: width * 0.03, weight: .bold, design: .default))
                                .foregroundColor(Color(red: 0.28, green: 0.32, blue: 0.37))
                                .frame(width: width * 0.4, alignment: .center)
                                .multilineTextAlignment(.center)
                            
                        }
                        .frame(alignment: .trailing)
                    }.buttonStyle(LearnButtonEffectButtonStyle(image: Image("learnTricksButton"), action: { self.tricksIsActive.toggle()}))
                    
                            
                    NavigationLink(destination: GameSelectView(), isActive: $gamesIsActive) {
                        VStack{
                            Text("GAMES")
                                .font(.system(size: width * 0.1, weight: .bold, design: .monospaced))
                                .foregroundColor(Color(red: 0.13, green: 0.15, blue: 0.22))
                                                
                            Text("Play skating games with friends or solo!")
                                .font(.system(size: width * 0.03, weight: .bold, design: .default))
                                .foregroundColor(Color(red: 0.28, green: 0.32, blue: 0.37))
                                .frame(width: width * 0.4, alignment: .center)
                                .multilineTextAlignment(.center)
                            
                        }.frame(alignment: .trailing)
                    }
                    .buttonStyle(LearnButtonEffectButtonStyle(image: Image("learnGamesButton"), action: { self.gamesIsActive.toggle()}))
                    .padding(.bottom, -height * 0.075)
                }.frame(width: width, height: height, alignment: .center)
            }
            .navigationBarTitle(Text("Learn"), displayMode: .inline)
            .navigationBarItems( trailing: NavigationLink(destination: settingsView()) {
                Image(systemName: "gear")
                    .foregroundColor(Color(red: 0.96, green: 0.96, blue: 0.96))
            })
            .onAppear() {
                if(Auth.auth().currentUser != nil){
                    CurrentUser.userHasPlan(){ res in
                        planStarted = res
                    }
                }
                UINavigationBar.appearance().barTintColor = UIColor(red: 0.13, green: 0.15, blue: 0.22, alpha: 1.0)
            }
        }
    }
}
;extension UIScreen{
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}
