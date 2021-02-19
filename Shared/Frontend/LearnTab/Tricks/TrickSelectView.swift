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
    @State private var tabSelected = 0
    @State var showingTrick = false
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(red: 0.95, green: 0.32, blue: 0.34, alpha: 1.0)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.0)], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(red: 0.13, green: 0.15, blue: 0.22, alpha: 1.0)], for: .normal)
    }
    
    var height: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    var width: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    let layout = [
            GridItem(.flexible())
        ]
    
    var body: some View {
        
        ZStack{
            Rectangle()
                .fill(Color(red: 0.96, green: 0.96, blue: 0.96).opacity(isEditing ? 0.5 : 1))
                .frame(width: width, height: height, alignment: .center)
            VStack{
                
                    //Search bar
                    VStack{
                        ZStack{
                            Rectangle()
                                .fill(Color(red: 66/255, green: 70/255, blue: 84/255))
                                .frame(width: width, height: height * 0.1)
                                .padding(.top, height * 0.075)
                            HStack {
                                HStack {
                                    Image(systemName: "magnifyingglass")

                                    TextField("search", text: $trickViewModel.searchText)
                                        .onTapGesture {
                                            self.isEditing = true
                                        }
                                        .foregroundColor(.primary)
                                    
                                    if isEditing {
                                        Button(action: {
                                            self.isEditing = false
                                            trickViewModel.searchText = ""
                         
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
                        
                        ZStack{
                            VStack{
                                //Segment control
                                Picker(selection: $tabSelected, label: Text("Completed trick?")) {
                                    Text("All tricks").tag(0)
                                    Text("Not even close").tag(1)
                                    Text("Almost there").tag(2)
                                }
                                .pickerStyle(SegmentedPickerStyle())
                                .frame(width: width * 0.9, height: height * 0.05)
                                .padding(.bottom, height * 0.01)
                                
                                //Tricks display
                                HStack(alignment: .center, spacing: 30) {
                                    TrickSelectTabView(tabDiff: 1, width: width, height: height, segment: self.tabSelected, isEditing: self.$isEditing).environmentObject(self.trickViewModel)
                                    TrickSelectTabView(tabDiff: 2, width: width, height: height, segment: self.tabSelected, isEditing: self.$isEditing).environmentObject(self.trickViewModel)
                                    TrickSelectTabView(tabDiff: 3, width: width, height: height, segment: self.tabSelected, isEditing: self.$isEditing).environmentObject(self.trickViewModel)
                                    TrickSelectTabView(tabDiff: 4, width: width, height: height, segment: self.tabSelected, isEditing: self.$isEditing).environmentObject(self.trickViewModel)
                                }
                                .modifier(ScrollingHStackModifier(items: 4, itemWidth: width * 0.8, itemSpacing: 30))
                                Spacer()
                        }
                            
    
                            if trickViewModel.tricks.filter{$0.name.contains(trickViewModel.searchText)}.count > 0 {
                                ScrollView(showsIndicators: false) {
                                    LazyVGrid(columns: layout, spacing: 12) {
                                        ForEach(trickViewModel.tricks.filter{$0.name.contains(trickViewModel.searchText)}) { trick in
                                            Button(action: {
                                                trickViewModel.setCurrentTrick(id: trick.id!)
                                                trickViewModel.getCurrentCompletion(id: trick.id!)
                                                showingTrick = true                                                
                                            }){
                                                TrickSearchView(name: trick.name, width: width, height: height)
                                            }.sheet(isPresented: $showingTrick) {
                                                TrickView().environmentObject(self.trickViewModel)
                                            }
                                            
                                        }
                                    }
                                }
                            }
                    
                            }
                               
                        }
                        
                        
            }
        }.onAppear(perform: {
            self.trickViewModel.listenCollectionAsObject()
            self.trickViewModel.getImage(name: "teamLogoMark.png", place: 3)
            self.trickViewModel.getTrickComplete()
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


