//
//  TrickViewModel.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 27/01/2021.
//

import Foundation
import FirebaseFirestore
import Firebase

class TrickViewModel : ObservableObject {
    @Published var tricks = [Trick]()
    @Published var beginnerTricks = [Trick]()
    @Published var doingThisAWhileTricks = [Trick]()
    @Published var proTricks = [Trick]()
    @Published var godlikeTricks = [Trick]()
    
    private var db = Firestore.firestore()
    
    func addTrickToArray(documents: [QueryDocumentSnapshot], difficulty: Int){

        switch difficulty {
        case 1:
            self.beginnerTricks = documents.compactMap { (queryDocumentSnapshot) -> Trick in
                return try! queryDocumentSnapshot.data(as: Trick.self)!
            }
        case 2:
            self.doingThisAWhileTricks = documents.map { (queryDocumentSnapshot) -> Trick in
                return try! queryDocumentSnapshot.data(as: Trick.self)!
            }
        case 3:
            self.proTricks = documents.map { (queryDocumentSnapshot) -> Trick in
                return try! queryDocumentSnapshot.data(as: Trick.self)!
            }
        case 4:
            self.godlikeTricks = documents.map { (queryDocumentSnapshot) -> Trick in
                return try! queryDocumentSnapshot.data(as: Trick.self)!
            }
        default:
            print("Wrong difficulty")
        }
        
    }
    
    func fetchData(){
        for i in 1...4{
            db.collection("Tricks").whereField("difficulty", in: [i]) .addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else{
                    print("No Documents!")
                    return
                }
                self.addTrickToArray(documents: documents, difficulty: i)
            }
        }
    }
    
    func addTrickToDB(trick : Trick){
        let _ = db.collection("Tricks").addDocument(from: trick)
    }
    
    func getTrickComplete(trick: Trick) -> [Bool]{
        if(Auth.auth().currentUser == nil){
            return [false,false,false,false]
        }
        var result = [false,false,false,false]
        // get trick doc id
        let docId = trick.id
        // Look at user, look under tricks, look for trick ID that match, if id matches then get the four values
        db.collection("Users").document(Auth.auth().currentUser?.uid ?? "NO USER")
            .collection("Tricks").document(docId!).getDocument() { (document,error) in
                if(error == nil){
                    for i in 0...3{
                        result[i] = document?.get(String(i)) as? Bool ?? false
                    }
                }else{
                    print("Eeerrrrrooorrrrrr")
                }
        }
        // If the trick id not found then that means the result is all false.
        return result
    }
}
