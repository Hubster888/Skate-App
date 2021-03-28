//
//  Trick.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 11/01/2021.
//

import Foundation
import FirebaseFirestoreSwift

struct Trick : Identifiable, Codable {
    
    //MARK: Variable declerations
    @DocumentID var id: String? = UUID().uuidString
    var name : String
    var description : String
    var tips : String
    var placmentImg : String
    var video : String
    var difficulty : Int
    var type : Int
    var headImg : String
}

// TODO: Make these mean something
enum TrickError: Error {
  case statusCode
  case decoding
  case invalidImage
  case invalidURL
  case other(Error)
  
  static func map(_ error: Error) -> TrickError {
    return (error as? TrickError) ?? .other(error)
  }
}

// The possibilities of trick didiculty
enum TrickDificulty {
    case beginner
    case doingThisAWhile
    case pro
    case godLike
    case none
}

// The trick types
enum TrickType {
    case flipTrick
    case grindTrick
    case rampTrick
    case grabTrick
    case other
    case none
}
