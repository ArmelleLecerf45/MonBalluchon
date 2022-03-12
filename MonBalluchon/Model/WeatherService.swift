//
//  WeatherService.swift
//  MonBalluchon
//
//  Created by macmini-Armelle on 01/11/2021.
//

import Foundation
import UIKit

// MARK: création de la classe WeatherService
class WeatherService{
    
    // MARK: - Singleton pattern
    static var sharedInstance = WeatherService()
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

    // MARK: - recovery and processing of weather
    func getWeather(city: String, callback: @escaping (Bool, MyData?) -> Void) {
        let resquest = createWeatherRequest(city: city)

        task?.cancel()
        task = weatherSession.dataTask(with: resquest) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    self.sendAlertNotification(message: "Absence de réponse-TEST1 du serveur")
                   
                    return
                }
                
                print("data OK")
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    print("No response from weatherSession")
                    self.sendAlertNotification(message: "Absence de réponse du serveur, \nVeuillez vérifier le nom de la ville !")
                    return
                }
                print("response status OK")
                guard let responseJSON = try? JSONDecoder().decode(MyData.self, from: data) else {
                    callback(false, nil)
                    print("Failed to decode weatherJSON")
                    self.sendAlertNotification(message: "Impossible de traiter la réponse du serveur ")
                    return
                }
                print("JSON OK")
                let searchWheather: MyData = responseJSON
                callback(true, searchWheather)
                print(searchWheather)
            }
        }
        task?.resume()
    } // end fo GetWeather

    // MARK: - URL & Request configuration
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
    } // end of selectedCityURL

    func createWeatherRequest(city: String) -> URLRequest {
        var request = URLRequest(url: selectedCityURL(cityName: city))
        request.httpMethod = "GET"
        return request
    } // end of createWeatherRequest

    // MARK: - date conversion
    func convertDt(dt: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(dt))
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.locale = Locale(identifier: "fr_FR")
        dayTimePeriodFormatter.dateFormat = "dd MMM YYYY à hh:mm"

        let dateString = dayTimePeriodFormatter.string(from: date)
        return dateString
    } // end of convertDate

} // end of WeatherService

