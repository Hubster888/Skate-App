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
    let segment : Int
    @State var showingTrick = false
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    var body: some View {
        switch tabDiff {
        case 1:
            ForEach(segment == 0 ? trickViewModel.beginnerTricks : trickViewModel.beginnerTricks.filter{
                segment == 1 ? (trickViewModel.completionTable[$0.id!]!.filter{$0}.count < 1) : (trickViewModel.completionTable[$0.id!]!.filter{$0}.count >= 1)// 1 or more
            }
            ){ trick in
                let trickDocId = trick.id
                Button(action: {
                    trickViewModel.setCurrentTrick(id: trickDocId!)
                    trickViewModel.getCurrentCompletion(id: trickDocId!)
                    showingTrick = true
                }){
                    TrickRowView(trick: trick, width: width, height: height).padding(.top, height * 0.0125).environmentObject(self.trickViewModel)
                }
                .buttonStyle(ScaleAnimationButtonEffect())
                .sheet(isPresented: $showingTrick) {
                    TrickView()
                }
            }
        case 2:
            ForEach(segment == 0 ? trickViewModel.doingThisAWhileTricks : trickViewModel.doingThisAWhileTricks.filter{
                segment == 1 ? (trickViewModel.completionTable[$0.id!]!.filter{$0}.count < 1) : (trickViewModel.completionTable[$0.id!]!.filter{$0}.count >= 1)// 1 or more
            }
            ){ trick in
                let trickDocId = trick.id
                Button(action: {
                    trickViewModel.setCurrentTrick(id: trickDocId!)
                    trickViewModel.getCurrentCompletion(id: trickDocId!)
                    showingTrick = true
                }){
                    TrickRowView(trick: trick, width: width, height: height).padding(.top, height * 0.0125).environmentObject(self.trickViewModel)
                }
                .buttonStyle(ScaleAnimationButtonEffect())
                .sheet(isPresented: $showingTrick) {
                    TrickView()
                }
            }
        case 3:
            ForEach(segment == 0 ? trickViewModel.proTricks : trickViewModel.proTricks.filter{
                segment == 1 ? (trickViewModel.completionTable[$0.id!]!.filter{$0}.count < 1) : (trickViewModel.completionTable[$0.id!]!.filter{$0}.count >= 1)// 1 or more
            }
            ){ trick in
                let trickDocId = trick.id
                Button(action: {
                    trickViewModel.setCurrentTrick(id: trickDocId!)
                    trickViewModel.getCurrentCompletion(id: trickDocId!)
                    showingTrick = true
                }){
                    TrickRowView(trick: trick, width: width, height: height).padding(.top, height * 0.0125).environmentObject(self.trickViewModel)
                }
                .buttonStyle(ScaleAnimationButtonEffect())
                .sheet(isPresented: $showingTrick) {
                    TrickView()
                }
            }
        case 4:
            ForEach(segment == 0 ? trickViewModel.godlikeTricks : trickViewModel.godlikeTricks.filter{
                segment == 1 ? (trickViewModel.completionTable[$0.id!]!.filter{$0}.count < 1) : (trickViewModel.completionTable[$0.id!]!.filter{$0}.count >= 1)// 1 or more
            }
            ){ trick in
                let trickDocId = trick.id
                Button(action: {
                    trickViewModel.setCurrentTrick(id: trickDocId!)
                    trickViewModel.getCurrentCompletion(id: trickDocId!)
                    showingTrick = true
                }){
                    TrickRowView(trick: trick, width: width, height: height).padding(.top, height * 0.0125).environmentObject(self.trickViewModel)
                }
                .buttonStyle(ScaleAnimationButtonEffect())
                .sheet(isPresented: $showingTrick) {
                    TrickView()
                }
            }
        default:
            Text("Something went wrong!")
        }
        
    }
}

