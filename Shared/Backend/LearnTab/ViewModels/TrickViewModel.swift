//
//  TrickViewModel.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 27/01/2021.
//

import Foundation
import FirebaseFirestore

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
        do{
            let _ = try db.collection("Tricks").addDocument(from: trick)
        }catch{
            print(error)
        }
    }
}
