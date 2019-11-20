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
    @State var target = Int.random(in: 1...100)
    var score = 999
    var round = 123
    
    var body: some View {
        VStack {
            HStack {
                Text("Put the bullseye as close as you can to:")
                Text("\(self.target)")
            }.padding(.top, 20)
            Spacer()
            HStack {
                Text("1")
                Slider(value: self.$slider, in: 1...100)
                Text("100")
            }
            Spacer()
            Button(action:{ self.showResult = true }){
                Text("Hit me")
            }.alert(isPresented: $showResult) { () -> Alert in
                let rounded =  Int(self.slider.rounded())
                return Alert(title: Text("Your score"), message: Text("\(rounded)"))
            }
            Spacer()
            HStack {
                Button(action: self.restart) {
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
    
    func restart() -> Void {
        self.target = Int.random(in: 1...100)
        self.slider = Double.random(in: 1...100)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 896, height: 494))
    }
}
