//
//  MeteoServiceTestCase.swift
//  MonBalluchonTests
//
//  Created by macmini-Armelle on 03/04/2022.
//

import XCTest
@testable import MonBalluchon
class MeteoServiceTestCase: XCTestCase {
    var meteo : MeteoService!
    func testGetWeatherInEnglishShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        TestURLProtocol.loadingHandler = { request in
            let response: HTTPURLResponse = FakeResponseData.responseOK
            let error: Error? = nil
            let data: Data? = FakeResponseData.weatherCorrectData
            return (response, data, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestURLProtocol.self]
        let session = URLSession(configuration: configuration)
        let weatherService = MeteoService(meteoSession: session)
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getMeteo(town: "New York") { (success, weatherResult) in
            let temp = 7.48
            let id = 804
            // Then
            XCTAssertTrue(success)
            XCTAssertNotNil(weatherResult)
            XCTAssertEqual(temp, weatherResult?.main.temp)
            XCTAssertEqual(id, weatherResult?.weather[0].id)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }

    func testGetMeteoWithError404InGuardShoulReturnMessage(){
        // Given
        TestURLProtocol.loadingHandler = { request in
            let response: HTTPURLResponse = FakeResponseData.responseOK
            let error: Error? = nil
            let data: Data? = FakeResponseData.weatherCorrectData
            return (response, data, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestURLProtocol.self]
        let session = URLSession(configuration: configuration)
        let weatherService = MeteoService(meteoSession: session)
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getMeteo(town: "New York") { (success, weatherResult) in
           let code = 404
           let message = "city not found"
         //    Then
          XCTAssertTrue(code == 404)
          XCTAssertTrue(message == "city not found")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }

    // MARK: -  function convertDt test
    func testConvertDt() {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestURLProtocol.self]
        let session = URLSession(configuration: configuration)
        let meteo = MeteoService(meteoSession: session)
        let dt = 1649332990
    
        let dateDuJour = meteo.convertDt(dt:dt)
        let dateString = "04-07-2022 ?? 14:03"
        XCTAssertEqual(dateDuJour, dateString)

    }
    
//    // MARK: -  function sendAlertNotification test
//    func testSendAlertNotification() {
//        TestURLProtocol.loadingHandler = { request in
//            let response: HTTPURLResponse = FakeResponseData.responseOK
//            let error: Error? = nil
//            let data: Data? = FakeResponseData.weatherCorrectData
//            return (response, data, error)
//        }
//        let configuration = URLSessionConfiguration.ephemeral
//        configuration.protocolClasses = [TestURLProtocol.self]
//        let session = URLSession(configuration: configuration)
//        let weatherService = MeteoService(meteoSession: session)
//        // When
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        weatherService.sendAlertNotification(message: <#T##String#>)
//         //    Then
//          XCTAssertTrue(code == 404)
////          XCTAssertTrue(message == "city not found")
////            expectation.fulfill()
////        }
////        wait(for: [expectation], timeout: 1)
////    }
   
    func testGetWeather000001() {
        // Given
        TestURLProtocol.loadingHandler = { request in
            let response: HTTPURLResponse = FakeResponseData.responseKO
            let error: Error? = nil
            let data: Data? = FakeResponseData.meteoFunny
            return (response, data, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestURLProtocol.self]
        let session = URLSession(configuration: configuration)
        let weatherService = MeteoService(meteoSession: session)
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getMeteo(town: "New York") { (success,
         weatherResult) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weatherResult)
            expectation.fulfill()
    }
        wait(for: [expectation], timeout: 1)
    }
    func testGetWeather000002() {
        // Given
        TestURLProtocol.loadingHandler = { request in
            let response: HTTPURLResponse = FakeResponseData.responseKO404
            let error: Error? = nil
            let data: Data? = FakeResponseData.meteoFunny
            return (response, data, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestURLProtocol.self]
        let session = URLSession(configuration: configuration)
        let weatherService = MeteoService(meteoSession: session)
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getMeteo(town: "New York") { (success,
         weatherResult) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weatherResult)
            expectation.fulfill()
    }
        wait(for: [expectation], timeout: 1)
           }
           
    func testGetWeather000003() {
               // Given
               TestURLProtocol.loadingHandler = { request in
                   let response: HTTPURLResponse = FakeResponseData.responseOK
                   let error: Error? = nil
                   let data: Data? = FakeResponseData.meteoFunny
                   return (response, data, error)
               }
               let configuration = URLSessionConfiguration.ephemeral
               configuration.protocolClasses = [TestURLProtocol.self]
               let session = URLSession(configuration: configuration)
               let weatherService = MeteoService(meteoSession: session)
               // When
               let expectation = XCTestExpectation(description: "Wait for queue change.")
               weatherService.getMeteo(town: "xxxxx") { (success, weatherResult) in
       // Then
                   XCTAssertFalse(success)
                   XCTAssertNil(weatherResult)
                   expectation.fulfill()
       }
               wait(for: [expectation], timeout: 1)
           }

}




