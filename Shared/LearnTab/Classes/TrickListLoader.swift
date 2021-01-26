//
//  TrickListLoader.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 04/01/2021.
//

import Foundation

enum NetworkError: Error {
    case badURL
}

class TrickLoader {
    
    private var str : String = "nope"
    private let URL_GET_ALL_TRICKS : String = "http://192.168.0.13/DBService/getAllTricks.php"
    private let URL_GET_TRICK : String = "http://192.168.0.13/DBService/getTrick.php"
    
    func getAllTrick(dificulty: Int ,completionHandler: @escaping (Result<String, Error>) -> Void) {
        let request = NSMutableURLRequest(url: NSURL(string: URL_GET_ALL_TRICKS)! as URL)
        request.httpMethod = "POST"
        let postString = "trickDificulty=\(dificulty)"
        
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            if error != nil{
                print(error!)
                completionHandler(.failure(NetworkError.badURL))
                return
            }else if let data = data {
                if let jsonString = String(data: data, encoding: .utf8) {
                    completionHandler(.success(jsonString))
                }
            }
        }

        task.resume()
    }
    
    func getTrick(trickId: Int, completionHandler: @escaping (Result<Trick, Error>) -> Void) {
        let request = NSMutableURLRequest(url: NSURL(string: URL_GET_TRICK)! as URL)
        request.httpMethod = "POST"
        let postString = "trickId=\(trickId)"
        
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            if error != nil{
                print(error!)
                completionHandler(.failure(NetworkError.badURL))
                return
            }else if let data = data {
                if let jsonString = String(data: data, encoding: .utf8) {
                    completionHandler(.success(self.stringToTrick(string: jsonString)))
                }
            }
        }

        task.resume()
    }
    
    func stringToTrick(string: String) -> Trick{
        
        var dictonary:NSDictionary?
                
                if let data = string.data(using: String.Encoding.utf8) {
                    
                    do {
                        dictonary = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject] as NSDictionary?
                    
                        if let myDictionary = dictonary
                        {
                            return trickFromDict(dictionary: myDictionary as! Dictionary<String, Any>)
                        }
                    } catch let error as NSError {
                        print(error)
                    }
                }
        return Trick(trickId: 0, trickName: "none", trickDescription: "none", trickTips: "none", footPlacmentImg: "none", trickVideo: "none", trickDificulty: .beginner, trickType: .flipTrick, trickHeadImg: "none")
    }
    
    func trickFromDict(dictionary: Dictionary<String,Any>) -> Trick{
        var trickDificulty : Trick.TrickDificulty
        switch (dictionary["trickDificulty"] as! String){
        case "1":
            trickDificulty = .beginner
            break
        case "2":
            trickDificulty = .doingThisAWhile
            break
        case "3":
            trickDificulty = .pro
            break
        case "4":
            trickDificulty = .godLike
            break
        default:
            trickDificulty = .beginner
        }
        
        var trickType : Trick.TrickType
        switch (dictionary["trickType"] as! String) {
        case "1":
            trickType = .flipTrick
            break
        case "2":
            trickType = .grindTrick
            break
        case "3":
            trickType = .grabTrick
            break
        case "4":
            trickType = .rampTrick
            break
        case "5":
            trickType = .other
        default:
            trickType = .other
        }
        
        return Trick(trickId: Int(dictionary["trickId"] as! String) ?? 0, trickName: dictionary["trickName"] as! String, trickDescription: dictionary["trickDescription"] as! String, trickTips: dictionary["trickTips"] as! String, footPlacmentImg: dictionary["footPlacmentImg"] as! String, trickVideo: dictionary["trickVideo"] as! String, trickDificulty: trickDificulty, trickType: trickType, trickHeadImg: dictionary["trickHead"] as! String)
    }
}
