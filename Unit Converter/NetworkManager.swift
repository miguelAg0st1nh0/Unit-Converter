//
//  NetworkManager.swift
//  Unit Converter
//
//  Created by Miguel Agostinho on 28/08/2024.
//

import Foundation

final class NetworkManager{
    
    static let shared = NetworkManager()
    
    private let url = "https://api.exchangerate-api.com/v4/latest/USD"
    
    func getExhangeData(completed: @escaping (Result<[CurrencyRate], NetworkErrorHandler>) -> Void ) {
        
        guard let url = URL(string: url) else {
            
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url:url)) { data, response, error in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(ExchangeRateResponse.self, from: data)
                
                let currencyRates = decodedResponse.rates.map{CurrencyRate(currency: $0.key, rate: $0.value)}
                
                completed(.success(currencyRates))
            } catch {
                completed(.failure(.unableToDecode))
            }
            
        }
        task.resume()
    }
    
}
