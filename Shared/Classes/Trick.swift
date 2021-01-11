//
//  Trick.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 11/01/2021.
//

import Foundation

class Trick{
    
    enum TrickDificulty {
        case beginner
        case doingThisAWhile
        case pro
        case godLike
    }
    
    enum TrickType {
        case flipTrick
        case grindTrick
        case rampTrick
        case grabTrick
        case other
    }
    
    private let trickId : Int
    private let trickName : String
    private let trickDescription : String
    private let trickTips : String
    private let footPlacmentImg : String
    private let trickVideo : String
    private let trickDificulty : TrickDificulty
    private let trickType : TrickType
    private let trickHeadImg : String
    
    init(trickId: Int, trickName: String, trickDescription: String, trickTips: String,
         footPlacmentImg: String, trickVideo: String, trickDificulty: TrickDificulty,
         trickType: TrickType, trickHeadImg: String){
        self.trickId = trickId
        self.trickName = trickName
        self.trickDescription = trickDescription
        self.trickTips = trickTips
        self.footPlacmentImg = footPlacmentImg
        self.trickVideo = trickVideo
        self.trickDificulty = trickDificulty
        self.trickType = trickType
        self.trickHeadImg = trickHeadImg
    }
    
    public func getTrickId() -> Int{
        return self.trickId
    }
    
    public func getTrickName() -> String{
        return self.trickName
    }
    
    public func getTrickDescription() -> String{
        return self.trickDescription
    }
    
    public func getTrickTips() -> String{
        return self.trickTips
    }
    
    public func getFootPlacmentImg() -> String{
        return self.footPlacmentImg
    }
    
    public func getTrickVideo() -> String{
        return self.trickVideo
    }
    
    public func getTrickDificulty() -> TrickDificulty{
        return self.trickDificulty
    }
    
    public func getTrickHeadImg() -> String{
        return self.trickHeadImg
    }
    
    public func getTrickType() -> TrickType{
        return self.trickType
    }
}
