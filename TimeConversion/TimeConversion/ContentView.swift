//
//  ContentView.swift
//  TimeConversion
//
//  Created by Francisco Ruiz on 04/12/21.
//

import SwiftUI

struct ContentView: View {
    @State private var inputValue: Double = 0
    @State private var inputUnit: String = "minutes"
    @State private var outputUnit: String = "seconds"
    @FocusState private var inputValueIsFocused: Bool
    
    let units = ["seconds", "minutes", "hours", "days"]
    
    var inputValueInSeconds: Double {
        var returnValue = inputValue
        switch inputUnit {
        case "days":
            returnValue *= 24
            fallthrough
        case "hours":
            returnValue *= 60
            fallthrough
        case "minutes":
            returnValue *= 60
            fallthrough
        default:
            returnValue *= 1
        }
        
        return returnValue
    }
    
    var outputValue: Double {
        var outputValue = 0.0
        switch outputUnit {
        case "days":
            outputValue = inputValueInSeconds / 86400.0
        case "hours":
            outputValue = inputValueInSeconds / 3600.0
        case "minutes":
            outputValue = inputValueInSeconds / 60.0
        default:
            outputValue = inputValueInSeconds / 1.0
        }
        print("OutputValue: \(outputValue)")
        return outputValue
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Value", value: $inputValue, format: .number)
                        .keyboardType(.numberPad)
                        .focused($inputValueIsFocused)
                    
                } header: {
                    Text("Value to convert")
                }
                
                Section {
                    Picker("Input Unit", selection: $inputUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Input Unit")
                }
                
                Section {
                    Picker("Output Unit", selection: $outputUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Output Unit")
                }
                /*
                Section {
                    Text(inputValueInSeconds, format: .number)
                } header: {
                    Text("Input Value in Seconds")
                }
                */
                Section {
                    Text(outputValue, format: .number)
                } header: {
                    Text("Output Value in \(outputUnit)")
                }
                
            }
            .navigationTitle("Time Conversion")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        inputValueIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
