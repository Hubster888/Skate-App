//
//  TrickView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 22/12/2020.
//

import SwiftUI
import AVKit
import URLImage

struct TrickView: View {
    let trickId : Int
    @State var trickName : String = ""
    @State var trickContent : String = ""
    @State var footPlacmentDiagram : String = ""
    @State var tips : String = ""
    @State var video : String = ""
    @State var loaded : Bool = false
    @State var trickHead : String = ""
    
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
                if(!loaded){
                    Text("Empty").onAppear(perform: {
                        TrickLoader().getTrick(trickId: trickId){ result in
                            switch result{
                            case .success(let trick):
                                assignValues(trick: trick)
                            case .failure(let error):
                                print(error)
                            }
                        }
                    })
                }else{
                    VStack{
                        ZStack{
                            URLImage(url: URL(string: "http://192.168.0.13/imgAssets/" + trickHead)!, content: {
                                image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: width, height: height * 0.5, alignment: .center)
                                    .overlay(
                                            RoundedRectangle(cornerRadius: 5)
                                                .stroke(Color(red: 0.13, green: 0.15, blue: 0.22), lineWidth: 8)
                                                .blur(radius: 4)
                                        )
                            })
                            Rectangle()
                                .fill(Color(red: 0.13, green: 0.15, blue: 0.22))
                                .frame(width: width, height: height * 0.125, alignment: .center)
                                .offset(y: height * 0.2)
                                
                            HStack{
                                Text(trickName)
                                    .font(.system(.title, design: .rounded))
                                    .foregroundColor(Color(red: 0.96, green: 0.96, blue: 0.96))
                                    .padding(.leading, 30)
                                    
                                Spacer()
                                Group{
                                    TrickVariationView(variationType: "R", isComplete: false, diameter: width * 0.1)
                                    
                                    TrickVariationView(variationType: "N", isComplete: false, diameter: width * 0.1)
                                    
                                    TrickVariationView(variationType: "S", isComplete: false, diameter: width * 0.1)
                                    
                                    TrickVariationView(variationType: "F", isComplete: false, diameter: width * 0.1)
                                        .padding(.trailing, 5)
                                }.padding(.trailing, 5)
                                Spacer()
                                
                            }
                            .offset(y: height * 0.2)
                        }
                        Text(trickContent)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                            .font(.system( .body, design: .rounded))
                            .foregroundColor(Color(red: 0.13, green: 0.15, blue: 0.22))
                            .padding(.leading, 50)
                            .padding(.top, 30)
                            .padding(.trailing, 50)
                            .multilineTextAlignment(.leading)
                            .lineLimit(nil)
                            .lineSpacing(8)
                            .fixedSize(horizontal: false, vertical: true)
                        Spacer()
                        URLImage(url: URL(string: "http://192.168.0.13/imgAssets/" + footPlacmentDiagram)!, content: {
                            image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: width * 0.8, height: height * 0.25, alignment: .center)
                                .padding()
                        })
                        VideoPlayer(player: AVPlayer(url: URL(string: "http://192.168.0.13/vidAssets/" + video)!))
                            .frame(width: width * 0.8, height: height * 0.25, alignment: .center)
                            .padding()
                        Text("Tips")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(.largeTitle, design: .rounded))
                            .foregroundColor(Color(red: 0.13, green: 0.15, blue: 0.22))
                            .padding(.leading, 50)
                            .padding(.top, 20)
                        Text(tips)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                            .font(.system(size: 18, design: .rounded))
                            .foregroundColor(Color(red: 0.13, green: 0.15, blue: 0.22))
                            .padding(.leading, 50)
                            .padding(.top, 5)
                            .padding(.trailing, 50)
                            .padding(.bottom, 30)
                            .multilineTextAlignment(.leading)
                            .lineLimit(nil)
                            .lineSpacing(8)
                            .fixedSize(horizontal: false, vertical: true)
                    }.onAppear(perform: {
                        TrickLoader().getTrick(trickId: trickId){ result in
                            switch result{
                            case .success(let trick):
                                assignValues(trick: trick)
                            case .failure(let error):
                                print(error)
                            }
                        }
                    })
            }
        }
    }
    
    func assignValues(trick: Trick){
        
        trickName = trick.getTrickName()

        trickContent = trick.getTrickDescription().replacingOccurrences(of: "--n--", with: "\n", options: .literal, range: nil)
        
        footPlacmentDiagram = trick.getFootPlacmentImg()
        
        tips = trick.getTrickTips()
        
        video = trick.getTrickVideo()
        
        trickHead = trick.getTrickHeadImg()
        
        loaded = true
    }
}

struct TrickView_Previews: PreviewProvider {
    static var previews: some View {
        TrickView(trickId: 1)
    }
}
