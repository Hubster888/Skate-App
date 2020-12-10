//
//  TabView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 09/12/2020.
//

import SwiftUI

struct AppView: View {
    @State private var selectedTab = 2
    
    var body: some View{
        TabView(selection: $selectedTab) {
            
            LearnView()
                .tabItem {
                    Image(systemName: "pencil.and.outline")
                    Text("Learn")
                }
                .onTapGesture {
                        self.selectedTab = 0
                    }
                .tag(0)
            
            ExploreView()
                .tabItem {
                    Image(systemName: "perspective")
                    Text("Explore")
                }
                .onTapGesture {
                        self.selectedTab = 1
                    }
                .tag(1)
            
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .onTapGesture {
                        self.selectedTab = 2
                    }
                .tag(2)
            
            FeedView()
                .tabItem {
                    Image(systemName: "person.3.fill")
                    Text("Feed")
                }
                .onTapGesture {
                        self.selectedTab = 3
                    }
                .tag(3)
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.circle.fill")
                    Text("Profile")
                }
                .onTapGesture {
                        self.selectedTab = 4
                    }
                .tag(4)
        }
    }
    
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
