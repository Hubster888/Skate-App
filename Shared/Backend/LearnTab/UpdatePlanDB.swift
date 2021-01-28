//
//  UpdatePlanDB.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 26/01/2021.
//

import Foundation
import Firebase

class UpdatePlanDB{
    
    private let URL_GET_GET_HIGHEST_PLAN_ID : String = "http://192.168.0.13/DBService/getHighestPlanId.php"
    private let URL_GET_GET_LOWEST_PLAN_ID : String = "http://192.168.0.13/DBService/getLowestPlanId.php"
    private let URL_CHECK_PLAN_ID_EXISTS : String = "http://192.168.0.13/DBService/checkPlanIdExists.php"
    private let URL_ADD_USER_PLANS : String = "http://192.168.0.13/DBService/addUserPlan.php"
    private let URL_ADD_PLAN : String = "http://192.168.0.13/DBService/addPlan.php"
    private let URL_ADD_PROGRESS : String = "http://192.168.0.13/DBService/addProgressRow.php"
    
    private var UserPlanCheckIsGood : Bool = false
    private var PlanCheckIsGood : Bool = false
    private var bothChecked : Int = 0
    
    /*func getNewPlanId(completionHandler: @escaping (Result<Int, Error>) -> Void){
        getLowestPlanId(){ result in
                var lowestPlanId : Int = 2
                switch(result){
                case .success(let res):
                    lowestPlanId = res
                case .failure(let err):
                    completionHandler(.failure(err))
                }
                if(lowestPlanId >= 2){
                    completionHandler(.success(lowestPlanId - 1))
                }else{
                    var highestPlanId : Int = 0
                    self.getHeighestPlanId(){ resultH in
                        switch(resultH){
                        case .success(let res):
                            highestPlanId = res
                        case .failure(let error):
                            completionHandler(.failure(error))
                        }
                        completionHandler(.success(highestPlanId + 1))
                    }
                }
            }
    }*/
    
    /*func getLowestPlanId(completionHandler: @escaping (Result<Int, Isnt>) -> Void){
        let request = NSMutableURLRequest(url: NSURL(string: URL_GET_GET_LOWEST_PLAN_ID)! as URL)
        request.httpMethod = "POST"
        
        //request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            if error != nil{
                print(error!)
                completionHandler(.failure(1))
                return
            }else if let data = data {
                if var jsonString = String(data: data, encoding: .utf8) {
                    jsonString = jsonString.trimmingCharacters(in: CharacterSet(charactersIn: "0123456789.").inverted)
                    completionHandler(.success(Int(jsonString)!))
                }
            }
        }

        task.resume()
    }*/
    
    /*func getHeighestPlanId(completionHandler: @escaping (Result<Int, Int>) -> Void){
        let request = NSMutableURLRequest(url: NSURL(string: URL_GET_GET_HIGHEST_PLAN_ID)! as URL)
        request.httpMethod = "POST"
        
        //request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            if error != nil{
                print(error!)
                completionHandler(.failure(1))
                return
            }else if let data = data {
                if var jsonString = String(data: data, encoding: .utf8) {
                    jsonString = jsonString.trimmingCharacters(in: CharacterSet(charactersIn: "0123456789.").inverted)
                    completionHandler(.success(Int(jsonString)!))
                }
            }
        }

        task.resume()
    }*/
    
    func checkIdDoesNotExist(planId: Int, tableName: String, completionHandler: @escaping (Bool) -> Void){
        let request = NSMutableURLRequest(url: NSURL(string: URL_CHECK_PLAN_ID_EXISTS)! as URL)
        request.httpMethod = "POST"
        
        let postString = "planId=\(planId)&tableName=\(tableName)"
        
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            
            
            
            if error != nil{
                print(error!)
                completionHandler(false)
                return
            }else if let data = data {
                if let jsonString = String(data: data, encoding: .utf8) {
                    if(jsonString == "0 results"){
                        completionHandler(true)
                       
                    }else{
                        completionHandler(false)
                        
                    }
                }
            }
        }

        task.resume()
    }
    
    /*func check(planId: Int, completionHandler: @escaping (Bool) -> Void){
        checkIdDoesNotExist(planId: planId, tableName: "UserPlans"){ result in
            switch(result){
            case .success(let res):
                completionHandler(res)
                
            case .failure(_ ):
                completionHandler(false)
                
            }
        }
    }
    
    func check2(planId: Int, completionHandler: @escaping (Bool) -> Void){
        checkIdDoesNotExist(planId: planId, tableName: "Plans"){ result in
            switch(result){
            case .success(let res):
                completionHandler(res)
            case .failure(_ ):
                completionHandler(false)
            }
        }
    }*/
    
    func check3(planId: Int, completionHandler: @escaping (Bool) -> Void){
        let request = NSMutableURLRequest(url: NSURL(string: URL_ADD_USER_PLANS)! as URL)
        request.httpMethod = "POST"
        let postString = "userId=\(Auth.auth().currentUser?.uid ?? "None")&planId=\(planId)"
        
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            if error != nil{
                print(error!)
                completionHandler(false)
                return
            }else if let data = data {
                if let jsonString = String(data: data, encoding: .utf8) {
                    if(jsonString == "true"){
                        completionHandler(true)
                    }else{
                        completionHandler(false)
                    }
                }
            }
        }

        task.resume()
    }
    
   /* func addToUserPlans(planId: Int, completionHandler: @escaping (Bool) -> Void){
        
        check(planId: planId){ planIdExists in
            if planIdExists {
                self.check2(planId: planId){ planIdExists2 in
                    if planIdExists2 {
                        self.check3(planId: planId){ planIdExists3 in
                            completionHandler(planIdExists3)
                        }
                    }else{
                        completionHandler(false)
                    }
                }
            }else{
                completionHandler(false)
            }
        }
    }*/
    
    func addProgressRow(completionHandler: @escaping (Result<Int, Error>) -> Void){
        
    }
}
