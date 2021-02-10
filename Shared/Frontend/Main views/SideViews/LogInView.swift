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
import GoogleSignIn

struct LogInView: View {
    
    @ObservedObject private var userViewModel = UserViewModel()
    @State var presentAlert = false
    
    var body: some View {
      /*Form {
        Section(footer: Text(userViewModel.usernameMessage).foregroundColor(.red)) {
          TextField("Username", text: $userViewModel.username)
            .autocapitalization(.none)
        }
        Section(footer: Text(userViewModel.passwordMessage).foregroundColor(.red)) {
          SecureField("Password", text: $userViewModel.password)
          SecureField("Password again", text: $userViewModel.passwordAgain)
        }
        Section {
          Button(action: { self.signUp() }) {
            Text("Sign up")
          }.disabled(!self.userViewModel.isValid)
        }
        Section{
            google().frame(width: 120, height: 50)
        }
      }
      .sheet(isPresented: $presentAlert) {
        HomeView()
      }*/
        google().frame(width: 120, height: 50)
    }
    
    func signUp() {
        // Run log in code
        var cancelBag = Set<AnyCancellable>()

        let auth = Auth.auth()
        print(userViewModel.username)
        // Sign in a user with an email address and password
        (auth.signIn(withEmail: userViewModel.username, password: userViewModel.password) as AnyPublisher<AuthDataResult, Error>)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: print("🏁 finished")
                case .failure(let error): do {print(error)}
                }
            }) { _ in
                // User signed in
                if(Auth.auth().currentUser != nil){print("!!!!!!!!!!!!!!!!!!!!!!!!!!")}
                self.presentAlert = true
            }.store(in: &cancelBag)
      
    }
    
  }
//hubertrzeminski16@gmail.com Hubert56


struct google: UIViewRepresentable{
    func updateUIView(_ uiView: GIDSignInButton, context: Context) {
        
    }
    
    func makeUIView(context: UIViewRepresentableContext<google>) -> GIDSignInButton {
        let button = GIDSignInButton()
        button.colorScheme = .dark
        GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.last?.rootViewController
        return button
    }

}
