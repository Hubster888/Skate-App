//
//  LogInView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 27/12/2020.
//

import SwiftUI
import GoogleSignIn

struct LogInView: View {
    
    var body: some View {
        google().frame(width: 120, height: 50)
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}

struct google: UIViewRepresentable{
    func makeUIView(context: UIViewRepresentableContext<google>) -> GIDSignInButton {
        let button = GIDSignInButton()
        button.colorScheme = .dark
        GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.last?.rootViewController
        return button
    }
    
    func updateUIView(_ uiView: GIDSignInButton, context: UIViewRepresentableContext<google>) {
        
    }
}
