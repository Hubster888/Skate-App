//
//  gameSelectView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 14/01/2021.
//

import SwiftUI

struct GameSelectView: View {
    
    var width: CGFloat {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return UIScreen.main.bounds.width
        } else {
            return UIScreen.main.bounds.width
        }
    }
    
    var height: CGFloat {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return UIScreen.main.bounds.height
        } else {
            return UIScreen.main.bounds.height
        }
    }
    
    var body: some View {
        ZStack{
            Color(red: 0.96, green: 0.96, blue: 0.96).edgesIgnoringSafeArea(.all)
            List{
                Spacer()
                GameListElm(name: "SKATE", capabilities: "Online, Local", width: width, height: height * 0.15)
                Spacer()
                GameListElm(name: "SKATE", capabilities: "Online, Local", width: width, height: height * 0.15)
                Spacer()
                GameListElm(name: "SKATE", capabilities: "Online, Local", width: width, height: height * 0.15)
                Spacer()
                GameListElm(name: "SKATE", capabilities: "Online, Local", width: width, height: height * 0.15)
                Spacer()
            }
        }
    }
}

struct gameSelectView_Previews: PreviewProvider {
    static var previews: some View {
        GameSelectView()
    }
}
