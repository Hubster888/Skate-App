//
//  TrickListView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 16/02/2021.
//

import SwiftUI

struct TrickListView: View {
    @EnvironmentObject private var trickViewModel : TrickViewModel
    let tabDiff : Int
    @State var showingTrick = false
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    var body: some View {
        switch tabDiff {
        case 1:
            ForEach(trickViewModel.beginnerTricks){ trick in
                let trickComplete = TrickViewModel().getTrickComplete(trick: trick)
                let trickDocId = trick.id
                Button(action: {
                    trickViewModel.setCurrentTrick(id: trickDocId!)
                    showingTrick = true
                }){
                    TrickRowView(trickName: trick.name, trickType: trick.type, trickComplete: trickComplete, width: width, height: height).padding(.top, height * 0.0125).environmentObject(self.trickViewModel)
                }
                .buttonStyle(ScaleAnimationButtonEffect())
                .sheet(isPresented: $showingTrick) {
                    TrickView(trickDocId: trickDocId!)
                }
            }
        case 2:
            ForEach(trickViewModel.doingThisAWhileTricks){ trick in
                let trickComplete = TrickViewModel().getTrickComplete(trick: trick)
                let trickDocId = trick.id
                Button(action: {
                    trickViewModel.setCurrentTrick(id: trickDocId!)
                    showingTrick = true
                }){
                    TrickRowView(trickName: trick.name, trickType: trick.type, trickComplete: trickComplete, width: width, height: height).padding(.top, height * 0.0125).environmentObject(self.trickViewModel)
                }
                .buttonStyle(ScaleAnimationButtonEffect())
                .sheet(isPresented: $showingTrick) {
                    TrickView(trickDocId: trickDocId!)
                }
            }
        case 3:
            ForEach(trickViewModel.proTricks){ trick in
                let trickComplete = TrickViewModel().getTrickComplete(trick: trick)
                let trickDocId = trick.id
                Button(action: {
                    trickViewModel.setCurrentTrick(id: trickDocId!)
                    showingTrick = true
                }){
                    TrickRowView(trickName: trick.name, trickType: trick.type, trickComplete: trickComplete, width: width, height: height).padding(.top, height * 0.0125).environmentObject(self.trickViewModel)
                }
                .buttonStyle(ScaleAnimationButtonEffect())
                .sheet(isPresented: $showingTrick) {
                    TrickView(trickDocId: trickDocId!)
                }
            }
        case 4:
            ForEach(trickViewModel.godlikeTricks){ trick in
                let trickComplete = TrickViewModel().getTrickComplete(trick: trick)
                let trickDocId = trick.id
                Button(action: {
                    trickViewModel.setCurrentTrick(id: trickDocId!)
                    showingTrick = true
                }){
                    TrickRowView(trickName: trick.name, trickType: trick.type, trickComplete: trickComplete, width: width, height: height).padding(.top, height * 0.0125).environmentObject(self.trickViewModel)
                }
                .buttonStyle(ScaleAnimationButtonEffect())
                .sheet(isPresented: $showingTrick) {
                    TrickView(trickDocId: trickDocId!)
                }
            }
        default:
            Text("Something went wrong!")
        }
        
    }
}

