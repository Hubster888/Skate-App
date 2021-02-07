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
    @Published var tasks = [PlanWeekTaskModel]()
    var currentPlanId : String? = nil
    
    private var db = Firestore.firestore()
    
    func addPlanToDB(plan: Plan, completionHandler: (Bool) -> Void){
        do{
            let _ = try db.collection("Users").document(Auth.auth().currentUser!.uid).collection("Plan").document("plan").setData(from: plan)
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
            daysPerWeek = 3
        case 2:
            daysPerWeek = 5
        case 3:
            daysPerWeek = 7
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
        db.collection("Users").document(Auth.auth().currentUser!.uid).collection("Plan").document("plan").addSnapshotListener { (documentSnapshot, error) in
            self.plan = documentSnapshot.flatMap { (queryDocumentSnapshot) -> Plan in
                return try! queryDocumentSnapshot.data(as: Plan.self)!
            }
        }
    }
    
    func moveToNextWeek(){
        let newWeekOn = plan!.weekOn + 1
        db.collection("Users").document(Auth.auth().currentUser!.uid).collection("Plan").document("plan").updateData(["weekOn":newWeekOn])
    }
    
    func endPlan(){
        db.collection("Users").document(Auth.auth().currentUser!.uid).collection("Data").document("data").updateData([
            "planStarted": false
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    func fetchDataTasks(){
        db.collection("Users").document(Auth.auth().currentUser!.uid).collection("Plan").document("plan").collection("Tasks").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else{
                print("No Documents!")
                return
            }
            self.tasks = documents.compactMap { (queryDocumentSnapshot) -> PlanWeekTaskModel in
                return try! queryDocumentSnapshot.data(as: PlanWeekTaskModel.self)!
            }
        }
    }
    
    func setData(){
        let taskLists : [[String]] = [["Ride Around", "Moving Hippy Jump", "Standing Ollie"],["Ride Around", "Moving Ollie", plan!.trickChoice3 == 1 ? "Power Slide" : "Manual", "Hippy Jump"],["Ride Around", plan!.trickChoice3 == 1 ? "Power Slide" : "Manual", "Standing \(plan!.trickChoice1 == 1 ? "Pop Shove It" : "Kick Flip")", "Moving Ollie", "Standing \(plan!.trickChoice2 == 2 ? "Casper Flip" : "Heel Flip")"],["Ride Around", "Moving Ollie", plan!.trickChoice3 == 1 ? "Power Slide" : "Manual", "Moving \(plan!.trickChoice1 == 1 ? "Pop Shove It" : "Kick Flip")", "Moving \(plan!.trickChoice2 == 2 ? "Casper Flip" : "Heel Flip")", "Ollie Over Obstacle"],["Ride Around", "Ollie Off A Curb", "Moving \(plan!.trickChoice2 == 2 ? "Casper Flip" : "Heel Flip")", "Moving \(plan!.trickChoice1 == 1 ? "Pop Shove It" : "Kick Flip")", plan!.trickChoice3 == 1 ? "Power Slide" : "Manual", "\(plan!.trickChoice1 == 1 ? "Pop Shove It" : "Kick Flip") Over A Obstacle"],["Ride Around", "\(plan!.trickChoice2 == 2 ? "Casper Flip" : "Heel Flip") Over Obstacle", "\(plan!.trickChoice1 == 1 ? "Pop Shove It" : "Kick Flip") Off A Curb", plan!.trickChoice3 == 1 ? "Power Slide" : "Manual", "Ollie Onto A Curb"],["Ride Around", "Ollie Onto A Low Rail/ Ledge Into A 50-50 Grind", plan!.trickChoice3 == 1 ? "Power Slide" : "Manual", "\(plan!.trickChoice2 == 2 ? "Casper Flip" : "Heel Flip") Off A Curb", "\(plan!.trickChoice1 == 1 ? "Pop Shove It" : "Kick Flip") Onto A Curb"],["Ride Around", plan!.trickChoice3 == 1 ? "Power Slide" : "Manual", "\(plan!.trickChoice2 == 2 ? "Casper Flip" : "Heel Flip") Onto A Curb", "Ollie Off A Small Stair Set", "\(plan!.trickChoice1 == 1 ? "Pop Shove It" : "Kick Flip") Off A Small Stair Set", "Moving 180 Ollie"]]
        
        var taskList = [PlanWeekTaskModel]()
        for i in 0...taskLists.count - 1{
            for j in 0...taskLists[i].count - 1{
                taskList.append(PlanWeekTaskModel(title: taskLists[i][j], complete: false, weekFor: i + 1))
            }
        }
        for i in 0...taskList.count - 1{
            do{
                let _ = try db.collection("Users").document(Auth.auth().currentUser!.uid).collection("Plan").document("plan").collection("Tasks").addDocument(from: taskList[i])
            }catch{
                print(error)
            }
        }
    }
    
    func toogleTaskComplete(docId: String){
        for i in 0...tasks.count - 1{
            if(tasks[i].id == docId){
                if(tasks[i].complete){
                    db.collection("Users").document(Auth.auth().currentUser!.uid).collection("Plan").document("plan").collection("Tasks").document(docId).updateData(["complete" : false])
                }else{
                    db.collection("Users").document(Auth.auth().currentUser!.uid).collection("Plan").document("plan").collection("Tasks").document(docId).updateData(["complete" : true])
                }
            }
        }
    }
    
    func calculateHours(hoursPerWeek: Int, weekFor: Int) -> Float{
        var numOfTasks = 0
        for task in tasks{
            if(task.weekFor == weekFor){
                numOfTasks += 1
            }
        }
        return Float(hoursPerWeek / numOfTasks)
    }
}
