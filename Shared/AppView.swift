//
//  TabView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 09/12/2020.
//

import SwiftUI

struct AppView: View {
    var body: some View{
        TabView {
            ContentView()
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("Learn")
                }
            ContentView()
                .tabItem {
                    Image(systemName: "perspective")
                    Text("Explore")
                }
            ContentView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            ContentView()
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("Feed")
                }
            ContentView()
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("Profile")
                }
        }
    }
    
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
