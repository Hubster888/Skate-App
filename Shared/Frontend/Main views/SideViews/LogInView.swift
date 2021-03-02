//
//  SocialLogin.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 09/02/2021.
//

import SwiftUI
import Firebase
import Combine
import CombineFirebase


struct LogInView: View {
    //@Binding var loginShown : Bool
    @ObservedObject private var userViewModel = UserViewModel()
    @State var presentAlert = false
    var width: CGFloat = UIScreen.main.bounds.width
    
    var height: CGFloat = UIScreen.main.bounds.height
    
    init(){
        //self.loginShown = loginShown
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack{
            Color(red: 0.13, green: 0.15, blue: 0.22).edgesIgnoringSafeArea(.all)
            VStack{
                Text("Hello...")
                    .font(.system(size: width * 0.125, weight: .bold, design: .monospaced))
                    .foregroundColor(Color(red: 0.96, green: 0.96, blue: 0.96))
                    .padding(.bottom, height * 0.005)
                Form {
                    
                      Section(footer: Text(userViewModel.usernameMessage).foregroundColor(.red)) {
                        TextField("Email", text: $userViewModel.email)
                          .autocapitalization(.none)
                        }
                        Section(footer: Text(userViewModel.passwordMessage).foregroundColor(.red)) {
                            SecureField("Password", text: $userViewModel.password)
                            SecureField("Password again", text: $userViewModel.passwordAgain)
                       }
                       Section {
                         Button(action: {
                            Auth.auth().signIn(withEmail: userViewModel.email, password: userViewModel.password) { authResult, error in
                                if(error == nil){
                                    print("Logged In!")
                                    CurrentUserViewModel().fetchData()
                                   // loginShown = false
                                }else{
                                    print(error!)
                                }
                            }
                         }) {
                            Text("Log In")
                                    
                            
                         }.disabled(!userViewModel.isValid)
                        Button(action: {
                            Auth.auth().createUser(withEmail: userViewModel.email, password: userViewModel.password) { authResult, error in
                                if(error == nil){
                                    print("User Created")
                                    let db = Firestore.firestore()
                                    db.collection("Users").document(Auth.auth().currentUser?.uid ?? "NO USER").getDocument(){
                                        (document, error) in
                                        if document!.exists {
                                            print("Document data: \(String(describing: document!.data()))")
                                            CurrentUserViewModel().fetchData()
                                            //loginShown = false
                                        } else {
                                            print("Document does not exist")
                                            CurrentUserViewModel().initialiseNewUser()
                                           // loginShown = false
                                        }
                                    }
                                }else{
                                    print(error!)
                                }
                            }
                        }){
                            Text("Sign up")
                        }.disabled(!userViewModel.isValid)
                       }
                }
                .frame(width: width, height: height * 0.5, alignment: .center)
                .background(Color(red: 0.13, green: 0.15, blue: 0.22))
                google().frame(width: 120, height: 50)
                Spacer()
            }
        }
        
    }
  }
