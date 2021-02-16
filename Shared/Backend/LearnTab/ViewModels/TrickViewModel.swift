//
//  TrickViewModel.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 27/01/2021.
//

import Foundation
import FirebaseFirestore
import Firebase
import Combine
import CombineFirebase

class TrickViewModel : ObservableObject {
    var cancelBag = Set<AnyCancellable>()
    
    @Published var tricks = [Trick]()
    @Published var beginnerTricks = [Trick]()
    @Published var doingThisAWhileTricks = [Trick]()
    @Published var proTricks = [Trick]()
    @Published var godlikeTricks = [Trick]()
    
    @Published var currentTrick : Trick? = nil
    @Published var currentHeadImg : UIImage? = nil
    @Published var currentFootImg : UIImage? = nil
    @Published var currentVid : URL? = nil
    @Published var teamLogoImage : UIImage? = nil
    
    
    private var db = Firestore.firestore()
    
    func addTrickToDB(trick : Trick){
        let _ = db.collection("Tricks").addDocument(from: trick)
    }
    
    func getTrickComplete(trick: Trick) -> [Bool]{
        if(Auth.auth().currentUser == nil){
            return [false,false,false,false]
        }
        var result = [false,false,false,false]
        // get trick doc id
        let docId = trick.id
        // Look at user, look under tricks, look for trick ID that match, if id matches then get the four values
        db.collection("Users").document(Auth.auth().currentUser?.uid ?? "NO USER")
            .collection("Tricks").document(docId!).getDocument() { (document,error) in
                if(error == nil){
                    for i in 0...3{
                        result[i] = document?.get(String(i)) as? Bool ?? false
                    }
                }else{
                    print("Eeerrrrrooorrrrrr")
                }
        }
        // If the trick id not found then that means the result is all false.
        return result
    }
    
    func updateTrickTab(tabDiff: Int) -> [Trick]{
        switch tabDiff{
        case 1:
            return self.beginnerTricks
        case 2:
            return self.doingThisAWhileTricks
        case 3:
            return self.proTricks
        case 4:
            return self.godlikeTricks
        default:
            return self.tricks
        }
    }
    
    func setCurrentTrick(id: String) {
        self.currentTrick = tricks.filter{ $0.id == id}.first
        getImage(name: self.currentTrick!.headImg, place: 1)
        getImage(name: self.currentTrick!.placmentImg, place: 2)
        getVid(name: self.currentTrick!.video)
    }
    
    func getVid(name: String){
        let reference = Storage.storage().reference(forURL: "gs://skateapp-a9f84.appspot.com/AppAssets/Videos/\(name)")
            
        // Fetch the download URL
        (reference.downloadURL() as AnyPublisher<URL, Error>)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: print("🏁 finished")
                case .failure(let error): print(error)// Uh-oh, an error occurred!
                }
            }) { data in
                self.currentVid = data
            }
            .store(in: &cancelBag)
    }
    
    func getImage(name: String, place: Int){
        let reference = Storage.storage().reference(forURL: "gs://skateapp-a9f84.appspot.com/AppAssets/Images/\(name)")
            
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        (reference.getData(maxSize: 1 * 1024 * 1024) as AnyPublisher<Data, Error>)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: print("🏁 finished")
                case .failure(let error): print(error)// Uh-oh, an error occurred!
                }
            }) { data in
                if(place == 1){
                    self.currentHeadImg = UIImage(data: data)
                }else if(place == 2){
                    self.currentFootImg = UIImage(data: data)
                }else if(place == 3){
                    self.teamLogoImage = UIImage(data: data)
                }
            }
            .store(in: &cancelBag)
    }
    
    //MARK: Getting the images using Combine

    var trickDocumentSnapshotMapper: (DocumentSnapshot) throws -> Trick? {
        {
            let trick =  try $0.data(as: Trick.self)
            return trick
        }
    }
    
    func listenCollectionAsObject() {
        db.collection("Tricks")
            .publisher(as: Trick.self, documentSnapshotMapper: trickDocumentSnapshotMapper)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: print("🏁 finished")
                case .failure(let error): print("❗️ failure: \(error)")
                }
            }) { tricksList in
                self.beginnerTricks = tricksList.filter { $0.difficulty == 1}
                self.doingThisAWhileTricks = tricksList.filter { $0.difficulty == 2}
                self.proTricks = tricksList.filter { $0.difficulty == 3}
                self.godlikeTricks = tricksList.filter { $0.difficulty == 4}
                self.tricks = tricksList
            }.store(in: &cancelBag)
    }
    
    func typeToString(type: Int) -> String{
        switch type {
        case 1:
            return "Flip trick"
        case 3:
            return "Grab and air"
        case 2:
            return "Grind and slide"
        case 4:
            return "Ramp and foot plant"
        case 5:
            return "Other"
        case 6:
            return "Wrong"
        default:
            return "0"
        }
    }
    
    func tidyText(string: String) -> String{
        let newString = string.replacingOccurrences(of: "--n--", with: "\n", options: .literal, range: nil)
        let array = newString.components(separatedBy: "Steps:")
        return array[0]
    }
    
    func tipsToArray(string: String, type: Int) -> [String]{
        if(type == 1){
            let steps = string.components(separatedBy: "Steps:")[1]
            let array = steps.components(separatedBy: "--n--")
            return array
        }else{
            let array = string.components(separatedBy: "--n--")
            return array
        }
    }
    
}
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
