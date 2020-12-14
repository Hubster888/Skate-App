//
//  LearnView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 09/12/2020.
//

import SwiftUI

struct LearnView: View {
    var body: some View {
        NavigationView {
            ZStack{
                Color(red: 0.96, green: 0.96, blue: 0.96).edgesIgnoringSafeArea(.all)
                VStack{
                    Text("Where To?")
                        .font(.system(size: 65))
                        .fontWeight(.bold)
                        .font(.title)
                        .foregroundColor(.black)
                    Spacer()
                    NavigationLink(destination: PlanView()) {
                        ZStack (alignment: .bottomLeading){
                            Image("learnPlanButton")
                                .resizable()
                                .cornerRadius(10)
                                .frame(width: UIScreen.screenWidth * 0.75, height: UIScreen.screenHeight * 0.2)
                                .shadow(color: .black, radius: 4, x: 3, y: 3)
                                
                            Rectangle()
                                .fill(Color.black)
                                .frame(width: UIScreen.screenWidth * 0.75, height: (UIScreen.screenHeight * 0.2) * 0.3)
                                .cornerRadius(10)
                            
                            Text("Plan")
                                .font(.system(size: 40))
                                .font(.title)
                                .fontWeight(.heavy)
                                .foregroundColor(.white)
                                .offset(x: 20, y: -(UIScreen.screenHeight * 0.2) * 0.17)
                        }
                    }
                    Spacer()
                    
                    Button(action: {print("gg")}) {
                        ZStack (alignment: .bottomLeading){
                            Image("learnTricksButton")
                                .resizable()
                                .cornerRadius(10)
                                .frame(width: UIScreen.screenWidth * 0.75, height: UIScreen.screenHeight * 0.2)
                                .shadow(color: .black, radius: 4, x: 3, y: 3)
                                
                            Rectangle()
                                .fill(Color.black)
                                .frame(width: UIScreen.screenWidth * 0.75, height: (UIScreen.screenHeight * 0.2) * 0.3)
                                .cornerRadius(10)
                            
                            Text("Tricks")
                                .font(.system(size: 40))
                                .font(.title)
                                .fontWeight(.heavy)
                                .foregroundColor(.white)
                                .offset(x: 20, y: -(UIScreen.screenHeight * 0.2) * 0.17)
                        }
                    }
                    Spacer()
                    
                    Button(action: {print("gg")}) {
                        ZStack (alignment: .bottomLeading){
                            Image("learnGamesButton")
                                .resizable()
                                .cornerRadius(10)
                                .frame(width: UIScreen.screenWidth * 0.75, height: UIScreen.screenHeight * 0.2)
                                .shadow(color: .black, radius: 4, x: 3, y: 3)
                                
                            Rectangle()
                                .fill(Color.black)
                                .frame(width: UIScreen.screenWidth * 0.75, height: (UIScreen.screenHeight * 0.2) * 0.3)
                                .cornerRadius(10)
                            
                            Text("Games")
                                .font(.system(size: 40))
                                .font(.title)
                                .fontWeight(.heavy)
                                .foregroundColor(.white)
                                .offset(x: 20, y: -(UIScreen.screenHeight * 0.2) * 0.17)
                        }
                    }
                    Spacer()
                }
            }
            
            .navigationBarTitle(Text("Learn"), displayMode: .inline)
            .navigationBarItems( trailing: NavigationLink(destination: settingsView()) {
                Image(systemName: "gear")
                    .resizable()
                    .imageScale(.large)
            })
            .onAppear() {
                UINavigationBar.appearance().barTintColor = UIColor(red: 0.95, green: 0.32, blue: 0.34, alpha: 1.0)
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
