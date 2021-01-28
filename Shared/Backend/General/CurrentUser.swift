//
//  User.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 27/01/2021.
//

import Foundation
import Firebase

class CurrentUser {
    
    static func userHasPlan(completionHandler: @escaping (Bool) -> Void){
        let docRef = Firestore.firestore().collection("Users").document(Auth.auth().currentUser!.uid)
        docRef.getDocument { (document, error) in
            let res = document!.get("planStarted")! as! Int
            if(res == 1){
                completionHandler(true)
            }else{
                completionHandler(false)
            }
        }
    }
}
