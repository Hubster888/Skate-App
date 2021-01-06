//
//  HomeView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 09/12/2020.
//

import SwiftUI
import Firebase

struct HomeView: View {
    @State var showingDetail = false
    let URL_SAVE_TRICK = "http://192.168.0.13/DBService/Connection.php"
    let URL_GET_TRICK = "http://192.168.0.13/DBService/getTrick.php"
    
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: Text("Detail View")) {
                    Text("Hello World")
                }
                Button(action: {
                    if(Auth.auth().currentUser != nil){
                        logout()
                        showingDetail = false
                    }else{
                        showingDetail = true
                        //show sheet to log in
                    }
                }){
                    if(Auth.auth().currentUser != nil){
                        Text("Sign Out")
                    }else{
                        Text("Log In")
                    }
                }.sheet(isPresented: $showingDetail,
                        content: {
                            LogInView(showingDetail: self.$showingDetail)
                        })
                
                Button(action: {
                    //This is used to add a tuple to the DB.
                    /*let request = NSMutableURLRequest(url: NSURL(string: URL_SAVE_TRICK)! as URL)
                    request.httpMethod = "POST"
                    let postString = "a=test name&b=test description"
                    
                    request.httpBody = postString.data(using: String.Encoding.utf8)
                    
                    let task = URLSession.shared.dataTask(with: request as URLRequest){
                        data, response, error in
                        if error != nil{
                            print("error=\(String(describing: error))")
                            return
                        }
                        
                        print("response=\(String(describing: response))")
                        let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                        print("responseString=\(String(describing: responseString))")
                    }
                    task.resume()
                    
                    let alertController = UIAlertController(title: "Trick", message: "Succesfully added", preferredStyle: UIAlertController.Style.alert)
                    alertController.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
                    print("successful")
                    */
                    
                    //The following is use to get the tuples as an json.
                    /*let request = NSMutableURLRequest(url: NSURL(string: URL_GET_TRICK)! as URL)
                    request.httpMethod = "POST"
                    let json: [String: Any] = ["trickId": "1",
                                               "trickName": "abc",
                                               "trickDescription": "sda"]
                    let jsonData = try? JSONSerialization.data(withJSONObject: json)
                    
                    request.httpBody = jsonData
                    
                    let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
                        if error != nil{
                            print("error=\(String(describing: error))")
                            return
                        }else if let data = data {
                            if let jsonString = String(data: data, encoding: .utf8) {
                                print(jsonString)
                            }
                        }
                    }

                    task.resume()*/
                    
                    TrickLoader().getTrick(trickId: "3"){ result in
                        switch result{
                        case .success(let trick):
                            print(trick)
                        case .failure(let error):
                            print(error)
                        }
                    }
                    
                }, label: {
                    Text("Test")
                })
            }
            .navigationBarTitle("SwiftUI")
        }
    }
        
    func logout(){
        do{
            try Auth.auth().signOut()
        }catch let error as NSError{
            print(error.localizedDescription)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showingDetail: false)
    }
}


