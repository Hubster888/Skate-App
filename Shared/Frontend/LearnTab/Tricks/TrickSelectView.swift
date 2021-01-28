//
//  PlanView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 14/12/2020.
//

import SwiftUI

struct TrickSelectView: View {
    
    @ObservedObject private var trickViewModel = TrickViewModel()
    
    @State private var tricksLoaded : Bool = false
    @State private var isEditing = false
    @State private var searchText = ""
    @State private var favoriteColor = 0
    
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
                }
                
                /*if isEditing {
                    let arraySize = filteredList.count - 1
                    if(arraySize != -1){
                        List{
                            ForEach(0...arraySize, id: \.self){ index in
                                NavigationLink(
                                    destination: TrickView(trickId: filteredList[index].getTrickId()),
                                label: {
                                    Text(filteredList[index].getTrickName())
                                 })
                            }
                        }.frame(width: width * 0.9, alignment: .center)
                    }
                }*/
                
                //Segment control
                Picker(selection: $favoriteColor, label: Text("Completed trick?")) {
                    Text("Not even close").tag(0)
                    Text("Almost there").tag(1)
                    Text("Nailed it").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: width * 0.9, height: height * 0.05)
                .padding(.bottom, height * 0.01)
                
                HStack(alignment: .center, spacing: 30) {
                    TrickSelectTabView(tabName: "Begginer", tabType: trickViewModel.beginnerTricks, width: width, height: height)
                    TrickSelectTabView(tabName: "Intermidiate", tabType: trickViewModel.doingThisAWhileTricks, width: width, height: height)
                    TrickSelectTabView(tabName: "Pro", tabType: trickViewModel.proTricks, width: width, height: height)
                    TrickSelectTabView(tabName: "God Level", tabType: trickViewModel.godlikeTricks, width: width, height: height)
                }.modifier(ScrollingHStackModifier(items: 4, itemWidth: width * 0.8, itemSpacing: 30))
                Spacer()
            }
        }.onAppear(perform: {
            self.trickViewModel.fetchData()
        })
        
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
