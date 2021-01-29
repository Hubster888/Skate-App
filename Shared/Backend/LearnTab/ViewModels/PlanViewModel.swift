//
//  PlanViewModel.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 29/01/2021.
//

import Foundation
import FirebaseFirestore
import Firebase

class PlanViewModel : ObservableObject{
    @Published var plan : Plan? = nil
    var currentPlanId : String? = nil
    
    private var db = Firestore.firestore()
    
    func addPlanToDB(plan: Plan, completionHandler: (Bool) -> Void){
        do{
            let _ = try db.collection("Users").document(Auth.auth().currentUser!.uid).collection("Plan").addDocument(from: plan)
            completionHandler(true)
        }catch{
            print(error)
            completionHandler(false)
        }
    }
    
    func createPlanObject(data: Dictionary<Int,Int>) -> Plan{
        
        var daysPerWeek : Int? = nil
        switch(data[1]!){
        case 1:
            daysPerWeek = 1
        case 2:
            daysPerWeek = 2
        case 3:
            daysPerWeek = 4
        case 4:
            daysPerWeek = 6
        default:
            daysPerWeek = 0
        }
        
        var hoursPerDay : Int? = nil
        switch(data[2]!){
        case 1:
            hoursPerDay = 1
        case 2:
            hoursPerDay = 2
        case 3:
            hoursPerDay = 4
        default:
            hoursPerDay = 0
        }
        let hoursPerWeek : Int = hoursPerDay! * daysPerWeek!
        
        
        let plan : Plan = Plan(weekOn: data[3]!, trickChoice1: data[4]!, trickChoice2: data[5]!, trickChoice3: data[6]!, hoursPerWeek: hoursPerWeek)
        return plan
    }
    
    func fetchData(){
        db.collection("Users").document(Auth.auth().currentUser!.uid).collection("Plan").addSnapshotListener { (documentSnapshot, error) in
            self.plan = documentSnapshot.flatMap { (queryDocumentSnapshot) -> Plan in
                return try! queryDocumentSnapshot.documents[0].data(as: Plan.self)!
            }
        }
        
    }
}
