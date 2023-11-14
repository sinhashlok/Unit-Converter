//
//  ContentView.swift
//  Unit Converter
//
//  Created by Shlok Sinha on 14/11/23.
//

import SwiftUI

struct ContentView: View {
    @State private var temperature = 27.0
    @State private var inputUnit = "Celsius"
    @State private var outputUnit = "Fahrenheit"
    @State private var unitList = ["Celsius", "Fahrenheit", "Kelvin"]
    @FocusState private var isTempFocuse: Bool
    
    private var convertedTemperate: Double {
        var outputTemperature = temperature
        if inputUnit != "Celsius" {
            switch inputUnit {
            case "Fahrenheit":
                outputTemperature = (temperature - 32) * 0.5555
            case "Kelvin":
                outputTemperature = temperature - 273.15
            default:
                return 0.0
            }
        }
        
        switch outputUnit {
        case "Fahrenheit":
            outputTemperature = (outputTemperature * 1.8) + 32
        case "Kelvin":
            outputTemperature += 273.15
        default:
            return outputTemperature
        }
        
        return outputTemperature
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Enter conversion Detils") {
                    TextField("Temperature", value: $temperature, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($isTempFocuse)
                    
                    Picker("Input Temperature Unit", selection: $inputUnit) {
                        ForEach(unitList, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    Picker("Outpu Temperature Unit", selection: $outputUnit) {
                        ForEach(unitList, id: \.self) {
                            Text("\($0)")
                        }
                    }
                }
                
                Section("Temperate in \(outputUnit)") {
                    Text("Output Temperature: \(convertedTemperate)")
                }
            }
            .navigationTitle("Temperature Converter")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if isTempFocuse {
                    Button("Done") {
                        isTempFocuse = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
