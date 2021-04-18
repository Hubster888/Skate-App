//
//  TabView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 09/12/2020.
//

import SwiftUI
import Firebase

struct AppView: View {

    @State private var selectedTab = 1
    var currentUserViewModel = CurrentUserViewModel()

    var body: some View{
        ZStack{
            Color(red: 0.13, green: 0.15, blue: 0.22)
            TabView(selection: $selectedTab) {
                LearnView().environmentObject(currentUserViewModel)
                    .tabItem {
                        Image(systemName: "pencil.and.outline")
                        Text("Learn")
                    }
                    .onAppear {
                            self.selectedTab = 0
                        }
                    .tag(0)
                
                HomeView().environmentObject(currentUserViewModel)
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                    .onAppear {
                        self.selectedTab = 2
                        }
                    .tag(1)
            }
        }
        .accentColor(Color(red: 0.95, green: 0.32, blue: 0.34))
        .onAppear() {
            UITabBar.appearance().barTintColor = UIColor(red: 0.13, green: 0.15, blue: 0.22, alpha: 1.0)
            //currentUserViewModel.fetchData()
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
