//
//  ContentView.swift
//  Bullseye
//
//  Created by Parley Pacheco on 28.10.19.
//  Copyright © 2019 Parley Pacheco. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var slider: Double = 50.0
    @State var showResult: Bool = false
    @State var target: Int = Int.random(in: 1...100)
    @State var score = 0
    @State var round = 1
    
    struct LabelStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.white)
                .modifier(Shadow())
                .font(Font.custom("TrebuchetMS", size: 18))
        }
    }
    
    struct ValueStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.yellow)
                .modifier(Shadow())
                .font(Font.custom("TrebuchetMS", size: 24))
        }
    }
    
    struct Shadow: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .shadow(color: Color.black, radius: 5, x:2, y:2)
        }
    }
    
    struct ButtonSytle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .background(Image("Button"))
                .modifier(Shadow())
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text("Put the bullseye as close as you can to: ")
                    .modifier(LabelStyle())
                Text("\(self.target)").modifier(ValueStyle())
            }
            Spacer()
            HStack {
                Text("1").modifier(LabelStyle())
                Slider(value: $slider, in: 1...100)
                Text("100").modifier(LabelStyle())
            }
            Spacer()
            Button(action: hitme){
                Text("Hit me")
            }.alert(isPresented: $showResult) { () -> Alert in
                let bonus = getBonusPoints()
                return Alert(
                    title: Text(alertTitle()),
                    message: Text("The slider value is \(roundSlider()). Your scored \(getRoundScore() + bonus) this round"),
                    dismissButton: .default(Text("New round")){self.startRound(bonus: bonus)}
                )
            }.modifier(ButtonSytle())
            Spacer()
            HStack {
                Button(action: startOver) {
                    Text("Start over")
                }.modifier(ButtonSytle())
                Spacer()
                HStack {
                    Text("Score").modifier(LabelStyle())
                    Text("\(score)").modifier(ValueStyle())
                }
                Spacer()
                HStack {
                    Text("Round").modifier(LabelStyle())
                    Text("\(round)").modifier(ValueStyle())
                }
                Spacer()
                Button(action:{}){
                    Text("Info")
                }.modifier(ButtonSytle())
            }.padding(.bottom, 20)
        }.background(Image("Background"), alignment: .bottom)
    }
    
    func startOver() -> Void {
        startRound()
        score = 0
        round = 0
    }
    
    func startRound(bonus: Int = 0) -> Void {
        score += getRoundScore() + bonus
        round += 1
        target = Int.random(in: 1...100)
        slider = Double.random(in: 1...100)
    }
    
    func getRoundScore() -> Int {
        return 100 - difference()
    }
    
    func hitme() -> Void {
        showResult = true
    }
    
    func roundSlider() -> Int {
        return Int(slider.rounded())
    }
    
    func difference() -> Int {
        return abs(roundSlider() - target)
    }
    
    func alertTitle() -> String {
        let difference = self.difference()
        var title: String
        if(difference == 0) {
            title = "Perfect"
        } else if (difference < 5) {
            title = "Almost there!"
        } else if (difference <= 10) {
            title = "Not bad"
        } else {
            title = "Are you even trying?"
        }
        return title
    }

    func getBonusPoints() -> Int {
        let difference = self.difference()
        if(difference == 0) {
            return 100
        }
        
        if(difference == 1) {
            return 50
        }
        
        return 0
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 896, height: 494))
    }
}
