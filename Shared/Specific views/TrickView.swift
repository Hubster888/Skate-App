//
//  TrickView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 22/12/2020.
//

import SwiftUI
import AVKit

struct TrickView: View {
    let trickId : Int
    let trickName : String = ""
    let trickContent : String = ""
    let footPlacmentDiagram : String = ""
    let tips : String = ""
    let video : String = ""
    
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
    
    var body: some View {
        ScrollView(.vertical){
            VStack{
                ZStack{
                    Image("learnTricksButton")
                        .resizable()
                        .scaledToFill()
                        .frame(width: width, height: height * 0.5, alignment: .center)
                    Rectangle()
                        .fill(Color(red: 0.13, green: 0.15, blue: 0.22))
                        .frame(width: width, height: height * 0.125, alignment: .center)
                        .offset(y: height * 0.2)
                        
                    HStack{
                        Text(trickName)
                            .font(.system(.title, design: .rounded))
                            .foregroundColor(Color(red: 0.96, green: 0.96, blue: 0.96))
                            .padding(.leading, 15)
                            
                        Spacer()
                        
                        Group{
                            TrickVariationView(variationType: "R", isComplete: false, diameter: width * 0.1)
                            
                            TrickVariationView(variationType: "N", isComplete: false, diameter: width * 0.1)
                            
                            TrickVariationView(variationType: "S", isComplete: false, diameter: width * 0.1)
                            
                            TrickVariationView(variationType: "F", isComplete: false, diameter: width * 0.1)
                                .padding(.trailing)
                        }.padding(.trailing, 1)
                        
                    }
                    .offset(y: height * 0.2)
                }
                
                Text("Description")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(.largeTitle, design: .rounded))
                    .foregroundColor(Color(red: 0.13, green: 0.15, blue: 0.22))
                    .padding(.leading, 50)
                    .padding(.top, 30)
                Text(trickContent)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .font(.system(size: 18, design: .rounded))
                    .foregroundColor(Color(red: 0.13, green: 0.15, blue: 0.22))
                    .padding(.leading, 50)
                    .padding(.top, 5)
                    .padding(.trailing, 50)
                    .multilineTextAlignment(.leading)
                    .lineLimit(nil)
                Image(footPlacmentDiagram)
                    .resizable()
                    .scaledToFit()
                    .frame(width: width * 0.8, height: height * 0.25, alignment: .center)
                    .padding()
                VideoPlayer(player: AVPlayer(url:  Bundle.main.url(forResource: video, withExtension: "mp4")!))
                    .frame(width: width * 0.8, height: height * 0.25, alignment: .center)
                    .padding()
                Text("Tips")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(.largeTitle, design: .rounded))
                    .foregroundColor(Color(red: 0.13, green: 0.15, blue: 0.22))
                    .padding(.leading, 50)
                    .padding(.top, 30)
                Text(tips)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .font(.system(size: 18, design: .rounded))
                    .foregroundColor(Color(red: 0.13, green: 0.15, blue: 0.22))
                    .padding(.leading, 50)
                    .padding(.top, 5)
                    .padding(.trailing, 50)
                    .padding(.bottom, 10)
                    .multilineTextAlignment(.leading)
                    .lineLimit(nil)
            }
        }
    }
}

struct TrickView_Previews: PreviewProvider {
    static var previews: some View {
        TrickView(trickId: 1)
    }
}
