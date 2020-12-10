//
//  LearnView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 09/12/2020.
//

import SwiftUI

struct LearnView: View {
    var body: some View {
        VStack{
            Text("Where To?")
                .font(.system(size: 65))
                .fontWeight(.bold)
                .font(.title)
                .foregroundColor(.black)
            Spacer()
            Button(action: {print("gg")}) {
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
            LearnView()
                .previewDevice("iPhone 8")
        }
    }
}
