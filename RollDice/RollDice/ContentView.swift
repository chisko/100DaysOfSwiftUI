//
//  ContentView.swift
//  RollDice
//
//  Created by Francisco Ruiz on 26/01/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dices: Dices
    
    @State private var isShowingSettings = false
    @State private var isShowingLogs = false
    
    @State private var feedback = UIImpactFeedbackGenerator(style: .rigid)
    
    @State private var timerRuns = 0
    @State private var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var isRolling = false
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                HStack {
                    ForEach(self.dices.dices) { dice in
                        DiceView(dice: dice)
                    }
                }
                
                Spacer()
                
                Button {
                    self.isRolling = true
                    //self.dices.rollDice()
                    self.timerRuns = 0
                    self.timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
                } label: {
                    Text("Roll Dice")
                }
                .padding()
                .background(.blue)
                .foregroundColor(.white)
                .clipShape(Capsule(style: .continuous))
                
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        isShowingSettings = true
                    } label: {
                        Image(systemName: "gear")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isShowingLogs = true
                    } label: {
                        Image(systemName: "list.dash")
                    }
                }
            }
            .sheet(isPresented: $isShowingSettings) {
                SettingsView()
            }
            .sheet(isPresented: $isShowingLogs) {
                LogView()
            }
        }
        .onAppear {
            feedback.prepare()
        }
        .onReceive(timer) { time in
            guard isRolling else { return }
            
            if timerRuns < 5 {
                timerRuns += 1
                feedback.impactOccurred()
                self.dices.rollDice()
            } else {
                self.dices.addResult()
                self.isRolling = false
                self.timer.upstream.connect().cancel()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
