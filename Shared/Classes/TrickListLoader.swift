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
    
    func getTrick(trickId: String, completionHandler: @escaping (Result<Dictionary<String,Any>, Error>) -> Void) {
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
                    completionHandler(.success(self.stringToArray(string: jsonString)))
                }
            }
        }

        task.resume()
    }
    
    func stringToArray(string: String) -> Dictionary<String,Any>{
        
        var dictonary:NSDictionary?
                
                if let data = string.data(using: String.Encoding.utf8) {
                    
                    do {
                        dictonary = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject] as NSDictionary?
                    
                        if let myDictionary = dictonary
                        {
                            return myDictionary as! Dictionary<String, Any>
                        }
                    } catch let error as NSError {
                        print(error)
                    }
                }
        return [:]
    }
}
