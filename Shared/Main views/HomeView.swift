//
//  HomeView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 09/12/2020.
//

import SwiftUI
import Firebase

struct HomeView: View {
    @State var showingDetail = false
    let URL_SAVE_TRICK = "http://192.168.0.13/DBService/Connection.php"
    let URL_GET_TRICK = "http://192.168.0.13/DBService/getTrick.php"
    
    var colors: [Color] = [.blue, .green, .red, .orange]
    
    var body: some View {
        
        NavigationView {
            VStack {
                NavigationLink(destination: Text("Detail View")) {
                    Text("Hello World")
                }
                Button(action: {
                    if(Auth.auth().currentUser != nil){
                        logout()
                        showingDetail = false
                    }else{
                        showingDetail = true
                        //show sheet to log in
                    }
                }){
                    if(Auth.auth().currentUser != nil){
                        Text("Sign Out")
                    }else{
                        Text("Log In")
                    }
                }.sheet(isPresented: $showingDetail,
                        content: {
                            LogInView(showingDetail: self.$showingDetail)
                        })
            }
            .navigationBarTitle("SwiftUI")
        }
    }
        
    func logout(){
        do{
            try Auth.auth().signOut()
        }catch let error as NSError{
            print(error.localizedDescription)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showingDetail: false)
    }
}


