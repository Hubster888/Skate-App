//
//  PlanView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 14/12/2020.
//

import SwiftUI

struct TrickSelectView: View {
    
    //MARK: Variable Declerations
    //View display booleans
    @State private var tricksLoaded : Bool = false
    @State private var isEditing : Bool = false
    @State var showingTrick : Bool = false
    
    //Model and segment variable
    @ObservedObject private var trickViewModel = TrickViewModel()
    @State private var tabSelected = 0
    
    //View variables
    var searchBarHeight : CGFloat {
        return height * 0.1
    }
    var searchBarPadding : CGFloat {
        return height * 0.075
    }
    var searchBarWidth : CGFloat {
        return width * 0.9
    }
    var trickCardWidth : CGFloat {
        return width * 0.8
    }
    let searchSpacing : CGFloat = 12
    let trickCardSpacing : CGFloat = 30
    let segmentControlText : [String] = ["Completed trick?","All tricks","Not even close","Almost there"]
    let cornerRadius : CGFloat = 10
    let cancelButtonPadding : CGFloat = 10
    let backgroundUIColor : UIColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.0) // White
    let backgroundColor : Color = Color(red: 0.96, green: 0.96, blue: 0.96)
    let tintUIColor : UIColor = UIColor(red: 0.95, green: 0.32, blue: 0.34, alpha: 1.0) // Red
    let tintColor : Color = Color(red: 0.95, green: 0.32, blue: 0.34)
    let mainColor : UIColor = UIColor(red: 0.13, green: 0.15, blue: 0.22, alpha: 1.0) // Black
    let mainFadedColor : Color = Color(red: 0.26, green: 0.27, blue: 0.33)
    var height: CGFloat = UIScreen.main.bounds.height
    var width: CGFloat = UIScreen.main.bounds.width
    let layout = [GridItem(.flexible())] // Used for layout of trick search
    
    // Used to set the color of segment control
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = tintUIColor
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: backgroundUIColor], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: mainColor], for: .normal)
    }
    
    //MARK: Body
    var body: some View {
        ZStack{
            // Background that fades when search is active
            Rectangle() //FIXME: Improve the background fading
                .fill((backgroundColor).opacity(isEditing ? 0.5 : 1))
                .frame(width: width, height: height, alignment: .center)
            VStack{
                
                //MARK: Search Bar
                VStack{
                    ZStack{
                        Rectangle()
                            .fill(mainFadedColor)
                            .frame(width: width, height: searchBarHeight)
                            .padding(.top, searchBarPadding)
                        HStack {
                            HStack {
                                Image(systemName: "magnifyingglass")
                                TextField("search", text: $trickViewModel.searchText) //FIXME: The keyboard make view disapear
                                    .onTapGesture {
                                        self.isEditing = true
                                    }
                                    .foregroundColor(.primary)
                                if isEditing { // Cancel button appears during search
                                    Button(action: {
                                        self.isEditing = false
                                        trickViewModel.searchText = ""
                                    }) {
                                        Text("Cancel")
                                    }
                                    .padding(.trailing, cancelButtonPadding)
                                    .transition(.move(edge: .trailing))
                                    .animation(.default)
                                }
                            }
                            .padding(cancelButtonPadding)
                            .foregroundColor(tintColor)
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(cornerRadius)
                            .frame(width: searchBarWidth, height: searchBarHeight/2, alignment: .center)
                        }.padding(.top, searchBarHeight)
                    }
                    ZStack{
                        VStack{
                            //MARK: Segment Control
                            Picker(selection: $tabSelected, label: Text(segmentControlText[0])) {
                                Text(segmentControlText[1]).tag(0)
                                Text(segmentControlText[2]).tag(1)
                                Text(segmentControlText[3]).tag(2)
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .frame(width: searchBarWidth, height: searchBarPadding)
                            .padding(.bottom, height * 0.01)
                            
                            //MARK: Trick Display
                            HStack(alignment: .center, spacing: trickCardSpacing) {
                                TrickSelectTabView(tabDiff: 1, width: width, height: height, segment: self.tabSelected, isEditing: self.$isEditing).environmentObject(self.trickViewModel) // Displays begginer tricks
                                TrickSelectTabView(tabDiff: 2, width: width, height: height, segment: self.tabSelected, isEditing: self.$isEditing).environmentObject(self.trickViewModel) // Displays intremidiate tricks
                                TrickSelectTabView(tabDiff: 3, width: width, height: height, segment: self.tabSelected, isEditing: self.$isEditing).environmentObject(self.trickViewModel) // Displays pro tricks
                                TrickSelectTabView(tabDiff: 4, width: width, height: height, segment: self.tabSelected, isEditing: self.$isEditing).environmentObject(self.trickViewModel) // Displays god like tricks
                            }
                            .modifier(ScrollingHStackModifier(items: 4, itemWidth: trickCardWidth, itemSpacing: trickCardSpacing))
                            Spacer()
                        }
                        
                        //MARK: Search Bar Results
                        if trickViewModel.tricks.filter{$0.name.contains(trickViewModel.searchText)}.count > 0 {
                            ScrollView(showsIndicators: false) { //TODO: Make the search results look better
                                LazyVGrid(columns: layout, spacing: searchSpacing) {
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
            self.trickViewModel.listenCollectionAsObject() //Listens to all tricks
            self.trickViewModel.getImage(name: "teamLogoMark.png", place: 3) // Gets the image for end of view
            self.trickViewModel.getTrickComplete() // Gets what tricks are completed by user
        })
    }
}
