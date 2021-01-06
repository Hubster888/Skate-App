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
    
    var body: some View {
        google().frame(width: 120, height: 50)
        Button(action: {self.showingDetail = false}){
            Text("Done")
        }
    }
}

/*struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        //LogInView(showingDetail: s)
    }
}*/

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
