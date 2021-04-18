//
//  WeekPlanRowView.swift
//  Skate App (iOS)
//
//  Created by Hubert Rzeminski on 29/01/2021.
//

import SwiftUI

struct WeekPlanRowView: View {
    
    //MARK: Variable declerations
    //Relevant data variables
    @EnvironmentObject var planViewModel : PlanViewModel
    @State var trimVal : CGFloat = 0
    @State var checked : Bool = false
    var hours : Float
    var task : PlanWeekTaskModel
    
    //View variables
    var rowWidth : CGFloat {
        return width * 0.9
    }
    var rowHeight : CGFloat {
        return height * 0.1
    }
    var timeWidth : CGFloat {
        return width * 0.2
    }
    var timeFontSize : CGFloat {
        return width * 0.04
    }
    var tickBoxHeight : CGFloat {
        return height * 0.1
    }
    var titleSize : CGFloat {
        return width * 0.4
    }
    var padding : CGFloat {
        return width * 0.01
    }
    var boxLineWidth : CGFloat {
        return width * 0.015
    }
    var boxSize : CGFloat {
        return height * 0.05
    }
    var tickSize : CGFloat {
        return (height * 0.06) - 10
    }
    let tickBoxWidth : CGFloat = 20
    let cornerRadius : CGFloat = 10
    var width: CGFloat = UIScreen.main.bounds.width
    var height: CGFloat = UIScreen.main.bounds.height
    let rowColor : Color = Color(red: 0.13, green: 0.15, blue: 0.22) // Black
    let textColor : Color = Color(red: 0.96, green: 0.96, blue: 0.96) // White
    let boxColor : Color = Color(red: 0.95, green: 0.32, blue: 0.34) // Red
    let completeColor : Color = Color(red: 0.15, green: 0.72, blue: 0.08) // Green
    let shadowRadius : CGFloat = 3
    let shadowDimensions : CGFloat = 10
    
    init(hours: Float, task: PlanWeekTaskModel){
        self.task = task
        self.hours = hours
    }
    //MARK:Body
    var body: some View {
        ZStack{
            Rectangle()
                .fill(rowColor)
                .frame(width: rowWidth, height: rowHeight, alignment: .center)
                .cornerRadius(cornerRadius)
                .shadow(color: rowColor.opacity(0.5), radius: shadowRadius, x: shadowDimensions, y: shadowDimensions)
            HStack{
                Text("\(hours < 1 ? "1/2" : String(Int(hours))) Hours")
                    .frame(width: timeWidth, alignment: .center)
                    .font(.system(size: timeFontSize, weight: .bold, design: .monospaced))
                    .foregroundColor(textColor)
                Rectangle()
                    .fill(textColor)
                    .frame(width: tickBoxWidth, height: tickBoxHeight, alignment: .center)
                Text(task.title)
                    .frame(width: titleSize, alignment: .center)
                    .font(.system(size: timeFontSize, weight: .bold, design: .monospaced))
                    .foregroundColor(textColor)
                    .multilineTextAlignment(.center)
                    .padding(EdgeInsets(top: 0, leading: padding, bottom: 0, trailing: padding))
                //MARK: Completion box
                ZStack{
                    CheckBox(checked: $checked, trimVal: $trimVal)
                }
            }
        }
        .frame(width: rowWidth, height: tickBoxHeight, alignment: .center)
        .onAppear(perform: {
            self.checked = task.complete
        })
        .onTapGesture {
            planViewModel.toogleTaskComplete(docId: task.id!)
            if(!(self.checked)){
                withAnimation(Animation.easeIn(duration: 0.8)){
                    self.trimVal = 1
                    self.checked.toggle()
                }
            }else {
                withAnimation{
                    self.trimVal = 0
                    self.checked.toggle()
                }
            }
            vibration()
        }
    }
    
    func vibration() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}

