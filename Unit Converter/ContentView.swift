//
//  ContentView.swift
//  Unit Converter
//
//  Created by Miguel Agostinho on 11/08/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var errorMessage: String?
    @State private var fromAmount: String = ""
    @State private var toAmount: String = ""
    @State private var convertedAmount = ""
    
    @State private var fromCurrency: Int = 1
    @State private var toCurrency: Int = 2
    
    @State private var exchangeRates: [CurrencyRate] = []
    let currencies = ["USD", "EUR", "BRL", "GBP", "CAD", "AUD", "PEN"]
    
    
    private var fromSelectedCurrency: String {
        currencies[fromCurrency]
    }
    
    private var toSelectedCurrency: String {
        currencies[toCurrency]
    }
    
        var body: some View {
            
            VStack {
                
                Text("Currency Converter")
                    .font(.largeTitle)
                    .frame(width: 300, height: 300)
                
                if let errorMessage = errorMessage{
                    Text(errorMessage)
                        .foregroundStyle(.red)
                }
                
                HStack {
                    TextField("Amount: ", text: $fromAmount)
                        .frame(width: 150, height: 50)
                        .keyboardType(.decimalPad)
                    
                    Picker("From Currency:", selection: $fromCurrency){
                        ForEach(currencies.indices, id: \.self) { index in
                            Text(currencies[index]).tag(index)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    
                }
                HStack{
                    Text("\(convertedAmount)")
                        .frame(width: 150, height: 50)
                        .keyboardType(.decimalPad)
                    
                    Picker("From Currency:", selection: $toCurrency){
                        ForEach(currencies.indices, id: \.self) { index in
                            Text(currencies[index]).tag(index)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())

                }
                
                Button(action: convertCurrencies){
                    Text("Convert")
                }
            }
            .onAppear(perform: {
                fetchExchangeRates()
                
            })
            
            
        }
    
    func fetchExchangeRates() {
        NetworkManager.shared.getExhangeData(for: "EUR") { result in
            switch result {
            case .success(let rates):
                    DispatchQueue.main.async{
                        self.exchangeRates = rates
                        
                        
                    }
            case .failure(let error):
                DispatchQueue.main.asyncAndWait {
                    self.errorMessage = "Failed to fetch rate: \(error.localizedDescription)"
                }
            }
        }
        
    }
    
    func convertCurrencies() {
        
        guard let fromRate = exchangeRates.first(where: {$0.currency == fromSelectedCurrency})?.rate,
              let toRate = exchangeRates.first(where: {$0.currency == toSelectedCurrency})?.rate,
              let amount = Double(fromAmount) else {
            self.errorMessage = "Conversion Error!"
            return
        }
        
        let baseAmount = amount / fromRate
        let converted = baseAmount * toRate
        
        self.convertedAmount = String(format: "%.2f", converted)
        
    }

}

#Preview {
    ContentView()
}
