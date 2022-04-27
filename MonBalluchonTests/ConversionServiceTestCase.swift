//
//  ConversionServiceTestCase.swift
//  MonBalluchonTests
//
//  Created by macmini-Armelle on 03/04/2022.
//

import XCTest
@testable import MonBalluchon
class ConversionServiceTestCase: XCTestCase {
    var conversion: ConversionService!

    override func setUp() {
        super.setUp()
        TestURLProtocol.loadingHandler = { request in
            let response: HTTPURLResponse = FakeResponseData.responseOK
            let error: Error? = nil
            let data: Data? = FakeResponseData.conversionCorrectData
            return (response, data, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestURLProtocol.self]
        let session = URLSession(configuration: configuration)
        conversion = ConversionService(conversionSession: session)
    }

    // MARK: - Network call tests
    func testGetRatesShouldPostFailedCallbackIfError() {
        // Given
        TestURLProtocol.loadingHandler = { request in
            let response: HTTPURLResponse = FakeResponseData.responseKO
            let error: Error? = FakeResponseData.conversionError
            let data: Data? = nil
            return (response, data, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestURLProtocol.self]
        let session = URLSession(configuration: configuration)
        let conversionService = ConversionService(conversionSession: session)
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        conversionService.getChangeRates{(success, searchRate) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(searchRate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }

    func testGetRatesShouldPostFailedCallbackIfNoData() {
        // Given
        TestURLProtocol.loadingHandler = { request in
            let response: HTTPURLResponse = FakeResponseData.responseKO
            let error: Error? = nil
            let data: Data? = nil
            return (response, data, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestURLProtocol.self]
        let session = URLSession(configuration: configuration)
        let conversionService = ConversionService(conversionSession: session)
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        conversionService.getChangeRates { (success, searchRate) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(searchRate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
    }

    func testGetRatesShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        TestURLProtocol.loadingHandler = { request in
            let response: HTTPURLResponse = FakeResponseData.responseKO
            let error: Error? = nil
            let data: Data? = FakeResponseData.conversionCorrectData
            return (response, data, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestURLProtocol.self]
        let session = URLSession(configuration: configuration)
        let conversionService = ConversionService(conversionSession: session)
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        conversionService.getChangeRates { (success, searchRate) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(searchRate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetRatesShouldPostFailedCallbackIfIncorrectData() {
        /// Given
        TestURLProtocol.loadingHandler = { request in
            let response: HTTPURLResponse = FakeResponseData.responseOK
            let error: Error? = nil
            let data: Data? = FakeResponseData.conversionIncorrectData
            return (response, data, error)
        }
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestURLProtocol.self]
        let session = URLSession(configuration: configuration)
        let conversionService = ConversionService(conversionSession: session)
        // When
        conversionService.getChangeRates{(success, searchRate) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(searchRate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetRatesShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        TestURLProtocol.loadingHandler = { request in
            let response: HTTPURLResponse = FakeResponseData.responseOK
            let error: Error? = nil
            let data: Data? = FakeResponseData.conversionCorrectData
            return (response, data, error)
        }
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestURLProtocol.self]
        let session = URLSession(configuration: configuration)
        let conversionService = ConversionService(conversionSession: session)
        // When
        conversionService.getChangeRates{(success, searchRate) in
            let rate = 1.109607
            let index = 0
            let date = "2022-03-31"
            let euroNumber = 1.0
            let dollarNumber = "114.5"
            let convert = self.conversion.euroToDollarConvert(euroNumber: euroNumber, index: index)
            // Then
            XCTAssertTrue(success)
            XCTAssertNotNil(searchRate)
            XCTAssertEqual(rate, searchRate!.rates.USD)
            XCTAssertEqual(date, searchRate!.date)
            XCTAssertEqual(self.conversion.convertDate(date: date), "31-03-2022")
            XCTAssertEqual(convert, dollarNumber)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    
}
    // MARK: - conversion function tests
    func testConvertUserEntrerConvertedInCorrectString() {
        let result = 1.5
        let stringTaped = conversion.stringToDouble(textToTransform: "1,5")
        XCTAssertEqual(result, stringTaped)
    }

    func testErrorInFormatOfNumber() {
        let doubleError = 0.0
        let stringError = conversion.stringToDouble(textToTransform: "t2")
        XCTAssertEqual(doubleError, stringError)

    }
    
}
   

