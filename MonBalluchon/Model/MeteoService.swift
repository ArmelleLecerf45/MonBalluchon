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
    private var meteoSession = URLSession(configuration: .default)

    init(meteoSession: URLSession) {
        self.meteoSession = meteoSession
    }

    // MARK: - Sending alert notification
    private func sendAlertNotification(message : String) {
        let alertName = Notification.Name("alertDisplay")
        NotificationCenter.default.post(name: alertName, object: nil, userInfo: ["message": message])
    } // end of sendAlertNotification

    // MARK: - recovery and processing of weather
    func getMeteo(city: String, callback: @escaping (Bool, MyData?) -> Void) {
        let request = createWeatherRequest(city: city)

        task?.cancel()
        task = meteoSession.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    self.sendAlertNotification(message: "No response from server")
                    return
                }
                print("data OK")
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    print("No response from meteoSession")
                    self.sendAlertNotification(message: "No response from server, \nPlease check town's name !")
                    return
                }
                print("response status OK")
                guard let responseJSON = try? JSONDecoder().decode(MyData.self, from: data) else {
                    callback(false, nil)
                    print("Failed to decode meteoJSON")
                    self.sendAlertNotification(message: "Impossible to treat server's response ")
                    return
                }
                print("JSON OK")
                let searchMeteo: MyData = responseJSON
                callback(true, searchMeteo)
                print(searchMeteo)
            }
        }
        task?.resume()
    } // end of GetWeather

    // MARK: - URL & Request configuration
    private func selectedCityURL(cityName: String) -> URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5/weather"
        urlComponents.queryItems = [
            URLQueryItem(name: "APPID", value: "42ef11e464f874781da0ff6e8f8e972d"),
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
    } // end of convertDt

} // end of MeteoService
