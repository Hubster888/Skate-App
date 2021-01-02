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
    @State private var str : String = "nope"
    @State private var begginerTricks : [NSDictionary] = []
    let URL_GET_TRICK = "http://192.168.0.13/DBService/getAllTricks.php"
    
    func getBeginnerTricks() -> [NSDictionary] {
        let request = NSMutableURLRequest(url: NSURL(string: URL_GET_TRICK)! as URL)
        request.httpMethod = "POST"
        let json: [String: Any] = ["trickId": "1",
                                   "trickName": "abc",
                                   "trickType": "sda"]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            if error != nil{
                print("error=\(String(describing: error))")
                return
            }else if let data = data {
                if let jsonString = String(data: data, encoding: .utf8) {
                    str = jsonString
                }
            }
        }

        task.resume()
        while(str == "nope"){
            
        }
        var result : [NSDictionary] = []
        let array = str.components(separatedBy: "}{")
        for trick in array {
            var trickString = trick
            if trick.prefix(1) != "{"{
                trickString = "{" + trick
            }
            if trick.suffix(1) != "}"{
                trickString = trick + "}"
            }
            let trickDic = stringToArray(test: trickString)
            result.append(trickDic)
        }

        return result
    }
    
    func stringToArray(test: String) -> NSDictionary{
        var dictonary:NSDictionary?
                
                if let data = test.data(using: String.Encoding.utf8) {
                    
                    do {
                        dictonary = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject] as NSDictionary?
                    
                        if let myDictionary = dictonary
                        {
                             return myDictionary
                        }
                    } catch let error as NSError {
                        print(error)
                    }
                }
        return dictonary!
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
                                        ForEach(begginerTricksArray, id: \.self){ trick in
                                            Text(trick)
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
            begginerTricks = getBeginnerTricks()
        })
        
    }
    
    //func getAllTricks()
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
//r66 g70 b84
//w0.8 h0.65

//Write a class for tricks to use in the for each loop and create the navigation links
