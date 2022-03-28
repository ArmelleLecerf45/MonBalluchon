//
//  MeteoService.swift
//  MonBalluchon
//
//  Created by macmini-Armelle on 28/03/2022.
//

import Foundation
class MeteoService {
    // MARK: - Singleton pattern
    static var shared = MeteoService()
    private init() {}
   
    // MARK: - Attribute & init
    private var task : URLSessionDataTask?
    private var weatherSession = URLSession(configuration: .default)

    init(weatherSession: URLSession) {
        self.weatherSession = weatherSession
    }
    
    // MARK: - Sending alert notification
    private func sendAlertNotification(message : String) {
        let alertName = Notification.Name("alertDisplay")
        NotificationCenter.default.post(name: alertName, object: nil, userInfo: ["message": message])
    } // end of sendAlertNotification
    
    func getMeteo() {
        
    }
    
    
    
    
    // MARK: - building URL
    private func selectedCityURL(cityName: String) -> URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5/weather"
        urlComponents.queryItems = [
            URLQueryItem(name: "APPID", value: "42ef11e464f874781da0ff6e8f8e972d "),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "lang", value: "fr"),
            URLQueryItem(name: "q", value: "\(cityName)")
        ]
        guard let url = urlComponents.url else {
            fatalError("Could not create URL from components")
        }
        return url
    } // end of selectedCityUrl
    
    // MARK: request creation

    func createWeatherRequest(city: String) -> URLRequest {
        var request = URLRequest(url: selectedCityURL(cityName: city))
        request.httpMethod = "GET"
        return request
    } // end of createWeatherRequest

    // MARK: - date conversion from Int to String
    func convertDt(dt: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(dt))
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.locale = Locale(identifier: "fr_FR")
        dayTimePeriodFormatter.dateFormat = "dd MMM YYYY à hh:mm"

        let dateString = dayTimePeriodFormatter.string(from: date)
        return dateString
    } // end of convertDt

}
