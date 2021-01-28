//
//  LogInView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 27/12/2020.
//

import SwiftUI
import GoogleSignIn
import Firebase

struct LogInView: View {
    @Binding var showingDetail : Bool
    private let URL_ADD_USER : String = "http://192.168.0.13/DBService/addUser.php"
    
    var body: some View {
        google().frame(width: 120, height: 50)
    }
}

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
