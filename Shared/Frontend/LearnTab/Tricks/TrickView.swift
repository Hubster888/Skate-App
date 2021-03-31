//
//  TrickView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 22/12/2020.
//

import SwiftUI
import AVKit
import URLImage
//import FirebaseStorage

struct TrickView: View {
    
    //MARK: Variable Declerations
    //Data variables
    @EnvironmentObject private var trickViewModel : TrickViewModel
    
    //View variables
    var titleFrameHeight : CGFloat {
        return height * 0.125
    }
    var titleFrameOffset : CGFloat {
        return height * 0.2
    }
    var trickVariationWidth : CGFloat {
        return width * 0.1
    }
    var mediaWidth : CGFloat {
        return width * 0.8
    }
    var mediaHeight : CGFloat {
        return height * 0.25
    }
    let stepsOffset : CGFloat = -40
    let descriptionPadding : CGFloat = 50
    let titlePadding : CGFloat = 30
    let backgroundColor : Color = Color(red: 0.96, green: 0.96, blue: 0.96) // White
    let topImageBorderColor : Color = Color(red: 0.13, green: 0.15, blue: 0.22) // Black
    let topImageBorderWidth : CGFloat = 8
    let cornerRadius : CGFloat = 5
    var height: CGFloat = UIScreen.main.bounds.height
    var width: CGFloat = UIScreen.main.bounds.width
    
    //MARK: Body
    var body: some View {
        ScrollView(.vertical){
            VStack{
                
                //MARK: Header Of View
                ZStack{
                    if(trickViewModel.currentHeadImg != nil){ //FIXME: Images not loading if user not logged in
                        Image(uiImage: trickViewModel.currentHeadImg!)
                            .resizable()
                            .scaledToFill()
                            .frame(width: width, height: height/2, alignment: .center)
                            .overlay( // Adds a faded border around image
                                RoundedRectangle(cornerRadius: cornerRadius)
                                    .stroke(topImageBorderColor, lineWidth: topImageBorderWidth)
                                    .blur(radius: cornerRadius)
                            )
                    }else{
                        LoadingPlaceHolder(width: width, height: height/2, backgroundColor: backgroundColor)
                    }
                    Rectangle()
                        .fill(topImageBorderColor)
                        .frame(width: width, height: titleFrameHeight, alignment: .center)
                        .offset(y: titleFrameOffset)
                    HStack{
                        Text(trickViewModel.currentTrick?.name ?? "NO NAME")
                            .font(.system(.title, design: .rounded))
                            .foregroundColor(backgroundColor)
                            .padding(.leading, titlePadding)
                        Spacer()
                        
                        //MARK: Trick Variation Views
                        Group{
                            TrickVariationView(variationType: "R", isComplete: trickViewModel.currentCompletion[0],
                                               diameter: trickVariationWidth)
                                .buttonStyle(ScaleAnimationButtonEffect())
                                .onTapGesture {
                                    trickViewModel.setTaskComplete(sectionComplete: 1, trickId: trickViewModel.currentTrick!.id!)
                                }
                            TrickVariationView(variationType: "N", isComplete: trickViewModel.currentCompletion[1],
                                               diameter: trickVariationWidth)
                                .buttonStyle(ScaleAnimationButtonEffect())
                                .onTapGesture {
                                    trickViewModel.setTaskComplete(sectionComplete: 2, trickId: trickViewModel.currentTrick!.id!)
                                }
                            TrickVariationView(variationType: "S", isComplete: trickViewModel.currentCompletion[2],
                                               diameter: trickVariationWidth)
                                .buttonStyle(ScaleAnimationButtonEffect())
                                .onTapGesture {
                                    trickViewModel.setTaskComplete(sectionComplete: 3, trickId: trickViewModel.currentTrick!.id!)
                                }
                            TrickVariationView(variationType: "F", isComplete: trickViewModel.currentCompletion[3],
                                               diameter: trickVariationWidth)
                                .buttonStyle(ScaleAnimationButtonEffect())
                                .padding(.trailing, cornerRadius)
                                .onTapGesture {
                                    trickViewModel.setTaskComplete(sectionComplete: 4, trickId: trickViewModel.currentTrick!.id!)
                                }
                        }
                        .padding(.trailing, cornerRadius)
                        Spacer()
                    }
                    .offset(y: titleFrameOffset)
                }
                
                //MARK: Description
                ZStack{
                    backgroundColor.edgesIgnoringSafeArea(.all)
                    VStack{
                        Text(trickViewModel.tidyText(string: trickViewModel.currentTrick?.description ?? "No Description"))
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                            .font(.system( .body, design: .rounded))
                            .foregroundColor(topImageBorderColor)
                            .padding(EdgeInsets(top: titlePadding, leading: descriptionPadding, bottom: 0, trailing: descriptionPadding))
                            .multilineTextAlignment(.center)
                            .lineLimit(nil)
                            .lineSpacing(topImageBorderWidth)
                            .fixedSize(horizontal: false, vertical: true)
                        ForEach(trickViewModel.tipsToArray(string: trickViewModel.currentTrick?.description ?? "NO Steps", type: 1), id: \.self){ cell in
                            Text(cell)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                                .font(.system( .body, design: .rounded))
                                .foregroundColor(topImageBorderColor)
                                .padding(EdgeInsets(top: titlePadding, leading: descriptionPadding, bottom: 0, trailing: descriptionPadding))
                                .multilineTextAlignment(.center)
                                .lineLimit(nil)
                                .lineSpacing(topImageBorderWidth)
                                .fixedSize(horizontal: false, vertical: true)
                        }.offset(y: stepsOffset)
                        
                        //MARK: Video And Placment Image
                        if(trickViewModel.currentVid != nil){
                            VideoPlayer(player: AVPlayer(url: trickViewModel.currentVid!))
                                .frame(width: mediaWidth, height: mediaHeight, alignment: .center)
                                .padding()
                        }else{
                            Text("NO VIDEO") //TODO: Add place holder image
                        }
                        if(trickViewModel.currentFootImg != nil){
                            Image(uiImage: trickViewModel.currentFootImg!)
                                .resizable()
                                .scaledToFit()
                                .frame(width: mediaWidth, height: mediaHeight, alignment: .center)
                                .padding()
                        }else{
                            Text("NO IMAGE") //TODO: Add place holder image
                        }
                        
                        //MARK: Tips
                        Text("Tips")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(.largeTitle, design: .rounded))
                            .foregroundColor(topImageBorderColor)
                            .padding(EdgeInsets(top: titlePadding, leading: descriptionPadding, bottom: 0, trailing: 0))
                        ForEach(trickViewModel.tipsToArray(string: trickViewModel.currentTrick?.tips ?? "NO TIPS", type: 2), id: \.self){ tip in
                            Text(tip)
                                .font(.system( .body, design: .rounded))
                                .foregroundColor(topImageBorderColor)
                                .multilineTextAlignment(.center)
                                .lineLimit(nil)
                                .lineSpacing(topImageBorderWidth)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        .padding(EdgeInsets(top: cornerRadius, leading: descriptionPadding, bottom: titlePadding/2, trailing: descriptionPadding))
                        
                        //MARK: Sponsor Logo
                        if(trickViewModel.teamLogoImage != nil){
                            Image(uiImage: trickViewModel.teamLogoImage!)
                                .resizable()
                                .scaledToFit()
                                .frame(width: mediaWidth, height: mediaHeight, alignment: .center)
                                .padding()
                        }else{
                            Text("NO LOGO") //TODO: Add place holder image
                        }
                    }
                }
            }
        }
    }
}
