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
    
    var body: some View {
        VStack {
            HStack {
                Text("Put the bullseye as close as you can to: ")
                Text("\(self.target)")
            }.padding(.top, 20)
            Spacer()
            HStack {
                Text("1")
                Slider(value: $slider, in: 1...100)
                Text("100")
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
            }
            Spacer()
            HStack {
                Button(action: startOver) {
                    Text("Start over")
                }
                Spacer()
                HStack {
                    Text("Score")
                    Text("\(score)")
                }
                Spacer()
                HStack {
                    Text("Round")
                    Text("\(round)")
                }
                Spacer()
                Button(action:{}){
                    Text("Info")
                }
            }.padding(.bottom, 20)
        }
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
