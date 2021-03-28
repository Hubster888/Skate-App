//
//  HomeView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 09/12/2020.
//

import SwiftUI
import Firebase
import GoogleSignIn
import FirebaseFirestore

struct HomeView: View {
    
    let db = Firestore.firestore()
    
    @EnvironmentObject var currentUserViewModel : CurrentUserViewModel
    @ObservedObject private var planViewModel = PlanViewModel()
    @State var logInShown : Bool = false
        
    var body: some View {
        NavigationView {
            VStack {
                if(currentUserViewModel.currentUser != nil){
                    Button(action: {logout()}){Text("OUT")}
                }else{
                    Button(action: {
                        logInShown = true
                    }){
                        Text("Log In")
                    }
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .background(Color.white)
                    .cornerRadius(8.0)
                    .shadow(radius: 4.0)
                    .sheet(isPresented: $logInShown) {
                        LogInView(loginShown: self.$logInShown).environmentObject(self.currentUserViewModel)
                    }
                }
            }.onAppear{
                if(Auth.auth().currentUser != nil){
                    currentUserViewModel.fetchData()
                }
            }
        }
    }
        
    func logout(){
        do{
            try Auth.auth().signOut()
            currentUserViewModel.currentUser = nil
        }catch let error as NSError{
            print(error.localizedDescription)
        }
    }
}



