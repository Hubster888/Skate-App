//
//  PlanView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 14/12/2020.
//

import SwiftUI

struct TrickSelectView: View {
    @State private var searchText = ""
    @State private var favoriteColor = 0
    
    let content = """
The "shove it" is the lesser-known cousin trick to the "pop shove it." The "shove it" does the same motion as the "pop shove it" without the pop, or the air you get from an "ollie." The "shove it" is an old school, freestyle trick that is sure to impress and involves using your feet to rotate the skateboard 180 degrees (while you hop into the air and land on the board again going the same direction). It is also fun and simple because you do not need to know how to "ollie."
Steps:
1) Place your feet as seen on the foot placement diagram.
2) Do a little hop.
3) As your feet relive a little weight from the board, flick your back foot backwards to spin the board.
4) The board should be flicked hard enough to spin 180 degrees.
5) Try landing with your feet in the same or similar position to how they started.
"""
    let tips = """
            - Weight distribution is very important especially when moving, if your board moves too far away from you this may be the reason. Aim for about a 50/50 weight distribution on your feet.
            - A good way to get started is to practice flicking the board while not standing on it.
            - If you're not confident and fail to commit, try building your confidence by simply jumping up and down on the board (hippy jump).
            """
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(red: 0.95, green: 0.32, blue: 0.34, alpha: 1.0)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.0)], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(red: 0.13, green: 0.15, blue: 0.22, alpha: 1.0)], for: .normal)
    }
    
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
        
        ZStack{
            Rectangle()
                .fill(Color(red: 0.96, green: 0.96, blue: 0.96))
                .frame(width: width, height: height, alignment: .center)
            VStack{
                //Search bar
                ZStack{
                    Rectangle()
                        .fill(Color(red: 66/255, green: 70/255, blue: 84/255))
                        .frame(width: width, height: height * 0.1)
                        .padding(.top, height * 0.075)
                    HStack {
                        HStack {
                            Image(systemName: "magnifyingglass")

                            TextField("search", text: $searchText, onEditingChanged: { isEditing in
                                //self.showCancelButton = true
                            }, onCommit: {
                                print("onCommit")
                            }).foregroundColor(.primary)

                            Button(action: {
                                self.searchText = ""
                            }) {
                                Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                            }
                        }
                        .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                        .foregroundColor(Color(red: 0.95, green: 0.32, blue: 0.34))
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10)
                        .frame(width: width * 0.9, height: height * 0.05, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)

                        /*if showCancelButton()  {
                            Button("Cancel") {
                                    UIApplication.shared.endEditing(true) // this must be placed before the other commands here
                                    self.searchText = ""
                                    self.showCancelButton = false
                            }
                            .foregroundColor(Color(.systemBlue))
                        }*/
                    }.padding(.top, height * 0.09)
                    //.navigationBarHidden(showCancelButton) // .animation(.default)
                    // animation does not work properly
                }
                
                //Segment control
                    Picker(selection: $favoriteColor, label: Text("Completed trick?")) {
                        Text("Not even close").tag(0)
                        Text("Almost there").tag(1)
                        Text("Nailed it").tag(2)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: width * 0.9, height: height * 0.05)
                    .padding(.bottom, height * 0.01)
                
                
                //Scroll view
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ZStack{
                            Rectangle()
                                .fill(Color(red: 66/255, green: 70/255, blue: 84/255))
                            ScrollView(.vertical){
                                VStack{
                                    Text("Begginer")
                                        .font(.system(size: 35, weight: .bold, design: .rounded))
                                        .foregroundColor(Color(red: 0.96, green: 0.96, blue: 0.96))
                                    Spacer()
                                    Group{
                                        NavigationLink(destination: TrickView(trickName: "Shuv It", trickContent: content, footPlacmentDiagram: "ShuvItFeet", tips: tips, video: "videoplayback")){
                                            TrickRowView(name: "Shuv It", trickType: "Flip Trick", trickComplete: [false,false,false,false], width: width * 0.78, height: height * 0.1)
                                                .padding(.bottom, 10)
                                        }
                                        
                                        TrickRowView(name: "Trick 1", trickType: "Trick type", trickComplete: [false,false,false,false], width: width * 0.78, height: height * 0.1)
                                            .padding(.bottom, 10)
                                        TrickRowView(name: "Trick 1", trickType: "Trick type", trickComplete: [false,false,false,false], width: width * 0.78, height: height * 0.1)
                                            .padding(.bottom, 10)
                                        TrickRowView(name: "Trick 1", trickType: "Trick type", trickComplete: [false,false,false,false], width: width * 0.78, height: height * 0.1)
                                            .padding(.bottom, 10)
                                        TrickRowView(name: "Trick 1", trickType: "Trick type", trickComplete: [false,false,false,false], width: width * 0.78, height: height * 0.1)
                                            .padding(.bottom, 10)
                                        TrickRowView(name: "Trick 1", trickType: "Trick type", trickComplete: [false,false,false,false], width: width * 0.78, height: height * 0.1)
                                            .padding(.bottom, 10)
                                        TrickRowView(name: "Trick 1", trickType: "Trick type", trickComplete: [false,false,false,false], width: width * 0.78, height: height * 0.1)
                                            .padding(.bottom, 10)
                                        TrickRowView(name: "Trick 1", trickType: "Trick type", trickComplete: [false,false,false,false], width: width * 0.78, height: height * 0.1)
                                            .padding(.bottom, 10)
                                        TrickRowView(name: "Trick 1", trickType: "Trick type", trickComplete: [false,false,false,false], width: width * 0.78, height: height * 0.1)
                                            .padding(.bottom, 10)
                                        TrickRowView(name: "Trick 1", trickType: "Trick type", trickComplete: [false,false,false,false], width: width * 0.78, height: height * 0.1)
                                            .padding(.bottom, 10)
                                    }
                                }
                            }
                            
                        }.frame(width: width * 0.8, height: height * 0.6, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                        ZStack{
                            Rectangle()
                                .fill(Color(red: 66/255, green: 70/255, blue: 84/255))
                            
                            ScrollView(.vertical){
                                VStack{
                                    Text("Intermidiate")
                                        .font(.system(size: 35, weight: .bold, design: .rounded))
                                        .foregroundColor(Color(red: 0.96, green: 0.96, blue: 0.96))
                                    Spacer()
                                    Group{
                                        TrickRowView(name: "Trick 1", trickType: "Trick type", trickComplete: [false,false,false,false], width: width * 0.78, height: height * 0.1)
                                            .padding(.bottom, 10)
                                        TrickRowView(name: "Trick 1", trickType: "Trick type", trickComplete: [false,false,false,false], width: width * 0.78, height: height * 0.1)
                                            .padding(.bottom, 10)
                                        TrickRowView(name: "Trick 1", trickType: "Trick type", trickComplete: [false,false,false,false], width: width * 0.78, height: height * 0.1)
                                            .padding(.bottom, 10)
                                        TrickRowView(name: "Trick 1", trickType: "Trick type", trickComplete: [false,false,false,false], width: width * 0.78, height: height * 0.1)
                                            .padding(.bottom, 10)
                                        TrickRowView(name: "Trick 1", trickType: "Trick type", trickComplete: [false,false,false,false], width: width * 0.78, height: height * 0.1)
                                            .padding(.bottom, 10)
                                        TrickRowView(name: "Trick 1", trickType: "Trick type", trickComplete: [false,false,false,false], width: width * 0.78, height: height * 0.1)
                                            .padding(.bottom, 10)
                                        TrickRowView(name: "Trick 1", trickType: "Trick type", trickComplete: [false,false,false,false], width: width * 0.78, height: height * 0.1)
                                            .padding(.bottom, 10)
                                        TrickRowView(name: "Trick 1", trickType: "Trick type", trickComplete: [false,false,false,false], width: width * 0.78, height: height * 0.1)
                                            .padding(.bottom, 10)
                                        TrickRowView(name: "Trick 1", trickType: "Trick type", trickComplete: [false,false,false,false], width: width * 0.78, height: height * 0.1)
                                            .padding(.bottom, 10)
                                        TrickRowView(name: "Trick 1", trickType: "Trick type", trickComplete: [false,false,false,false], width: width * 0.78, height: height * 0.1)
                                            .padding(.bottom, 10)
                                    }
                                }
                            }
                        }.frame(width: width * 0.8, height: height * 0.6, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                        ZStack{
                            Rectangle()
                                .fill(Color(red: 66/255, green: 70/255, blue: 84/255))
                            
                            ScrollView(.vertical){
                                VStack{
                                    Text("Pro")
                                        .font(.system(size: 35, weight: .bold, design: .rounded))
                                        .foregroundColor(Color(red: 0.96, green: 0.96, blue: 0.96))
                                    Spacer()
                                    Group{
                                        TrickRowView(name: "Trick 1", trickType: "Trick type", trickComplete: [false,false,false,false], width: width * 0.78, height: height * 0.1)
                                            .padding(.bottom, 10)
                                        TrickRowView(name: "Trick 1", trickType: "Trick type", trickComplete: [false,false,false,false], width: width * 0.78, height: height * 0.1)
                                            .padding(.bottom, 10)
                                        TrickRowView(name: "Trick 1", trickType: "Trick type", trickComplete: [false,false,false,false], width: width * 0.78, height: height * 0.1)
                                            .padding(.bottom, 10)
                                        TrickRowView(name: "Trick 1", trickType: "Trick type", trickComplete: [false,false,false,false], width: width * 0.78, height: height * 0.1)
                                            .padding(.bottom, 10)
                                        TrickRowView(name: "Trick 1", trickType: "Trick type", trickComplete: [false,false,false,false], width: width * 0.78, height: height * 0.1)
                                            .padding(.bottom, 10)
                                        TrickRowView(name: "Trick 1", trickType: "Trick type", trickComplete: [false,false,false,false], width: width * 0.78, height: height * 0.1)
                                            .padding(.bottom, 10)
                                        TrickRowView(name: "Trick 1", trickType: "Trick type", trickComplete: [false,false,false,false], width: width * 0.78, height: height * 0.1)
                                            .padding(.bottom, 10)
                                        TrickRowView(name: "Trick 1", trickType: "Trick type", trickComplete: [false,false,false,false], width: width * 0.78, height: height * 0.1)
                                            .padding(.bottom, 10)
                                        TrickRowView(name: "Trick 1", trickType: "Trick type", trickComplete: [false,false,false,false], width: width * 0.78, height: height * 0.1)
                                            .padding(.bottom, 10)
                                        TrickRowView(name: "Trick 1", trickType: "Trick type", trickComplete: [false,false,false,false], width: width * 0.78, height: height * 0.1)
                                            .padding(.bottom, 10)
                                    }
                                }
                            }
                            
                        }.frame(width: width * 0.8, height: height * 0.6, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                }.padding(.horizontal, width * 0.02)
                Spacer()
            }
        }
        
    }
}

struct PlanView_Previews: PreviewProvider {
    static var previews: some View {
        TrickSelectView()
    }
}


extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}

struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged{_ in
        UIApplication.shared.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}

extension View {
    func resignKeyboardOnDragGesture() -> some View {
        return modifier(ResignKeyboardOnDragGesture())
    }
}
//r66 g70 b84
//w0.8 h0.65
