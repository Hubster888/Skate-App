//
//  PlanWeekTasks.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 02/02/2021.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct PlanWeekTaskModel: Identifiable, Codable{
    
    //MARK: Variable declerations
    @DocumentID var id: String? = UUID().uuidString
    let title : String
    let complete : Bool
    let weekFor : Int
}
