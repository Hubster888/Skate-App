//
//  PlanView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 14/01/2021.
//

import SwiftUI

struct PlanView: View {
    @Binding var rootIsActive : Bool
    
    var btnBack : some View { Button(action: {
            self.rootIsActive = false
            }) {
                HStack {
                Image("ic_back") // set image here
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
                    Text("Go back")
                }
            }
        }
    
    var body: some View {
        Text("Hello, Plan!")
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: btnBack)
    }

}
