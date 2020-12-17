//
//  LearnView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 09/12/2020.
//

import SwiftUI

struct LearnView: View {

    init(){
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.0)]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.0)]
        navBarAppearance.barTintColor = UIColor(red: 0.13, green: 0.15, blue: 0.22, alpha: 1.0)
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
                    Spacer()
                    
                    Image("learnPlanButton")
                        .resizable()
                        .frame(width: 170, height: 170)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                        .overlay(Circle().stroke(Color(red: 0.13, green: 0.15, blue: 0.22), lineWidth: 8))
                        .offset(x: -80)
                    
                    Spacer()
                    
                    Image("learnTricksButton")
                        .resizable()
                        .frame(width: 170, height: 170)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                        .overlay(Circle().stroke(Color(red: 0.13, green: 0.15, blue: 0.22), lineWidth: 8))
                        .offset(x: -80)
                    
                    Spacer()
                    
                    Image("learnGamesButton")
                        .resizable()
                        .frame(width: 170, height: 170)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                        .overlay(Circle().stroke(Color(red: 0.13, green: 0.15, blue: 0.22), lineWidth: 8))
                        .offset(x: -80)
                    
                    Spacer()
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
