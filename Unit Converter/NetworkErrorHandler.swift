//
//  NetworkErrorHandler.swift
//  Unit Converter
//
//  Created by Miguel Agostinho on 28/08/2024.
//

import Foundation

enum NetworkErrorHandler: Error {
    
    case invalidURL
    case invalidResponse
    case invalidData
    case unableToComplete
    case unableToDecode
}
