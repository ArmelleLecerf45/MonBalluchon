//
//  Conversion.swift
//  MonBalluchon
//
//  Created by macmini-Armelle on 01/12/2021.
//

import Foundation


struct LastRate: Codable {
    let success: Bool
    let timestamp: Int
    let base: String
    let date: String
    let rates : ExchangeRates
}

struct ExchangeRates: Codable {
    let ARS: Double
    let AUD: Double
    let BTC: Double
    let CAD: Double
    let CHF: Double
    let CNY: Double
    let DZD: Double
    let GBP: Double
    let ILS: Double
    let JPY: Double
    let RUB: Double
    let USD: Double
}
