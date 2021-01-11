//
//  PlanView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 14/12/2020.
//

import SwiftUI

struct TrickSelectView: View {
    @State private var isEditing = false
    @State private var searchText = ""
    @State private var favoriteColor = 0
    @State private var begginerTricks : [Trick] = []
    @State private var intermediateTricks : [Trick] = []
    @State private var proTricks : [Trick] = []
    @State private var godTricks : [Trick] = []
    @State private var allTricks : [Trick] = []
    
    var filteredList : [Trick]{
        var list : [Trick] = []
        for trick in allTricks{
            if (trick.getTrickName()).contains(searchText){
                list.append(trick)
            }
        }
        return list
    }
    
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

                            TextField("search", text: $searchText)
                                .onTapGesture {
                                    allTricks = begginerTricks + intermediateTricks + proTricks + godTricks
                                    self.isEditing = true
                                }
                                .foregroundColor(.primary)
                            
                            if isEditing {
                                Button(action: {
                                    self.isEditing = false
                                    self.searchText = ""
                 
                                }) {
                                    Text("Cancel")
                                }
                                .padding(.trailing, 10)
                                .transition(.move(edge: .trailing))
                                .animation(.default)
                                
                            }
                        }
                        .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                        .foregroundColor(Color(red: 0.95, green: 0.32, blue: 0.34))
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10)
                        .frame(width: width * 0.9, height: height * 0.05, alignment: .center)

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
                
                if isEditing {
                    Spacer()
                    let arraySize = filteredList.count - 1
                    if(arraySize != -1){
                        List{
                            ForEach(0...arraySize, id: \.self){ index in
                                Text(filteredList[index].getTrickName())
                            }
                        }.frame(width: width * 0.9, alignment: .center)
                    }
                }
                
                HStack(alignment: .center, spacing: 30) {
                    // Beginner tab
                    ZStack{
                        Rectangle()
                            .fill(Color(red: 66/255, green: 70/255, blue: 84/255))
                        VStack{
                            Text("Begginer")
                                .underline()
                                .font(.system(size: 35, weight: .bold, design: .rounded))
                                .foregroundColor(Color(red: 0.96, green: 0.96, blue: 0.96))
                                .padding()
                                
                            ScrollView(.vertical){
                                VStack{
                                    if(begginerTricks.isEmpty){
                                        Text("Not loaded")
                                    }else{
                                        let arraySize = begginerTricks.count - 1
                                        ForEach(0...arraySize, id: \.self){ index in  //Map the parameter to `index`
                                                NavigationLink(
                                                    destination: TrickView(trickId: begginerTricks[index].getTrickId()),
                                                label: {
                                                    TrickRowView(name: begginerTricks[index].getTrickName(),
                                                                 trickType: begginerTricks[index].getTrickType(),
                                                        trickComplete: [false,false,false,false],
                                                        width: width * 0.73, height: height * 0.13)
                                                 })
                                                    .buttonStyle(ThemeAnimationStyle())
                                                    .padding(.bottom, 15)
                                                    
                                        }
                                    }
                                }.frame(width: width * 0.8, height: height * 0.31, alignment: .center)
                            }
                            Rectangle()
                                .fill(Color(red: 66/255, green: 70/255, blue: 84/255))
                                .frame(width: width * 0.8, height: height * 0.025)
                        }
                    }
                    .frame(width: width * 0.8, height: height * 0.6)
                    .cornerRadius(20)
                    .shadow(color: Color(red: 66/255, green: 70/255, blue: 84/255, opacity: 0.5), radius: 3, x: 10, y: 10)
                    
                    // Intermediate tab
                    ZStack{
                        Rectangle()
                            .fill(Color(red: 66/255, green: 70/255, blue: 84/255))
                        VStack{
                            Text("Intermidiate")
                                .underline()
                                .font(.system(size: 35, weight: .bold, design: .rounded))
                                .foregroundColor(Color(red: 0.96, green: 0.96, blue: 0.96))
                                .padding()
                            ScrollView(.vertical){
                                VStack{
                                    if(intermediateTricks.isEmpty){
                                        Text("Not loaded")
                                    }else{
                                        let arraySize = intermediateTricks.count - 1
                                        ForEach(0...arraySize, id: \.self){ index in  //Map the parameter to `index`
                                                NavigationLink(
                                                    destination: TrickView(trickId: intermediateTricks[index].getTrickId()),
                                                label: {
                                                    TrickRowView(name: intermediateTricks[index].getTrickName() ,
                                                                 trickType: intermediateTricks[index].getTrickType(),
                                                        trickComplete: [false,false,false,false],
                                                        width: width * 0.73, height: height * 0.13)
                                                 })
                                                    .buttonStyle(ThemeAnimationStyle())
                                                    .padding(.bottom, 15)
                                        }
                                    }
                                }.frame(width: width * 0.8, height: height * 0.31, alignment: .center)
                            }
                            Rectangle()
                                .fill(Color(red: 66/255, green: 70/255, blue: 84/255))
                                .frame(width: width * 0.8, height: height * 0.025, alignment: .center)
                        }
                    }
                    .frame(width: width * 0.8, height: height * 0.6)
                    .cornerRadius(20)
                    .shadow(color: Color(red: 66/255, green: 70/255, blue: 84/255, opacity: 0.5), radius: 3, x: 10, y: 10)
                    
                    // Pro tab
                    ZStack{
                        Rectangle()
                            .fill(Color(red: 66/255, green: 70/255, blue: 84/255))
                        VStack{
                            Text("Pro")
                                .underline()
                                .font(.system(size: 35, weight: .bold, design: .rounded))
                                .foregroundColor(Color(red: 0.96, green: 0.96, blue: 0.96))
                                .padding()
                            ScrollView(.vertical){
                                VStack{
                                    if(proTricks.isEmpty){
                                        Text("Not loaded")
                                    }else{
                                        let arraySize = proTricks.count - 1
                                        ForEach(0...arraySize, id: \.self){ index in  //Map the parameter to `index`
                                                NavigationLink(
                                                    destination: TrickView(trickId: proTricks[index].getTrickId()),
                                                label: {
                                                    TrickRowView(name: proTricks[index].getTrickName() ,
                                                                 trickType: proTricks[index].getTrickType(),
                                                        trickComplete: [false,false,false,false],
                                                        width: width * 0.73, height: height * 0.13)
                                                 })
                                                    .buttonStyle(ThemeAnimationStyle())
                                                    .padding(.bottom, 15)
                                        }
                                    }
                                }.frame(width: width * 0.8, height: height * 0.31, alignment: .center)
                            }
                            Rectangle()
                                .fill(Color(red: 66/255, green: 70/255, blue: 84/255))
                                .frame(width: width * 0.8, height: height * 0.025, alignment: .center)
                        }
                    }
                    .frame(width: width * 0.8, height: height * 0.6, alignment: .center)
                    .cornerRadius(20)
                    .shadow(color: Color(red: 66/255, green: 70/255, blue: 84/255, opacity: 0.5), radius: 3, x: 10, y: 10)
                    
                    // God level tab
                    ZStack{
                        Rectangle()
                            .fill(Color(red: 66/255, green: 70/255, blue: 84/255))
                        VStack{
                            Text("God Level")
                                .underline()
                                .font(.system(size: 35, weight: .bold, design: .rounded))
                                .foregroundColor(Color(red: 0.96, green: 0.96, blue: 0.96))
                                .padding()
                            ScrollView(.vertical){
                                VStack{
                                    if(godTricks.isEmpty){
                                        Text("Not loaded")
                                    }else{
                                        let arraySize = godTricks.count - 1
                                        ForEach(0...arraySize, id: \.self){ index in  //Map the parameter to `index`
                                                NavigationLink(
                                                    destination: TrickView(trickId: godTricks[index].getTrickId()),
                                                label: {
                                                    TrickRowView(name: godTricks[index].getTrickName(),
                                                                 trickType: godTricks[index].getTrickType(),
                                                        trickComplete: [false,false,false,false],
                                                        width: width * 0.73, height: height * 0.13)
                                                 })
                                                    .buttonStyle(ThemeAnimationStyle())
                                                    .padding(.bottom, 15)
                                        }
                                    }
                                }.frame(width: width * 0.8, height: height * 0.31, alignment: .center)
                            }
                            Rectangle()
                                .fill(Color(red: 66/255, green: 70/255, blue: 84/255))
                                .frame(width: width * 0.8, height: height * 0.025, alignment: .center)
                        }
                    }
                    .frame(width: width * 0.8, height: height * 0.6, alignment: .center)
                    .cornerRadius(20)
                    .shadow(color: Color(red: 66/255, green: 70/255, blue: 84/255, opacity: 0.5), radius: 3, x: 10, y: 10)
                    
                }.modifier(ScrollingHStackModifier(items: 4, itemWidth: width * 0.8, itemSpacing: 30))
                Spacer()
            }
        }.onAppear(perform: {
            loadTrick(dificulty: 1)
            loadTrick(dificulty: 2)
            loadTrick(dificulty: 3)
            loadTrick(dificulty: 4)
        })
        
    }
    
    func loadTrick(dificulty: Int){
        TrickLoader().getAllTrick(dificulty: dificulty) {result in
            var resArr : [Trick] = []
            switch result{
            case .success(let json):
                let array = json.components(separatedBy: "}{")
                for trick in array {
                    var trickString = trick
                    if trick.prefix(1) != "{"{
                        trickString = "{" + trick
                    }
                    if trick.suffix(1) != "}"{
                        trickString = trick + "}"
                    }
                    let trickDic = TrickLoader().stringToTrick(string: trickString)
                    resArr.append(trickDic)
                }
                
                switch dificulty{
                case 1:
                    begginerTricks = resArr
                    break
                case 2:
                    intermediateTricks = resArr
                    break
                case 3:
                    proTricks = resArr
                    break
                case 4:
                    godTricks = resArr
                    break
                default:
                    print("Dificulty number out of range!")
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

struct TrickSelectView_Previews: PreviewProvider {
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
