//
//  CurrentUserViewModel.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 28/01/2021.
//

import Foundation
import Firebase

class CurrentUserViewModel : ObservableObject{
    @Published var currentUser : CurrentUser? = nil
    
    private var db = Firestore.firestore()
    
    func startPlan(){
        db.collection("Users").document(Auth.auth().currentUser!.uid).collection("Data").document("1").updateData([
            "planStarted": true
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    func fetchData(){
        
        db.collection("Users").document(Auth.auth().currentUser!.uid).collection("Data").document("1").addSnapshotListener {(documentSnapshot, error) in
            self.currentUser = documentSnapshot.flatMap { (queryDocumentSnapshot) -> CurrentUser in
                return try! queryDocumentSnapshot.data(as: CurrentUser.self)!
            }
        }
    }
}
