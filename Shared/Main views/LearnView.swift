//
//  LearnView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 09/12/2020.
//

import SwiftUI
import Firebase

struct LearnView: View {
    
    @State private var tricksIsActive = false
    @State private var gamesIsActive = false
    @State private var planIsActive = false
    @State private var planIntroIsActive = false
    
    @State private var planStarted : Bool = false
    @State private var planSeen : Bool = false
    
    private let URL_GET_USER_INFO : String = "http://192.168.0.13/DBService/getUserInfo.php"
    
    var width: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    var height: CGFloat {
        return UIScreen.main.bounds.height
    }

    init(){
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.0)]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.0)]
        navBarAppearance.barTintColor = UIColor(red: 0.13, green: 0.15, blue: 0.22, alpha: 1.0)
        
        UITabBar.appearance().backgroundColor = UIColor(red: 0.13, green: 0.15, blue: 0.22, alpha: 1.0)
        
        UITabBar.appearance().barTintColor = UIColor(red: 0.13, green: 0.15, blue: 0.22, alpha: 1.0)
    }
    
    var body: some View {
        NavigationView {
            ZStack{
                Color(red: 0.96, green: 0.96, blue: 0.96).edgesIgnoringSafeArea(.all)
                Rectangle()
                    .fill(Color(red: 0.13, green: 0.15, blue: 0.22))
                    .frame(width: 30, height: UIScreen.screenHeight)
                    .offset(x: width * -0.25)
                VStack{
                    if(planStarted){
                        NavigationLink(destination: PlanView(rootIsActive: self.$planIsActive), isActive: $planIsActive) {
                            VStack{
                                Text("PLAN")
                                    .font(.system(size: width * 0.1, weight: .bold, design: .monospaced))
                                    .foregroundColor(Color(red: 0.13, green: 0.15, blue: 0.22))
                                                
                                Text("Personalise your learning!")
                                    .font(.system(size: width * 0.03, weight: .bold, design: .default))
                                    .foregroundColor(Color(red: 0.28, green: 0.32, blue: 0.37))
                                    .frame(width: width * 0.4, alignment: .center)
                                    .multilineTextAlignment(.center)
                                    
                            }.frame(alignment: .trailing)
                        }.buttonStyle(LearnButtonEffectButtonStyle(image: Image("learnPlanButton"), action: { self.planIsActive.toggle()}))
                    }else{
                        NavigationLink(destination: PlanIntroView(rootIsActive: self.$planIntroIsActive), isActive: $planIntroIsActive) {
                            VStack{
                                Text("PLAN")
                                    .font(.system(size: width * 0.1, weight: .bold, design: .monospaced))
                                    .foregroundColor(Color(red: 0.13, green: 0.15, blue: 0.22))
                                                
                                Text("Personalise your learning!")
                                    .font(.system(size: width * 0.03, weight: .bold, design: .default))
                                    .foregroundColor(Color(red: 0.28, green: 0.32, blue: 0.37))
                                    .frame(width: width * 0.4, alignment: .center)
                                    .multilineTextAlignment(.center)
                                    
                            }.frame(alignment: .trailing)
                        }
                        .isDetailLink(false)
                        .buttonStyle(LearnButtonEffectButtonStyle(image: Image("learnPlanButton"), action: { self.planIntroIsActive.toggle()}))
                    }
                    
                            
                    NavigationLink(destination: TrickSelectView(), isActive: $tricksIsActive) {
                        VStack{
                            Text("TRICKS")
                                .font(.system(size: width * 0.1, weight: .bold, design: .monospaced))
                                .foregroundColor(Color(red: 0.13, green: 0.15, blue: 0.22))
                                                
                            Text("Find the tricks here!")
                                .font(.system(size: width * 0.03, weight: .bold, design: .default))
                                .foregroundColor(Color(red: 0.28, green: 0.32, blue: 0.37))
                                .frame(width: width * 0.4, alignment: .center)
                                .multilineTextAlignment(.center)
                            
                        }
                        .frame(alignment: .trailing)
                    }.buttonStyle(LearnButtonEffectButtonStyle(image: Image("learnTricksButton"), action: { self.tricksIsActive.toggle()}))
                    
                            
                    NavigationLink(destination: GameSelectView(), isActive: $gamesIsActive) {
                        VStack{
                            Text("GAMES")
                                .font(.system(size: width * 0.1, weight: .bold, design: .monospaced))
                                .foregroundColor(Color(red: 0.13, green: 0.15, blue: 0.22))
                                                
                            Text("Play skating games with friends or solo!")
                                .font(.system(size: width * 0.03, weight: .bold, design: .default))
                                .foregroundColor(Color(red: 0.28, green: 0.32, blue: 0.37))
                                .frame(width: width * 0.4, alignment: .center)
                                .multilineTextAlignment(.center)
                            
                        }.frame(alignment: .trailing)
                    }
                    .buttonStyle(LearnButtonEffectButtonStyle(image: Image("learnGamesButton"), action: { self.gamesIsActive.toggle()}))
                    .padding(.bottom, -height * 0.075)
                }.frame(width: width, height: height, alignment: .center)
            }
            .navigationBarTitle(Text("Learn"), displayMode: .inline)
            .navigationBarItems( trailing: NavigationLink(destination: settingsView()) {
                Image(systemName: "gear")
                    .foregroundColor(Color(red: 0.96, green: 0.96, blue: 0.96))
            })
            .onAppear() {
                print(String(describing: planSeen))
                userHasPlan(dataNeeded: "planStarted")
                userHasPlan(dataNeeded: "planSeen")
                
                UINavigationBar.appearance().barTintColor = UIColor(red: 0.13, green: 0.15, blue: 0.22, alpha: 1.0)
            }
        }
    }
    
    func userHasPlan(dataNeeded: String){
        getUserData(dataNeeded: dataNeeded){ result in
            switch(result){
            case .success(let res):
                if(res == "1"){
                    if(dataNeeded == "planStarted"){
                        planStarted = true
                    }else if(dataNeeded == "planSeen"){
                        planSeen = true
                    }
                }
                
                if(res == "0"){
                    if(dataNeeded == "planStarted"){
                        planStarted = false
                    }else if(dataNeeded == "planSeen"){
                        planSeen = false
                    }
                }
            case .failure(let err):
                print(err)
                planStarted = true
            }
        }
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }

    
    func getUserData(dataNeeded: String, completionHandler: @escaping (Result<String, Error>) -> Void) {
        let request = NSMutableURLRequest(url: NSURL(string: URL_GET_USER_INFO)! as URL)
        request.httpMethod = "POST"
        let postString = "userId=\(Auth.auth().currentUser?.uid ?? "None")&dataNeeded=\(dataNeeded)"
        
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            if error != nil{
                print(error!)
                completionHandler(.failure(NetworkError.badURL))
                return
            }else if let data = data {
                if var jsonString = String(data: data, encoding: .utf8) {
                    jsonString = jsonString.trimmingCharacters(in: CharacterSet(charactersIn: "0123456789.").inverted)
                    completionHandler(.success(jsonString))
                }
            }
        }

        task.resume()
    }
}
;extension UIScreen{
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}

struct LearnView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LearnView()
                .previewDevice("iPhone 12 Pro Max")
        }
    }
}
