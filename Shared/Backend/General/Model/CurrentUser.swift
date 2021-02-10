//
//  User.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 27/01/2021.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct CurrentUser: Identifiable, Codable {
    @DocumentID var id: String? = UUID().uuidString
    var planStarted : Bool
    var email : String
}
