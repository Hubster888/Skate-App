//
//  CurrentUserViewModel.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 28/01/2021.
//

import Foundation
import GoogleSignIn
import Firebase
import FirebaseFirestore

class CurrentUserViewModel : ObservableObject{
    
    //MARK: Variable declerations
    @Published var currentUser : CurrentUser? = nil
    private var db = Firestore.firestore()
    
    //MARK: Getters
    func fetchData(){
        if(Auth.auth().currentUser != nil){
            db.collection("Users").document(Auth.auth().currentUser!.uid).collection("Data").document("data").addSnapshotListener {(documentSnapshot, error) in
                    self.currentUser = documentSnapshot.flatMap { (queryDocumentSnapshot) -> CurrentUser in
                        return try! (queryDocumentSnapshot.data(as: CurrentUser.self) ?? CurrentUser(planStarted: false, email: "None"))
                    }
                }
        }
    }
    
    //MARK: Modifiers
    func startPlan(){
        db.collection("Users").document(Auth.auth().currentUser!.uid).collection("Data").document("data").updateData([
            "planStarted": true
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    //MARK: New user initialisers
    func initialiseNewUser(){
        //Add holder data to initialise the user in firestore
        db.collection("Users").document(Auth.auth().currentUser!.uid).setData([
            "holder": 1
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
        //Add user data
        db.collection("Users").document(Auth.auth().currentUser!.uid).collection("Data").document("data").setData([
            "planStarted": false,
            "email": "email"
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
        
        //Add dummy plan
        db.collection("Users").document(Auth.auth().currentUser!.uid).collection("Plan").document("plan").setData([
            "hoursPerWeek": 0,
            "trickChoice1": 0,
            "trickChoice2": 0,
            "trickChoice3": 0,
            "weekOn": 0
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
        
        //Add dummy tasks
        let taskLists : [[String]] = [["Ride Around", "Moving Hippy Jump", "Standing Ollie"],["Ride Around", "Moving Ollie", "Manual", "Hippy Jump"],["Ride Around", "Manual", "Standing \("Kick Flip")", "Moving Ollie", "Standing \( "Heel Flip")"],["Ride Around", "Moving Ollie", "Manual", "Moving \("Kick Flip")", "Moving \( "Heel Flip")", "Ollie Over Obstacle"],["Ride Around", "Ollie Off A Curb", "Moving \( "Heel Flip")", "Moving \("Kick Flip")", "Manual", "\("Kick Flip") Over A Obstacle"],["Ride Around", "\( "Heel Flip") Over Obstacle", "\("Kick Flip") Off A Curb", "Manual", "Ollie Onto A Curb"],["Ride Around", "Ollie Onto A Low Rail/ Ledge Into A 50-50 Grind", "Manual", "\( "Heel Flip") Off A Curb", "\("Kick Flip") Onto A Curb"],["Ride Around", "Manual", "\( "Heel Flip") Onto A Curb", "Ollie Off A Small Stair Set", "\("Kick Flip") Off A Small Stair Set", "Moving 180 Ollie"]]
        var taskList = [PlanWeekTaskModel]()
        for i in 0...taskLists.count - 1{
            for j in 0...taskLists[i].count - 1{
                taskList.append(PlanWeekTaskModel(title: taskLists[i][j], complete: false, weekFor: i + 1))
            }
        }
        for i in 0...taskList.count - 1{
            let _ =  db.collection("Users").document(Auth.auth().currentUser!.uid).collection("Plan").document("plan").collection("Tasks").addDocument(from: taskList[i])
        }
        fetchData()
    }
}
