//
//  TabView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 09/12/2020.
//

import SwiftUI
import Firebase

struct AppView: View {
    @State private var selectedTab = 2

    var body: some View{
        ZStack{
            Color(red: 0.13, green: 0.15, blue: 0.22)
            TabView(selection: $selectedTab) {
                LearnView()
                    .tabItem {
                        Image(systemName: "pencil.and.outline")
                        Text("Learn")
                    }
                    .onAppear {
                            self.selectedTab = 0
                        }
                    .tag(0)
                
                ExploreView()
                    .tabItem {
                        Image(systemName: "perspective")
                        Text("Explore")
                    }
                    .onAppear {
                            self.selectedTab = 1
                        }
                    .tag(1)
                
                HomeView()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                    .onAppear {
                            self.selectedTab = 2
                        }
                    .tag(2)
                
                FeedView()
                    .tabItem {
                        Image(systemName: "person.3.fill")
                        Text("Feed")
                    }
                    .onAppear {
                            self.selectedTab = 3
                        }
                    .tag(3)
                
                ProfileView()
                    .tabItem {
                        Image(systemName: "person.circle.fill")
                        Text("Profile")
                    }
                    .onAppear {
                            self.selectedTab = 4
                        }
                    .tag(4)
            }
        }
        .accentColor(Color(red: 0.95, green: 0.32, blue: 0.34))
        .onAppear() {
            UITabBar.appearance().barTintColor = UIColor(red: 0.13, green: 0.15, blue: 0.22, alpha: 1.0)
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
