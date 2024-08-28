//
//  ContentView.swift
//  Unit Converter
//
//  Created by Miguel Agostinho on 11/08/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var exchangeRate: Double?
    @State private var errorMessage: String?
        
        var body: some View {
            VStack {
                if let rate = exchangeRate{
                    Text("1 $ = £\(rate) GBP")
                } else if let errorMessage = errorMessage {
                    Text(errorMessage)
                } else {
                    Text("Loading...")
                }
            }
            .onAppear(perform: {
                fetchExchangeRates()
            })
        }
    
    func fetchExchangeRates() {
        NetworkManager.shared.getExhangeData { result in
            switch result {
            case .success(let currencyRates):
                if let gbpRate = currencyRates.first(where: {$0.currency == "GBP"})?.rate {
                    DispatchQueue.main.async{
                        self.exchangeRate = gbpRate
                    }
                } else {
                    DispatchQueue.main.async {
                        self.errorMessage = "Rate not found"
                    }
                }
            case .failure(let error):
                DispatchQueue.main.asyncAndWait {
                    self.errorMessage = "Failed to fetch rate: \(error.localizedDescription)"
                }
            }
        }
        
    }
        
}

#Preview {
    ContentView()
}
