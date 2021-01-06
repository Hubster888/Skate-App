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
    @State private var begginerTricks : [Dictionary<String,Any>] = []
    @State private var intermediateTricks : [Dictionary<String,Any>] = []
    @State private var proTricks : [Dictionary<String,Any>] = []
    @State private var godTricks : [Dictionary<String,Any>] = []

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
                            VStack{
                                Text("Begginer")
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
                                                    destination: TrickView(trickId: begginerTricks[index]["trickId"] as! String),
                                                    label: {
                                                        TrickRowView(name: begginerTricks[index]["trickName"] as! String,
                                                            trickType: begginerTricks[index]["trickType"] as! String,
                                                            trickComplete: [false,false,false,false],
                                                            width: width * 0.78, height: height * 0.1)
                                                     })
                                            }
                                        }
                                    }
                                }
                                Rectangle()
                                    .fill(Color(red: 66/255, green: 70/255, blue: 84/255))
                                    .frame(width: width * 0.8, height: height * 0.025, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            }
                        }
                        .frame(width: width * 0.8, height: height * 0.65, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .cornerRadius(20)
                        
                        ZStack{
                            Rectangle()
                                .fill(Color(red: 66/255, green: 70/255, blue: 84/255))
                            VStack{
                                Text("Intermidiate")
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
                                                    destination: TrickView(trickId: intermediateTricks[index]["trickId"] as! String),
                                                    label: {
                                                        TrickRowView(name: intermediateTricks[index]["trickName"] as! String,
                                                            trickType: intermediateTricks[index]["trickType"] as! String,
                                                            trickComplete: [false,false,false,false],
                                                            width: width * 0.78, height: height * 0.1)
                                                     })
                                            }
                                        }
                                    }
                                }
                                Rectangle()
                                    .fill(Color(red: 66/255, green: 70/255, blue: 84/255))
                                    .frame(width: width * 0.8, height: height * 0.025, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            }
                        }
                        .frame(width: width * 0.8, height: height * 0.65, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .cornerRadius(20)
                        
                        ZStack{
                            Rectangle()
                                .fill(Color(red: 66/255, green: 70/255, blue: 84/255))
                            VStack{
                                Text("Pro")
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
                                                    destination: TrickView(trickId: proTricks[index]["trickId"] as! String),
                                                    label: {
                                                        TrickRowView(name: proTricks[index]["trickName"] as! String,
                                                            trickType: proTricks[index]["trickType"] as! String,
                                                            trickComplete: [false,false,false,false],
                                                            width: width * 0.78, height: height * 0.1)
                                                     })
                                            }
                                        }
                                    }
                                }
                                Rectangle()
                                    .fill(Color(red: 66/255, green: 70/255, blue: 84/255))
                                    .frame(width: width * 0.8, height: height * 0.025, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            }
                        }
                        .frame(width: width * 0.8, height: height * 0.65, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .cornerRadius(20)
                        
                        ZStack{
                            Rectangle()
                                .fill(Color(red: 66/255, green: 70/255, blue: 84/255))
                            VStack{
                                Text("God Level")
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
                                                    destination: TrickView(trickId: godTricks[index]["trickId"] as! String),
                                                    label: {
                                                        TrickRowView(name: godTricks[index]["trickName"] as! String,
                                                            trickType: godTricks[index]["trickType"] as! String,
                                                            trickComplete: [false,false,false,false],
                                                            width: width * 0.78, height: height * 0.1)
                                                     })
                                            }
                                        }
                                    }
                                }
                                Rectangle()
                                    .fill(Color(red: 66/255, green: 70/255, blue: 84/255))
                                    .frame(width: width * 0.8, height: height * 0.025, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            }
                        }
                        .frame(width: width * 0.8, height: height * 0.65, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .cornerRadius(20)
                    }
                }.padding(.horizontal, width * 0.02)
                Spacer()
            }
        }.onAppear(perform: {
            TrickLoader().getAllTrick(dificulty: 1) {result in
                var resArr : [Dictionary<String,Any>] = []
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
                        let trickDic = TrickLoader().stringToArray(string: trickString)
                        resArr.append(trickDic)
                    }
                    if(!((resArr[0]["trickId"] != nil) == false)){
                        begginerTricks = resArr
                    }
                case .failure(let error):
                    print(error)
                }
            }
            
            TrickLoader().getAllTrick(dificulty: 2) {result in
                var resArr : [Dictionary<String,Any>] = []
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
                        let trickDic = TrickLoader().stringToArray(string: trickString)
                        resArr.append(trickDic)
                    }
                    if(!((resArr[0]["trickId"] != nil) == false)){
                        intermediateTricks = resArr
                    }
                case .failure(let error):
                    print(error)
                }
            }
            
            TrickLoader().getAllTrick(dificulty: 3) {result in
                var resArr : [Dictionary<String,Any>] = []
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
                        let trickDic = TrickLoader().stringToArray(string: trickString)
                        resArr.append(trickDic)
                    }
                    if(!((resArr[0]["trickId"] != nil) == false)){
                        proTricks = resArr
                    }
                        
            
                    
                case .failure(let error):
                    print(error)
                }
            }
            
            TrickLoader().getAllTrick(dificulty: 4) {result in
                var resArr : [Dictionary<String,Any>] = []
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
                        let trickDic = TrickLoader().stringToArray(string: trickString)
                        resArr.append(trickDic)
                    }
                    if(!((resArr[0]["trickId"] != nil) == false)){
                        godTricks = resArr
                    }
                case .failure(let error):
                    print(error)
                }
            }
        })
        
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
