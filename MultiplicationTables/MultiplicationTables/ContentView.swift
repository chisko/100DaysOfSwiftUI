//
//  ContentView.swift
//  MultiplicationTables
//
//  Created by Francisco Ruiz on 08/12/21.
//

import SwiftUI

struct ContentView: View {
    @State private var inGame = false
    @State private var gameFinished = false
    
    @State private var multiplicationTable = 2
    @State private var howManyQuestions = 5
    let howManyQuestionsOptions = [1, 5, 10, 20]
    
    @State private var questionNumber = 0
    @State private var questionCurrentValue = 0
    @State private var answer = 0
    @State private var score = 0
    
    @FocusState private var answerIsFocused: Bool
    
    let animals = ["bear", "buffalo", "chick", "chicken", "cow", "crocodile", "dog", "duck", "elephant", "frog", "giraffe", "goat", "gorilla", "hippo", "horse", "monkey", "moose", "narwhal", "owl", "panda", "parrot", "penguin", "pig", "rabbit", "rhino", "sloth", "snake", "walrus", "whale", "zebra"]
    
    var randomAnimal: String {
        return animals.randomElement() ?? "bear"
    }
    
    @State private var overallScoreChange = -1.0
    
    var overallScore: Double {
        return (Double(score) / Double(howManyQuestions)) * 100.0
    }
    
    var body: some View {
        NavigationView {
            Group {
                if inGame {
                    if gameFinished {
                        ZStack {
                            Group {
                                if overallScore >= 90.0 {
                                    Color.green
                                } else if overallScore >= 70.0 {
                                    Color.yellow
                                } else {
                                    Color.red
                                }
                            }
                            .ignoresSafeArea()
                            
                            VStack {
                                // Icono del animal
                                
                                Image(randomAnimal)
                                    .rotationEffect(
                                        .degrees(overallScoreChange != -1 && overallScoreChange < 70.0 ? 180 : 0)
                                    )
                                    .animation(.default, value: overallScoreChange)
                                    .rotation3DEffect(
                                        .degrees(overallScoreChange != -1 && overallScoreChange >= 70.0 && overallScoreChange < 90.0 ? 360 : 0),
                                        axis: (x: 1, y: 0, z: 0)
                                    )
                                    .animation(.default, value: overallScoreChange)
                                    .rotation3DEffect(
                                        .degrees(overallScoreChange != -1 && overallScoreChange >= 90.0 ? 360 : 0),
                                        axis: (x: 0, y: 1, z: 0)
                                    )
                                    .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: overallScoreChange)
                                
                                Text("\(score) / \(howManyQuestions)")
                                    .font(.largeTitle.bold())
                                    .foregroundColor(.white)
                                
                                Text(
                                    overallScore >= 90.0 ? "Congratulations!\nYou did great!" :
                                        overallScore >= 70.0 ? "You're doing ok, but I think you can do better." :
                                        "Keep on practicing, you can only get better."
                                )
                                    .font(.title.bold())
                                    .foregroundColor(.white)
                                
                                Button {
                                    tryAgain()
                                } label: {
                                    HStack {
                                        Image(systemName: "arrow.counterclockwise.circle.fill")
                                        
                                        Text("Try Again")
                                    }
                                }
                                .frame(width: 150, height: 50)
                                .background(Color.white)
                                .foregroundColor(
                                    overallScore >= 90.0 ? Color.green :
                                        overallScore >= 70.0 ? Color.yellow : Color.red
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 32))
                                
                                Button {
                                    resetGame()
                                } label: {
                                    HStack {
                                        Image(systemName: "play.circle.fill")
                                        
                                        Text("New Game")
                                    }
                                }
                                .frame(width: 150, height: 50)
                                .background(Color.white)
                                .foregroundColor(
                                    overallScore >= 90.0 ? Color.green :
                                        overallScore >= 70.0 ? Color.yellow : Color.red
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 32))
                            }
                            .padding(.horizontal, 50)
                        }
                        .onAppear {
                            overallScoreChange = overallScore
                        }
                    } else {
                        VStack {
                            Spacer()
                            
                            Text("Question #\(questionNumber):")
                            
                            VStack {
                                HStack {
                                    Spacer()
                                    
                                    Text("\(multiplicationTable)")
                                        .font(.title)
                                }
                                
                                HStack {
                                    Image(systemName: "multiply")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 24, height: 24)
                                    
                                    Spacer()
                                    
                                    Text("\(questionCurrentValue)")
                                        .font(.title)
                                }
                                
                                Divider()
                                
                                TextField("Answer", value: $answer, format: .number)
                                    .textFieldStyle(.roundedBorder)
                                    .keyboardType(.numberPad)
                                    .focused($answerIsFocused)
                                    .onSubmit(evaluateQuestion)
                            }
                            .padding(25)
                            .frame(width:150)
                            //.border(Color.gray, width: 2)
                            .overlay {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray, lineWidth: 2)
                            }
                            
                            Spacer()
                        }
                        .safeAreaInset(edge: .bottom) {
                            VStack(spacing: 0) {
                                Text("Score: \(score)")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(.blue)
                                    .foregroundColor(.white)
                                    .font(.title)
                                
                                Button {
                                    answerIsFocused = false
                                    evaluateQuestion()
                                } label: {
                                    HStack {
                                        Text("Next Question")
                                        
                                        Image(systemName: "chevron.right")
                                    }
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(.green)
                                .foregroundColor(.white)
                                .font(.title)
                            }
                        }
                    }
                } else {
                    Form {
                        Section {
                            Picker("Select multiplication table", selection: $multiplicationTable) {
                                ForEach(2..<13, id: \.self) { number in
                                    HStack {
                                        Text("\(number) ")
                                        Image(systemName: "multiply")
                                        Text(" tables")
                                    }
                                }
                            }
                            .labelsHidden()
                        } header: {
                            Text("Select multiplication table")
                        }
                        
                        Section {
                            Picker("Select how many questions", selection: $howManyQuestions) {
                                ForEach(howManyQuestionsOptions, id: \.self) {
                                    Text("\($0)")
                                }
                            }
                            .labelsHidden()
                            .pickerStyle(.segmented)
                        } header: {
                            Text("How many questions do you want?")
                        }
                    }
                    .safeAreaInset(edge: .bottom) {
                        Button {
                            nextQuestion()
                            inGame = true
                        } label: {
                            Text("Start Game")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.green)
                        .foregroundColor(.white)
                        .font(.title)
                    }
                }
            }
            .navigationTitle("Multiplication Tables")
            /*
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        evaluateQuestion()
                    }
                }
            }
            */
        }
    }
    
    func nextQuestion() {
        answer = 0
        print("Answer: \(answer)")
        questionNumber += 1
        
        questionCurrentValue = Int.random(in: 0...12)
    }
    
    func evaluateQuestion() {
        if answer == multiplicationTable * questionCurrentValue {
            score += 1
        }
        
        if questionNumber == howManyQuestions {
            gameFinished = true
        } else {
            nextQuestion()
        }
    }
    
    func tryAgain() {
        gameFinished = false
        questionNumber = 0
        questionCurrentValue = 0
        answer = 0
        score = 0
        overallScoreChange = -1.0
        nextQuestion()
    }
    
    func resetGame() {
        inGame = false
        gameFinished = false
        questionNumber = 0
        questionCurrentValue = 0
        answer = 0
        score = 0
        overallScoreChange = -1.0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
