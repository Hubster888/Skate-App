//
//  LearnView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 09/12/2020.
//

import SwiftUI

struct LearnView: View {
    
    @State private var isActive = false
    
    var width: CGFloat {
            if UIDevice.current.userInterfaceIdiom == .phone {
                return UIScreen.main.bounds.height * 0.165
            } else {
                return UIScreen.main.bounds.height * 0.4
            }
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
                    .offset(x: -100, y: 0)
                VStack{
                    
                        HStack{
                            Image("learnPlanButton")
                                .resizable()
                                .clipShape(Circle())
                                .shadow(radius: 10)
                                .overlay(Circle().stroke(Color(red: 0.95, green: 0.32, blue: 0.34), lineWidth: 5))
                                .frame(width: width, height: width)
                                
                            VStack{
                                Text("Plan")
                                    .font(.system(.largeTitle, design: .rounded))
                                    .foregroundColor(Color(red: 0.13, green: 0.15, blue: 0.22))
                                Text("Personalise your learning!")
                                    .font(.system(.subheadline, design: .rounded))
                                    .foregroundColor(Color(red: 0.28, green: 0.32, blue: 0.37))
                            }
                        }
                        .padding(.bottom ,50)
                        .padding(.top, 100)
                    
                    NavigationLink(destination: TrickSelectView(), isActive: $isActive) {
                                    VStack{
                                        Text("Tricks")
                                            .font(.system(.largeTitle, design: .rounded))
                                            .foregroundColor(Color(red: 0.13, green: 0.15, blue: 0.22))
                                        
                                        Text("Find the tricks here!")
                                            .font(.system(.subheadline, design: .rounded))
                                            .foregroundColor(Color(red: 0.28, green: 0.32, blue: 0.37))
                                    }
                                }.buttonStyle(LearnButtonEffectButtonStyle(image: Image("learnTricksButton"), action: {
                                    self.isActive.toggle()
                                }))
                    
                    HStack{
                        Image("learnGamesButton")
                            .resizable()
                            .clipShape(Circle())
                            .shadow(radius: 10)
                            .overlay(Circle().stroke(Color(red: 0.95, green: 0.32, blue: 0.34), lineWidth: 5))
                            .frame(width: width, height: width)
                            
                        VStack{
                            Text("Games")
                                .font(.system(.largeTitle, design: .rounded))
                                .foregroundColor(Color(red: 0.13, green: 0.15, blue: 0.22))
                            Text("Personalise your learning!")
                                .font(.system(.subheadline, design: .rounded))
                                .foregroundColor(Color(red: 0.28, green: 0.32, blue: 0.37))
                        }
                    }
                    .padding(.bottom, 100)
                }
            }
            .navigationBarTitle(Text("Learn"), displayMode: .inline)
            .navigationBarItems( trailing: NavigationLink(destination: settingsView()) {
                Image(systemName: "gear")
                    .foregroundColor(Color(red: 0.96, green: 0.96, blue: 0.96))
            })
            .onAppear() {
                UINavigationBar.appearance().barTintColor = UIColor(red: 0.13, green: 0.15, blue: 0.22, alpha: 1.0)
            }
        }
    }
};extension UIScreen{
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}

struct LearnView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LearnView()
                .previewDevice("iPhone 12 Pro Max")
        }
    }
}
