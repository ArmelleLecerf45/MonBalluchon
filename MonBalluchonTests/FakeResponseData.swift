//  FakeResponseData.swift
//  MonBalluchonTests
//
//  Created by macmini-Armelle on 04/04/2022.
//

import Foundation
class FakeResponseData  {

    // MARK: - Data
    static var conversionCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Conversion", withExtension: "json")!
        return try! Data(contentsOf: url)
    }

    static var weatherCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Meteo", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    
    static var weatherCorrectData2: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "MeteoError1", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    static var weatherCorrectData3: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "MeteoError2", withExtension: "json")!
        return try! Data(contentsOf: url)
    }

    static var translationCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "TranslationEn", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    static var translationCorrectDataDe: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "TranslationDe", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
   
    static var translationCorrectDataIt: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "TranslationIt", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    static var translationCorrectDataEs: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "TranslationEs", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    static var translationCorrectDataRu: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "TranslationRu", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
   
    static var meteoFunny: Data? {
            let bundle = Bundle(for: FakeResponseData.self)
            let url = bundle.url(forResource: "meteoError2", withExtension:
             "json")!
            return try! Data(contentsOf: url)
    }


    static let conversionIncorrectData = "erreur".data(using: .utf8)!
    static let weatherIncorrectData = "erreur".data(using: .utf8)!
    static let translationIncorrectData = "erreur".data(using: .utf8)!

    // MARK: - Response
    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 200, httpVersion: nil, headerFields: [:])!

    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 500, httpVersion: nil, headerFields: [:])!
    
    static let responseKO404 = HTTPURLResponse(
            url: URL(string: "https://openclassrooms.com")!,
            statusCode: 404, httpVersion: nil, headerFields: [:])!
    
    static let MeteoFunny = HTTPURLResponse(
            url: URL(string: "https://openclassrooms.com")!,
            statusCode: 406, httpVersion: nil, headerFields: [:])!

    // MARK: - Error
    class ConversionError: Error {}
    static let conversionError = ConversionError()

    class WeatherError: Error {}
    static let weatherError = WeatherError()

    class TranslationError: Error {}
    static let translationError = TranslationError()

}

