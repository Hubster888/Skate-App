//
//  PlanViewModel.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 29/01/2021.
//

import Foundation
import Firebase
import FirebaseFirestore

class PlanViewModel : ObservableObject{
    
    //MARK: Variable declerations
    @Published var plan : Plan? = nil
    @Published var tasks = [PlanWeekTaskModel]()
    var currentPlanId : String? = nil
    private var db = Firestore.firestore()
    
    //MARK: Modifiers
    // Uploads the plan to firestore
    func addPlanToDB(plan: Plan, completionHandler: (Bool) -> Void){
        let _ = db.collection("Users").document(Auth.auth().currentUser!.uid).collection("Plan").document("plan").setData(from: plan)
        completionHandler(true)
    }
    
    // Changes the current week on plan in firestore
    func moveToNextWeek(forward: Bool){
        let ref = db.collection("Users").document(Auth.auth().currentUser?.uid ?? "NO USER").collection("Plan").document("plan")
        ref.getDocument(){(doc,err) in
            if (err != nil) {
                print(err!)
                return
            }
            let newWeekOn = doc?.get("weekOn") as! Int + (forward ? 1 : -1)
            let _ = ref.updateData(["weekOn": newWeekOn]).description
        }
    }
    
    // Sets planstarted to fals in firestore to show a plan is not active
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
    
    // Changes the status of a task in firestore
    func toogleTaskComplete(docId: String){
        let ref = db.collection("Users").document(Auth.auth().currentUser?.uid ?? "NO USER").collection("Plan").document("plan").collection("Tasks").document(docId)
        for i in 0...tasks.count - 1{
            if(tasks[i].id == docId){
                if(tasks[i].complete){
                   let _ = ref.updateData(["complete" : false]).description
                }else{
                    let _ = ref.updateData(["complete" : true]).description
                }
            }
        }
    }
    
    //MARK: Getters
    // Fetch the plan data from firestore
    func fetchData(){
        db.collection("Users").document(Auth.auth().currentUser!.uid).collection("Plan").document("plan").addSnapshotListener { (documentSnapshot, error) in
            self.plan = documentSnapshot.flatMap { (queryDocumentSnapshot) -> Plan in
                return try! queryDocumentSnapshot.data(as: Plan.self)!
            }
        }
    }
    
    // Fetch tasks from firestore
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
    
    //MARK: Setters
    // Sets a new plan for the user based on their answers
    func setData(){
        let dbRef = db.collection("Users").document(Auth.auth().currentUser?.uid ?? "NO USER").collection("Plan").document("plan").collection("Tasks")
        
        // Data to be set
        let taskLists : [[String]] = [["Ride Around", "Moving Hippy Jump", "Standing Ollie"],["Ride Around", "Moving Ollie", plan!.trickChoice3 == 1 ? "Power Slide" : "Manual", "Hippy Jump"],["Ride Around", plan!.trickChoice3 == 1 ? "Power Slide" : "Manual", "Standing \(plan!.trickChoice1 == 1 ? "Pop Shove It" : "Kick Flip")", "Moving Ollie", "Standing \(plan!.trickChoice2 == 1 ? "Casper Flip" : "Heel Flip")"],["Ride Around", "Moving Ollie", plan!.trickChoice3 == 1 ? "Power Slide" : "Manual", "Moving \(plan!.trickChoice1 == 1 ? "Pop Shove It" : "Kick Flip")", "Moving \(plan!.trickChoice2 == 2 ? "Casper Flip" : "Heel Flip")", "Ollie Over Obstacle"],["Ride Around", "Ollie Off A Curb", "Moving \(plan!.trickChoice2 == 1 ? "Casper Flip" : "Heel Flip")", "Moving \(plan!.trickChoice1 == 1 ? "Pop Shove It" : "Kick Flip")", plan!.trickChoice3 == 1 ? "Power Slide" : "Manual", "\(plan!.trickChoice1 == 1 ? "Pop Shove It" : "Kick Flip") Over A Obstacle"],["Ride Around", "\(plan!.trickChoice2 == 1 ? "Casper Flip" : "Heel Flip") Over Obstacle", "\(plan!.trickChoice1 == 1 ? "Pop Shove It" : "Kick Flip") Off A Curb", plan!.trickChoice3 == 1 ? "Power Slide" : "Manual", "Ollie Onto A Curb"],["Ride Around", "Ollie Onto A Low Rail/ Ledge Into A 50-50 Grind", plan!.trickChoice3 == 1 ? "Power Slide" : "Manual", "\(plan!.trickChoice2 == 1 ? "Casper Flip" : "Heel Flip") Off A Curb", "\(plan!.trickChoice1 == 1 ? "Pop Shove It" : "Kick Flip") Onto A Curb"],["Ride Around", plan!.trickChoice3 == 1 ? "Power Slide" : "Manual", "\(plan!.trickChoice2 == 1 ? "Casper Flip" : "Heel Flip") Onto A Curb", "Ollie Off A Small Stair Set", "\(plan!.trickChoice1 == 1 ? "Pop Shove It" : "Kick Flip") Off A Small Stair Set", "Moving 180 Ollie"]]
        
        //Remove old set of tasks
        dbRef.getDocuments(){ (docs,err) in
            // Get array of all doc ids
            var docIdArray : [String] = [String]()
            if((docs?.documents.count)! > 0){
                for i in 0...(docs?.documents.count)! - 1{
                    docIdArray.append((docs?.documents[i].documentID)!)
                }
                // Go through each doc id and remove it from firestore
                for i in 0...docIdArray.count - 1{
                    dbRef.document(docIdArray[i]).delete(){res in
                        print(res ?? "NO ERROR")
                    }
                }
            }
            
            // Adds the task list to an array of Task models
            var taskList = [PlanWeekTaskModel]()
            for i in 0...taskLists.count - 1{
                for j in 0...taskLists[i].count - 1{
                    taskList.append(PlanWeekTaskModel(title: taskLists[i][j], complete: false, weekFor: i + 1))
                }
            }
            
            // Adds the tasks from task list to the db
            for i in 0...taskList.count - 1{
                let _ = dbRef.addDocument(from: taskList[i])
            }
        }
    }
    
    //MARK: Other
    // Transforms a set of answers into a object to be saved in firestore
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
    
    // Calculates the number of hours a task is to be done for
    func calculateHours(hoursPerWeek: Int, weekFor: Int, task: PlanWeekTaskModel) -> Float{
        var numOfTasks = 0
        for task in tasks{
            if(task.weekFor == weekFor){
                numOfTasks += 1
            }
        }
        if(task.title.contains("Over")){
            let res = Float(hoursPerWeek / numOfTasks) + 1.0
            return res > 3 ? 3 : res
        }else if(task.title.contains("Ride")){
            let res = Float(hoursPerWeek / numOfTasks) - 1.0
            return res > 3 ? 3 : res
        }else if(task.title.contains("Low")){
            let res = Float(hoursPerWeek / numOfTasks) + 2.0
            return res > 3 ? 3 : res
        }else if(task.title.contains("Hippy")){
            let res = Float(hoursPerWeek / numOfTasks) - 2.0
            return res > 3 ? 3 : res
        }else{
            let res = Float(hoursPerWeek / numOfTasks)
            return res > 3 ? 3 : res
        }
    }
}
