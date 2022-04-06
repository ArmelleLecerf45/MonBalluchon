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
            let temp = 4.83
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

   

    

    
    // MARK: -  function convertDt tests
    func testConvertDt() {
        let dt = 1648717133
        let date = meteo.convertDt(dt: dt)
        let dateString = "31 mars 2022 à 10:58"
        XCTAssertEqual(date, dateString)

    }

}
