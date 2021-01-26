//
//  LogInView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 27/12/2020.
//

import SwiftUI
import GoogleSignIn
import Firebase

struct LogInView: View {
    @Binding var showingDetail : Bool
    private let URL_ADD_USER : String = "http://192.168.0.13/DBService/addUser.php"
    
    var body: some View {
        google().frame(width: 120, height: 50)
        Button(action: {
            addUser(){ result in
                switch(result){
                case .success( _):
                    self.showingDetail = false
                case .failure(let err):
                    print(err)
                }
            }
                
            
        }){
            Text("Done")
        }
    }
    
    func addUser(completionHandler: @escaping (Result<String, Error>) -> Void) {
        let request = NSMutableURLRequest(url: NSURL(string: URL_ADD_USER)! as URL)
        request.httpMethod = "POST"
        let postString = "a=\(Auth.auth().currentUser?.uid ?? "No value")&b=\(Auth.auth().currentUser?.email ?? "No email")"
        
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
}

struct google: UIViewRepresentable{
    func makeUIView(context: UIViewRepresentableContext<google>) -> GIDSignInButton {
        let button = GIDSignInButton()
        button.colorScheme = .dark
        GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.last?.rootViewController
        return button
    }
    
    func updateUIView(_ uiView: GIDSignInButton, context: UIViewRepresentableContext<google>) {
        
    }
}
