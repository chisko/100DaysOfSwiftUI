//
//  ContentView.swift
//  DrawingChallenge
//
//  Created by Francisco Ruiz on 15/12/21.
//

import SwiftUI

struct Arrow: Shape {
    var headHeight = 0.5
    var shaftWidth = 0.5
    
    var animatableData: AnimatablePair<Double, Double> {
        get { AnimatablePair(headHeight, shaftWidth) }
        set {
            headHeight = newValue.first
            shaftWidth = newValue.second
        }
    }

    func path(in rect: CGRect) -> Path {
        let height = rect.height * headHeight
        let thickness = rect.width * shaftWidth / 2

        return Path { path in
            path.move(to: CGPoint(x: 0, y: height))
            path.addLine(to: CGPoint(x: rect.midX, y: 0))
            path.addLine(to: CGPoint(x: rect.maxX, y: height))

            path.addLine(to: CGPoint(x: rect.midX + thickness, y: height))
            path.addLine(to: CGPoint(x: rect.midX + thickness, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.midX - thickness, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.midX - thickness, y: height))

            path.closeSubpath()
        }
    }
}

struct ColorCyclingRectangle: View {
    var amount = 0.0
    var steps = 100
    
    var gradientStartX = 0.5
    var gradientStartY = 0.0

    var gradientEndX = 0.5
    var gradientEndY = 0.5

    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                    .inset(by: Double(value))
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                color(for: value, brightness: 1),
                                color(for: value, brightness: 0.5)
                            ]),
                            startPoint: UnitPoint(x: gradientStartX, y: gradientStartY),
                            endPoint: UnitPoint(x: gradientEndX, y: gradientEndY)
                        ),
                        lineWidth: 2
                    )
            }
        }
        .drawingGroup() // Uses Metal
    }

    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount

        if targetHue > 1 {
            targetHue -= 1
        }

        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ContentView: View {
    @State private var showingView = "Arrow"
    @State private var views = ["Arrow", "Color Cycling Rectangle"]
    
    @State private var headHeight = 0.5
    @State private var shaftWidth = 0.25
    
    @State private var colorCycle = 0.0
    @State private var gradientStartX = 0.5
    @State private var gradientStartY = 0.0
    @State private var gradientEndX = 0.5
    @State private var gradientEndY = 0.5
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("", selection: $showingView) {
                    ForEach(views, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.segmented)
                
                Spacer()
                
                if showingView == "Arrow" {
                    VStack {
                        Arrow(headHeight: headHeight, shaftWidth: shaftWidth)
                            .fill(.blue)
                            .onTapGesture {
                                withAnimation {
                                    headHeight = Double.random(in: 0.2...0.8)
                                    shaftWidth = Double.random(in: 0.2...0.8)
                                }
                            }
                        
                        Text("Tap on the arrow to resize")
                            .font(.caption)
                    }
                    .padding()
                } else {
                    VStack {
                        ColorCyclingRectangle(amount: colorCycle, gradientStartX: gradientStartX, gradientStartY: gradientStartY, gradientEndX: gradientEndX, gradientEndY: gradientEndY)
                            .frame(width: 300, height: 300)

                        HStack {
                               Text("Color")
                               Slider(value: $colorCycle)
                           }
                        
                        HStack {
                            Text("Start X")
                            Slider(value: $gradientStartX)
                        }

                        HStack {
                            Text("Start Y")
                            Slider(value: $gradientStartY)
                        }

                        HStack {
                            Text("End X")
                            Slider(value: $gradientEndX)
                        }

                        HStack {
                            Text("End Y")
                            Slider(value: $gradientEndY)
                        }
                    }
                    .padding()
                }
                
                Spacer()
            }
            .navigationTitle("Drawing Challenge")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
