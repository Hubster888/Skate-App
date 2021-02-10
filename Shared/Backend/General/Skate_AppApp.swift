//
//  Skate_AppApp.swift
//  Shared
//
//  Created by Hubert Rzeminski on 09/12/2020.
//

import Foundation
import SwiftUI
import Firebase
import GoogleSignIn

class AppDelegate: NSObject, UIApplicationDelegate, GIDSignInDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
      // ...
      if let error = error {
        // ...
        print(error.localizedDescription)
        return
      }

      guard let authentication = user.authentication else { return }
      let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                        accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credential, completion: { (res, err) in
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
            print("user=" + (res?.user.email)!)
                // check if user in firestore
            let db = Firestore.firestore()
            db.collection("Users").document(Auth.auth().currentUser?.uid ?? "NO USER").getDocument(){
                (document, error) in
                if document!.exists {
                    print("Document data: \(String(describing: document!.data()))")
                    CurrentUserViewModel().fetchData()
                } else {
                    print("Document does not exist")
                    CurrentUserViewModel().initialiseNewUser()
                }
            }
        })
    }

    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
}

@main
struct Skate_AppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            AppView()
        }
    }
}
