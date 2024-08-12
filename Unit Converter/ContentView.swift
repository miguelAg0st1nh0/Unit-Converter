//
//  ContentView.swift
//  Unit Converter
//
//  Created by Miguel Agostinho on 11/08/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var unityType = 1
    @State private var userInput: String = ""
    @State private var lenghtUnits = 1
    var body: some View {
        
        HStack{
            TextField("Units", text: .constant(""))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
            Picker(selection: $lenghtUnits, label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/) {
                Text("Meters").tag(1)
                Text("Kilometer").tag(2)
            }
        }
        .frame(width: 300, height: 50)
        
        HStack{
            TextField("Units", text: .constant(""))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
            
            Picker(selection: $lenghtUnits, label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/) {
                Text("Meters").tag(2)
                Text("Kilometers").tag(1)
            }
        }
        .frame(width: 300, height: 50)
       
        
        
        VStack {
            Picker(selection: $unityType, label: Text("Picker")) {
                Text("Lenght").tag(1)
                Text("Weight").tag(2)
                Text("Temperature").tag(3)
                Text("Currency").tag(4)
                
            }
            .pickerStyle(SegmentedPickerStyle())
            
        }
        
        
        
        
    }
}

#Preview {
    ContentView()
}
