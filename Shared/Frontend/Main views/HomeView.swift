//
//  HomeView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 09/12/2020.
//

import SwiftUI
import Firebase

struct HomeView: View {
    
    //@EnvironmentObject var currentUser : CurrentUser
    
    
    let db = Firestore.firestore()
    
    @ObservedObject private var planViewModel = PlanViewModel()
    
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
                
                Button(action: {
                    var ref: DocumentReference? = nil
                    ref = db.collection("users").addDocument(data: [
                        "first": "Ada",
                        "last": "Lovelace",
                        "born": 1815
                    ]) { err in
                        if let err = err {
                            print("Error adding document: \(err)")
                        } else {
                            print("Document added with ID: \(ref!.documentID)")
                        }
                    }
              

                }){
                    Text("DB Test add!")
                }
                Button(action: {
                    var ref: DocumentReference? = nil
                    // Add a second document with a generated ID.
                    ref = db.collection("users").addDocument(data: [
                        "first": "Alan",
                        "middle": "Mathison",
                        "last": "Turing",
                        "born": 1912
                    ]) { err in
                        if let err = err {
                            print("Error adding document: \(err)")
                        } else {
                            print("Document added with ID: \(ref!.documentID)")
                        }
                    }

                }){
                    Text("DB Test add! 2")
                }
                Button(action: {
                    if(Auth.auth().currentUser != nil){
                        //PlanWeekTaskViewModel(planViewModel: self.planViewModel).setData() // Execute when new account created
                    }

                }){
                    Text("Create tasks for user")
                }.onAppear(perform: {
                    if(Auth.auth().currentUser != nil){
                        //planViewModel.fetchData()
                        
                    }
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


