//
//  HomeView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 09/12/2020.
//

import SwiftUI
import Firebase
import GoogleSignIn

struct HomeView: View {
    
    let db = Firestore.firestore()
    
    @EnvironmentObject var currentUserViewModel : CurrentUserViewModel
    @ObservedObject private var planViewModel = PlanViewModel()
    @State var logInShown : Bool = false
    
    @State var user : Bool = (Auth.auth().currentUser != nil)
    
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
                        LogInView()
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


