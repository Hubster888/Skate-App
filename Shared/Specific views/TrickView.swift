//
//  TrickView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 22/12/2020.
//

import SwiftUI
import AVKit

struct TrickView: View {
    let trickName : String
    let trickContent : String
    let footPlacmentDiagram : String
    let tips : String
    let video : String
    let imageList : [String]
    
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
        ScrollView{
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
                    .padding(.leading, 25)
                    .padding(.top, 30)
                Text(trickContent)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .font(.system(size: 25, design: .rounded))
                    .foregroundColor(Color(red: 0.13, green: 0.15, blue: 0.22))
                    .padding(.leading, 25)
                    .padding(.top, 5)
                    .padding(.trailing, 25)
                    .multilineTextAlignment(.leading)
                    .lineLimit(nil)
                Image(footPlacmentDiagram)
                    .resizable()
                    .scaledToFill()
                    .frame(width: width * 0.9, height: height * 0.25, alignment: .center)
                    .padding()
                VideoPlayer(player: AVPlayer(url:  Bundle.main.url(forResource: video, withExtension: "mp4")!))
                    .padding()
                Text("Tips")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(.largeTitle, design: .rounded))
                    .foregroundColor(Color(red: 0.13, green: 0.15, blue: 0.22))
                    .padding(.leading, 25)
                    .padding(.top, 30)
                Text(tips)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .font(.system(size: 25, design: .rounded))
                    .foregroundColor(Color(red: 0.13, green: 0.15, blue: 0.22))
                    .padding(.leading, 25)
                    .padding(.top, 5)
                    .padding(.trailing, 25)
                    .multilineTextAlignment(.leading)
                    .lineLimit(nil)
                Image(imageList[0])
                Image(imageList[1])
            }
        }
    }
}

struct TrickView_Previews: PreviewProvider {
    static var previews: some View {
        TrickView(trickName: "Very vey long trick name",
                  trickContent: """
One advanced diverted domestic sex repeated bringing you old. Possible procured her trifling laughter thoughts property she met way. Companions shy had solicitude favourable own. Which could saw guest man now heard but. Lasted my coming uneasy marked so should. Gravity letters it amongst herself dearest an windows by. Wooded ladies she basket season age her uneasy saw. Discourse unwilling am no described dejection incommode no listening of. Before nature his parish boy.
""", footPlacmentDiagram: "ShuvItFeet", tips: """
            - Weight distribution is very important especially when moving, if your board moves too far away from you this may be the reason. Aim for about a 50/50 weight distribution on your feet.
            - A good way to get started is to practice flicking the board while not standing on it.
            - If you're not confident and fail to commit, try building your confidence by simply jumping up and down on the board (hippy jump).
            """, video: "videoplayback", imageList: ["learnGamesButton","learnGamesButton"]
        )
    }
}
