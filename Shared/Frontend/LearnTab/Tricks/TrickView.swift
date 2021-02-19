//
//  TrickView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 22/12/2020.
//

import SwiftUI
import AVKit
import URLImage
import FirebaseStorage
import Combine
import CombineFirebase

struct TrickView: View {
    @EnvironmentObject private var trickViewModel : TrickViewModel
    
    var height: CGFloat = UIScreen.main.bounds.height
    
    var width: CGFloat = UIScreen.main.bounds.width
    
    var body: some View {
            ScrollView(.vertical){
                    VStack{
                        ZStack{
                            if(trickViewModel.currentHeadImg != nil){
                                Image(uiImage: trickViewModel.currentHeadImg!)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: width, height: height * 0.5, alignment: .center)
                                    .overlay(
                                            RoundedRectangle(cornerRadius: 5)
                                                .stroke(Color(red: 0.13, green: 0.15, blue: 0.22), lineWidth: 8)
                                                .blur(radius: 4)
                                        )
                            }else{
                                Text("NO IMAGE")
                            }
                            Rectangle()
                                .fill(Color(red: 0.13, green: 0.15, blue: 0.22))
                                .frame(width: width, height: height * 0.125, alignment: .center)
                                .offset(y: height * 0.2)
                                
                            HStack{
                                Text(trickViewModel.currentTrick?.name ?? "NO NAME")
                                    .font(.system(.title, design: .rounded))
                                    .foregroundColor(Color(red: 0.96, green: 0.96, blue: 0.96))
                                    .padding(.leading, 30)
                                    
                                Spacer()
                                Group{
                                    TrickVariationView(variationType: "R", isComplete: trickViewModel.currentCompletion[0], diameter: width * 0.1)
                                        .onTapGesture {
                                            trickViewModel.setTaskComplete(sectionComplete: 1, trickId: trickViewModel.currentTrick!.id!)
                                        }
                                        .buttonStyle(ScaleAnimationButtonEffect())
                                    
                                    TrickVariationView(variationType: "N", isComplete: trickViewModel.currentCompletion[1], diameter: width * 0.1)
                                        .onTapGesture {
                                            trickViewModel.setTaskComplete(sectionComplete: 2, trickId: trickViewModel.currentTrick!.id!)
                                        }
                                        .buttonStyle(ScaleAnimationButtonEffect())
                                    
                                    TrickVariationView(variationType: "S", isComplete: trickViewModel.currentCompletion[2], diameter: width * 0.1)
                                        .onTapGesture {
                                            trickViewModel.setTaskComplete(sectionComplete: 3, trickId: trickViewModel.currentTrick!.id!)
                                        }
                                        .buttonStyle(ScaleAnimationButtonEffect())
                                    
                                    TrickVariationView(variationType: "F", isComplete: trickViewModel.currentCompletion[3], diameter: width * 0.1)
                                        .onTapGesture {
                                            trickViewModel.setTaskComplete(sectionComplete: 4, trickId: trickViewModel.currentTrick!.id!)
                                        }
                                        .buttonStyle(ScaleAnimationButtonEffect())
                                        .padding(.trailing, 5)
                                }.padding(.trailing, 5)
                                Spacer()
                                
                            }
                            .offset(y: height * 0.2)
                        }
                        ZStack{
                            Color(red: 0.96, green: 0.96, blue: 0.96).edgesIgnoringSafeArea(.all)
                            VStack{
                                Text(trickViewModel.tidyText(string: trickViewModel.currentTrick?.description ?? "No Description"))
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                                    .font(.system( .body, design: .rounded))
                                    .foregroundColor(Color(red: 0.13, green: 0.15, blue: 0.22))
                                    .padding(.leading, 50)
                                    .padding(.top, 30)
                                    .padding(.trailing, 50)
                                    .multilineTextAlignment(.center)
                                    .lineLimit(nil)
                                    .lineSpacing(8)
                                    .fixedSize(horizontal: false, vertical: true)
                                ForEach(trickViewModel.tipsToArray(string: trickViewModel.currentTrick?.description ?? "NO description", type: 1), id: \.self){ cell in
                                    Text(cell)
                                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                                        .font(.system( .body, design: .rounded))
                                        .foregroundColor(Color(red: 0.13, green: 0.15, blue: 0.22))
                                        .padding(.leading, 50)
                                        .padding(.top, 30)
                                        .padding(.trailing, 50)
                                        .multilineTextAlignment(.center)
                                        .lineLimit(nil)
                                        .lineSpacing(8)
                                        .fixedSize(horizontal: false, vertical: true)
                                }.offset(y: -40)
                                if(trickViewModel.currentVid != nil){
                                    VideoPlayer(player: AVPlayer(url: trickViewModel.currentVid!))
                                        .frame(width: width * 0.8, height: height * 0.25, alignment: .center)
                                        .padding()
                                }else{
                                    Text("NO VIDEO")
                                }
                                if(trickViewModel.currentFootImg != nil){
                                    Image(uiImage: trickViewModel.currentFootImg!)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: width * 0.8, height: height * 0.25, alignment: .center)
                                        .padding()
                                }else{
                                    Text("NO IMAGE")
                                }
                                Text("Tips")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.system(.largeTitle, design: .rounded))
                                    .foregroundColor(Color(red: 0.13, green: 0.15, blue: 0.22))
                                    .padding(.leading, 50)
                                    .padding(.top, 20)
                                
                                ForEach(trickViewModel.tipsToArray(string: trickViewModel.currentTrick?.tips ?? "NO TIPS", type: 2), id: \.self){ ar in
                                    Text(ar)
                                        .font(.system(size: 18, design: .rounded))
                                        .foregroundColor(Color(red: 0.13, green: 0.15, blue: 0.22))
                                        .multilineTextAlignment(.center)
                                        .lineLimit(nil)
                                        .lineSpacing(8)
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                                .padding(.leading, 50)
                                .padding(.top, 5)
                                .padding(.trailing, 50)
                                .padding(.bottom, 15)
                                if(trickViewModel.teamLogoImage != nil){
                                    Image(uiImage: trickViewModel.teamLogoImage!)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: width * 0.8, height: height * 0.25, alignment: .center)
                                        .padding()
                                }else{
                                    Text("NO LOGO")
                                }
                            }
                        }
                    }
            }
        }
}


