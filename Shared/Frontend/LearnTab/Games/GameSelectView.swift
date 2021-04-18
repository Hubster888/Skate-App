//
//  gameSelectView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 14/01/2021.
//

import SwiftUI

struct GameSelectView: View {
    
    //MARK: Variable Declerations
    //View variables
    var cellHeight : CGFloat {
        return height * 0.15
    }
    var width: CGFloat = UIScreen.main.bounds.width
    var height: CGFloat = UIScreen.main.bounds.height
    let backgroundColor : Color = Color(red: 0.96, green: 0.96, blue: 0.96)
    
    //MARK: Body
    var body: some View {
        ZStack{
            backgroundColor.edgesIgnoringSafeArea(.all)
            VStack{
                Spacer()
                Text("Pick One:")
                    .font(.largeTitle)
                    .bold()
                Spacer()
                HStack{
                    Spacer()
                    NavigationLink(destination: SkateGameView()){
                        GameListElm(name: "SKATE Game", avaliable: true)
                    }.buttonStyle(ScaleAnimationButtonEffect())
                    Spacer()
                    Button(action: {}){
                        GameListElm(name: "Skate Or Dice", avaliable: false)
                    }.buttonStyle(ScaleAnimationButtonEffect())
                    Spacer()
                }
                Spacer()
                HStack{
                    Spacer()
                    Button(action: {}){
                        GameListElm(name: "Skate Roulette", avaliable: false)
                    }.buttonStyle(ScaleAnimationButtonEffect())
                    Spacer()
                    Button(action: {}){
                        GameListElm(name: "First Try Day", avaliable: false)
                    }.buttonStyle(ScaleAnimationButtonEffect())
                    Spacer()
                }
                Spacer()
            }
        }
    }
}
