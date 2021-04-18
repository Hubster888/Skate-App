//
//  SocialLogin.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 09/02/2021.
//

import SwiftUI
import Firebase
import Combine
//import CombineFirebase
import FirebaseFirestore

struct LogInView: View { // TODO: Make this page look nice
    
    //MARK: Variable declerations
    //Navigation variables
    @State var presentAlert = false
    @Binding var logInShown : Bool
    
    //Related data variables
    @ObservedObject private var userViewModel = UserViewModel()
    @EnvironmentObject var currentUserViewModel : CurrentUserViewModel
    
    //View variables
    var titleFontSize : CGFloat {
        return width * 0.125
    }
    var titlePadding : CGFloat {
        return height * 0.05
    }
    var frameHeight : CGFloat {
        height * 0.5
    }
    var buttonWidth : CGFloat {
        return width * 0.25
    }
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.height
    let defaultColor : Color = Color(red: 0.13, green: 0.15, blue: 0.22) // Black
    let backgroundColor : Color = Color(red: 0.96, green: 0.96, blue: 0.96) // White
    let highlightColor : Color = Color(red: 0.95, green: 0.32, blue: 0.34) // Red
    let cornerRadius : CGFloat = 15
    
    // Make list backgrond transparent
    init(loginShown: Binding<Bool>){
        UITableView.appearance().backgroundColor = .clear
        self._logInShown = loginShown
    }
    
    //MARK:Body
    var body: some View {
        ZStack{
            defaultColor.edgesIgnoringSafeArea(.all)
            VStack{
                Text("Hello...")
                    .font(.system(size: titleFontSize, weight: .bold, design: .monospaced))
                    .foregroundColor(backgroundColor)
                    .padding(.top, titlePadding)
                    .offset(y: titlePadding)
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
                                }else{
                                    print(error!)
                                }
                            }
                         }) {
                            Text("Log In")
                                .foregroundColor(!userViewModel.isValid ? Color.gray : highlightColor)
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
                                            logInShown = false
                                        } else {
                                            print("Document does not exist")
                                            CurrentUserViewModel().initialiseNewUser()
                                            logInShown = false
                                        }
                                    }
                                }else{
                                    print(error!)
                                }
                            }
                        }){
                            Text("Sign up")
                                .foregroundColor(!userViewModel.isValid ? Color.gray : highlightColor)
                        }.disabled(!userViewModel.isValid)
                       }
                }
                .frame(width: width, height: frameHeight, alignment: .center)
                .background(defaultColor)
                
                
                    google()
                        .frame(width: 120, height: 50)
                        .offset(y: -titlePadding)
                        .onAppear(){
                            let _ = Auth.auth().addStateDidChangeListener { (auth, user) in
                                if (user != nil) {
                                    self.logInShown  = false
                                }
                            }
                        }
                
                
                
                Button(action: {
                    logInShown = false
                }){
                    ZStack{
                        Rectangle()
                            .fill(highlightColor)
                            .frame(width: buttonWidth, height: titlePadding, alignment: .center)
                            .cornerRadius(cornerRadius)
                        Text("Done")
                            .foregroundColor(backgroundColor)
                    }
                }.buttonStyle(ScaleAnimationButtonEffect())
                Spacer()
            }
        }
    }
  }


