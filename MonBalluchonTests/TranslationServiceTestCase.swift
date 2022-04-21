//
//  TranslationServiceTestCase.swift
//  MonBalluchonTests
//
//  Created by macmini-Armelle on 03/04/2022.
//

import XCTest
@testable import MonBalluchon
class TranslationServiceTestCase: XCTestCase {
    var translation: TranslationService!
    private let languageIndex = 0
    private let textToTranslate = "bonjour"

    override func setUp() {
        super.setUp()
        TestURLProtocol.loadingHandler = { request in
            let response: HTTPURLResponse = FakeResponseData.responseOK
            let error: Error? = nil
            let data: Data? = FakeResponseData.translationCorrectData
            return (response, data, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestURLProtocol.self]
        let session = URLSession(configuration: configuration)
        translation = TranslationService(translationSession: session)
        
        TestURLProtocol.loadingHandler = { request in
            let response: HTTPURLResponse = FakeResponseData.responseOK
            let error: Error? = nil
            let data: Data? = FakeResponseData.translationCorrectDataDe
            return (response, data, error)
        }
        let configurationDe = URLSessionConfiguration.ephemeral
        configurationDe.protocolClasses = [TestURLProtocol.self]
        let sessionDe = URLSession(configuration: configuration)
        translation = TranslationService(translationSession: sessionDe)
       
        
        TestURLProtocol.loadingHandler = { request in
            let response: HTTPURLResponse = FakeResponseData.responseOK
            let error: Error? = nil
            let data: Data? = FakeResponseData.translationCorrectDataDe
            return (response, data, error)
        }
        let configurationIt = URLSessionConfiguration.ephemeral
        configurationIt.protocolClasses = [TestURLProtocol.self]
        let sessionIt = URLSession(configuration: configuration)
        translation = TranslationService(translationSession: sessionIt)
        
        TestURLProtocol.loadingHandler = { request in
            let response: HTTPURLResponse = FakeResponseData.responseOK
            let error: Error? = nil
            let data: Data? = FakeResponseData.translationCorrectDataIt
            return (response, data, error)
        }
        let configurationEs = URLSessionConfiguration.ephemeral
        configurationEs.protocolClasses = [TestURLProtocol.self]
        let sessionEs = URLSession(configuration: configuration)
        translation = TranslationService(translationSession: sessionEs)
        
        TestURLProtocol.loadingHandler = { request in
            let response: HTTPURLResponse = FakeResponseData.responseOK
            let error: Error? = nil
            let data: Data? = FakeResponseData.translationCorrectDataEs
            return (response, data, error)
        }
        
        let configurationRu = URLSessionConfiguration.ephemeral
        configurationRu.protocolClasses = [TestURLProtocol.self]
        let sessionRu = URLSession(configuration: configuration)
        translation = TranslationService(translationSession: sessionRu)
        
        TestURLProtocol.loadingHandler = { request in
            let response: HTTPURLResponse = FakeResponseData.responseOK
            let error: Error? = nil
            let data: Data? = FakeResponseData.translationCorrectDataRu
            return (response, data, error)
        }
    
    }
    
    // MARK: - Network call tests
    func testGetTranslationShouldPostFailedCallbackIfError() {
        // Given
        TestURLProtocol.loadingHandler = { request in
            let response: HTTPURLResponse = FakeResponseData.responseKO
            let error: Error? = FakeResponseData.translationError
            let data: Data? = nil
            return (response, data, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestURLProtocol.self]
        let session = URLSession(configuration: configuration)
        let translationService = TranslationService(translationSession: session)
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        translationService.getTranslation(languageIndex: languageIndex, textToTranslate: textToTranslate) { (success, traductedResponse) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(traductedResponse)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetTranslationShouldPostFailedCallbackIfNoData() {
        // Given
        TestURLProtocol.loadingHandler = { request in
            let response: HTTPURLResponse = FakeResponseData.responseOK
            let error: Error? = nil
            let data: Data? = nil
            return (response, data, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestURLProtocol.self]
        let session = URLSession(configuration: configuration)
        let translationService = TranslationService(translationSession: session)
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        translationService.getTranslation(languageIndex: languageIndex, textToTranslate: textToTranslate) { (success, traductedResponse) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(traductedResponse)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }

    func testGetTranslationShouldPostFailedCallbackIfIncorrectResponse() {
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
        let translationService = TranslationService(translationSession: session)
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translationService.getTranslation(languageIndex: languageIndex, textToTranslate: textToTranslate) { success, traductedResponse in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(traductedResponse)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetTranslationShouldPostFailedCallbackIfIncorrectData() {
        // Given
        TestURLProtocol.loadingHandler = { request in
            let response: HTTPURLResponse = FakeResponseData.responseOK
            let error: Error? = nil
            let data: Data? = FakeResponseData.conversionIncorrectData
            return (response, data, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestURLProtocol.self]
        let session = URLSession(configuration: configuration)
        let translationService = TranslationService(translationSession: session)
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translationService.getTranslation(languageIndex: languageIndex, textToTranslate: textToTranslate) { success, traductedResponse in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(traductedResponse)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }

    func testGetTranslationInEnglishShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        TestURLProtocol.loadingHandler = { request in
            let response: HTTPURLResponse = FakeResponseData.responseOK
            let error: Error? = nil
            let data: Data? = FakeResponseData.translationCorrectData
            return (response, data, error)
        }
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestURLProtocol.self]
        let session = URLSession(configuration: configuration)
        let translationService = TranslationService(translationSession: session)
         // When
        translationService.getTranslation(languageIndex: languageIndex, textToTranslate: textToTranslate) { (success, traductedResponse) in
            let text = "Hello"
            let detectedSourceLanguage = "fr"
            
            // Then
            XCTAssertTrue(success)
            XCTAssertNotNil(traductedResponse)
            XCTAssertEqual(text, traductedResponse!.data.translations[0].translatedText)
            XCTAssertEqual(detectedSourceLanguage, traductedResponse!.data.translations[0].detectedSourceLanguage)

            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    func testGetTranslationInDeutschShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        TestURLProtocol.loadingHandler = { request in
            let response: HTTPURLResponse = FakeResponseData.responseOK
            let error: Error? = nil
            let data: Data? = FakeResponseData.translationCorrectDataDe
            return (response, data, error)
        }
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestURLProtocol.self]
        let session = URLSession(configuration: configuration)
        let translationService = TranslationService(translationSession: session)
         // When
        translationService.getTranslation(languageIndex: languageIndex, textToTranslate: textToTranslate) { (success, traductedResponse) in
            let text = "Hallo"
            let detectedSourceLanguage = "fr"

            // Then
            XCTAssertTrue(success)
            XCTAssertNotNil(traductedResponse)
            XCTAssertEqual(text, traductedResponse!.data.translations[0].translatedText)
            XCTAssertEqual(detectedSourceLanguage, traductedResponse!.data.translations[0].detectedSourceLanguage)

            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    func testGetTranslationInItalianShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        TestURLProtocol.loadingHandler = { request in
            let response: HTTPURLResponse = FakeResponseData.responseOK
            let error: Error? = nil
            let data: Data? = FakeResponseData.translationCorrectDataIt
            return (response, data, error)
        }
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestURLProtocol.self]
        let session = URLSession(configuration: configuration)
        let translationService = TranslationService(translationSession: session)
         // When
        translationService.getTranslation(languageIndex: languageIndex, textToTranslate: textToTranslate) { (success, traductedResponse) in
            let text = "Buongiorno"
            let detectedSourceLanguage = "fr"

            // Then
            XCTAssertTrue(success)
            XCTAssertNotNil(traductedResponse)
            XCTAssertEqual(text, traductedResponse!.data.translations[0].translatedText)
            XCTAssertEqual(detectedSourceLanguage, traductedResponse!.data.translations[0].detectedSourceLanguage)

            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    func testGetTranslationInISpanishShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        TestURLProtocol.loadingHandler = { request in
            let response: HTTPURLResponse = FakeResponseData.responseOK
            let error: Error? = nil
            let data: Data? = FakeResponseData.translationCorrectDataEs
            return (response, data, error)
        }
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestURLProtocol.self]
        let session = URLSession(configuration: configuration)
        let translationService = TranslationService(translationSession: session)
         // When
        translationService.getTranslation(languageIndex: languageIndex, textToTranslate: textToTranslate) { (success, traductedResponse) in
            let text = "Buenos dias"
            let detectedSourceLanguage = "fr"

            // Then
            XCTAssertTrue(success)
            XCTAssertNotNil(traductedResponse)
            XCTAssertEqual(text, traductedResponse!.data.translations[0].translatedText)
            XCTAssertEqual(detectedSourceLanguage, traductedResponse!.data.translations[0].detectedSourceLanguage)

            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetTranslationInRussianShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        TestURLProtocol.loadingHandler = { request in
            let response: HTTPURLResponse = FakeResponseData.responseOK
            let error: Error? = nil
            let data: Data? = FakeResponseData.translationCorrectDataRu
            return (response, data, error)
        }
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestURLProtocol.self]
        let session = URLSession(configuration: configuration)
        let translationService = TranslationService(translationSession: session)
         // When
        translationService.getTranslation(languageIndex: languageIndex, textToTranslate: textToTranslate) { (success, traductedResponse) in
            let text = "доброе утро"
            let detectedSourceLanguage = "fr"

            // Then
            XCTAssertTrue(success)
            XCTAssertNotNil(traductedResponse)
            XCTAssertEqual(text, traductedResponse!.data.translations[0].translatedText)
            XCTAssertEqual(detectedSourceLanguage, traductedResponse!.data.translations[0].detectedSourceLanguage)

            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

}
