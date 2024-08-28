//
//  CurrencyRate.swift
//  Unit Converter
//
//  Created by Miguel Agostinho on 28/08/2024.
//

import Foundation

struct CurrencyRate {
    let currency: String
    let rate: Double
}

struct ExchangeRateResponse: Codable {
    
    let rates: [String: Double]
    
}
