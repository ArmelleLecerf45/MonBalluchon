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
    private let text1ToTranslate = "bonjour"
    private let text2ToTranslate = "La petite fille joue"
    private let text3ToTranslate = "mon chat est noir"
    private let text4ToTranslate = "Le papa va travailler"
    private let text5ToTranslate = "le jardin est grand"
    private let text6ToTranslate = ""
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

        translationService.getTranslation(languageIndex: languageIndex, textToTranslate: text1ToTranslate) { (success, traductedResponse) in
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

        translationService.getTranslation(languageIndex: languageIndex, textToTranslate: text1ToTranslate) { (success, traductedResponse) in
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
        translationService.getTranslation(languageIndex: languageIndex, textToTranslate: text1ToTranslate) { success, traductedResponse in
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
        translationService.getTranslation(languageIndex: languageIndex, textToTranslate: text1ToTranslate) { success, traductedResponse in
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
        translationService.getTranslation(languageIndex: languageIndex, textToTranslate: text1ToTranslate) { (success, traductedResponse) in
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
        translationService.getTranslation(languageIndex: languageIndex, textToTranslate: text2ToTranslate) { (success, traductedResponse) in
            let text = "das kleine Mädchen spielt"
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
        translationService.getTranslation(languageIndex: languageIndex, textToTranslate: text3ToTranslate) { (success, traductedResponse) in
            let text = "il mio gatto è nero"
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
        translationService.getTranslation(languageIndex: languageIndex, textToTranslate: text4ToTranslate) { (success, traductedResponse) in
            let text = "papá va a trabajar"
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
        translationService.getTranslation(languageIndex: languageIndex, textToTranslate: text5ToTranslate) { (success, traductedResponse) in
            let text = "сад большой"
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
    func testLanguageEnglish() {
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
            
            let language = translationService.selectedLanguage(index: 0)
                // Then
            XCTAssertTrue(language == "en")
            expectation.fulfill()
            wait(for: [expectation], timeout: 0.01)
        }
        
        func testLanguageFrench() {
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
            
            let language = translationService.selectedLanguage(index: 1)
            // Then
            XCTAssertTrue(language == "fr")
            expectation.fulfill()
            wait(for: [expectation], timeout: 0.01)
        
        }
        
        func testLanguageGerman() {
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
            
            let language = translationService.selectedLanguage(index: 2)
            // Then
            XCTAssertTrue(language == "de")
            expectation.fulfill()
            wait(for: [expectation], timeout: 0.01)
        }
        
        func testLanguageSpanish() {
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
            
            let language = translationService.selectedLanguage(index: 3)
            // Then
            XCTAssertTrue(language == "es")
            expectation.fulfill()
            wait(for: [expectation], timeout: 0.01)
        }
        
        func testLanguageItalian() {
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
            
            let language = translationService.selectedLanguage(index: 4)
            // Then
            XCTAssertTrue(language == "it")
            expectation.fulfill()
            wait(for: [expectation], timeout: 0.01)
        }
        func testLanguageRussian() {
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
            
            let language = translationService.selectedLanguage(index: 5)
            // Then
            XCTAssertTrue(language == "ru")
            expectation.fulfill()
            wait(for: [expectation], timeout: 0.01)
        }
        func testLanguageGreek() {
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
            
            let language = translationService.selectedLanguage(index: 6)
            // Then
            XCTAssertTrue(language == "el")
            expectation.fulfill()
            wait(for: [expectation], timeout: 0.01)
        }
        func testLanguagePortuguese() {
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
            
            let language = translationService.selectedLanguage(index: 7)
            // Then
            XCTAssertTrue(language == "pt")
            expectation.fulfill()
            wait(for: [expectation], timeout: 0.01)
        }
        func testLanguageOther() {
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
            
            let language = translationService.selectedLanguage(index: 99)
            // Then
            XCTAssertTrue(language == "en")
            expectation.fulfill()
            wait(for: [expectation], timeout: 0.01)
        }

}

