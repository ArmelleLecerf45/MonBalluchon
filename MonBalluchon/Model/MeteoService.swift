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
    func getMeteo(town: String, callback: @escaping (Bool, MyData?) -> Void) {
        let request = createWeatherRequest(town: town)

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
                    self.sendAlertNotification(message: "Please choose a town !")
                    return
                }
                print("response's status OK")
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
    private func chosenTownURL(townName: String) -> URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5/weather"
        urlComponents.queryItems = [
            URLQueryItem(name: "APPID", value: "42ef11e464f874781da0ff6e8f8e972d"),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "lang", value: "fr"),
            URLQueryItem(name: "q", value: "\(townName)")
        ]
        guard let url = urlComponents.url else {
            fatalError("Could not create URL from components")
        }
        return url
    } // end of chosenTownURL

    func createWeatherRequest(town: String) -> URLRequest {
        var request = URLRequest(url: chosenTownURL(townName: town))
        request.httpMethod = "GET"
        return request
    } // end of createWeatherRequest

    // MARK: - date conversion
    func convertDt(dt: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(dt))
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.locale = Locale(identifier: "fr_FR")
        dayTimePeriodFormatter.dateFormat = "dd MMM YYYY à HH:mm"

        let dtString = dayTimePeriodFormatter.string(from: date)
        return dtString
    } // end of convertDt

} // end of MeteoService
