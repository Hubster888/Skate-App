//
//  PlanModel.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 29/01/2021.
//

import Foundation
import FirebaseFirestoreSwift

struct Plan : Identifiable, Codable{
    @DocumentID var id : String? = UUID().uuidString
    var weekOn : Int
    var trickChoice1 : Int
    var trickChoice2 : Int
    var trickChoice3 : Int
    var hoursPerWeek : Int
    
    init(weekOn: Int, trickChoice1: Int, trickChoice2: Int, trickChoice3: Int, hoursPerWeek: Int){
        self.weekOn = weekOn
        self.trickChoice1 = trickChoice1
        self.trickChoice2 = trickChoice2
        self.trickChoice3 = trickChoice3
        self.hoursPerWeek = hoursPerWeek
    }
}
