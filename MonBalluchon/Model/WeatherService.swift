//
//  WeatherService.swift
//  MonBalluchon
//
//  Created by macmini-Armelle on 01/11/2021.
//

import Foundation

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

    // MARK:fonction getWeather, création de la requête.
    func getWeatherGien(city: String, callback: @escaping (Bool, MyData?) -> Void) {
       let request1 = createRequest(name: "gien")
        task?.cancel()
       
        task = weatherSession.dataTask(with: request1) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    self.sendAlertNotification(message: "Absence de réponse du serveur")
                    
                    return
                }
                print("data OK")
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    print("Aucune réponse de weatherSession")
                    self.sendAlertNotification(message: "Absence de réponse du serveur!")
                    
                    return
                }
                print("response status OK")
                guard let responseJSON = try? JSONDecoder().decode(MyData.self, from: data) else {
                    callback(false, nil)
                    print("Echec à décoder weatherJSON")
                    self.sendAlertNotification(message: "Impossible de traiter la réponse du serveur ")
                    return
                }
                print("JSON OK")
                let searchWheather: MyData = responseJSON
                callback(true, searchWheather)
                print(searchWheather)
                
                               let temperature = responseJSON.main.temp
                            let weatherId = responseJSON.weather[0].id
                                let weatherCondition = responseJSON.weather[0].main
                                let weatherDescription = responseJSON.weather[0].description
                                let weatherIcon = responseJSON.weather[0].icon
                                let townName = responseJSON.name
                let dayDate = responseJSON.dt
                let dateAJour = self.convertDt(dt: dayDate)
                                print(weatherId!)
                                print(weatherCondition)
                                print(weatherDescription)
                                print(weatherIcon)
                                print(townName)
                                print(dateAJour)
                                print (temperature!)}
                

                               
        }
        
    task?.resume()
            
            
        }
    func getWeatherNY(city: String, callback: @escaping (Bool, MyData?) -> Void) {
        let request2 = createRequest(name: "new york")
        
    
        task?.cancel()
       
        task = weatherSession.dataTask(with: request2) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    self.sendAlertNotification(message: "Absence de réponse du serveur")
                    return
                }
                print("data OK")
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    print("Aucune réponse de weatherSession")
                    self.sendAlertNotification(message: "Absence de réponse du serveur!")
                    return
                }
                print("response status OK")
                guard let responseJSON = try? JSONDecoder().decode(MyData.self, from: data) else {
                    callback(false, nil)
                    print("Echec à décoder weatherJSON")
                    self.sendAlertNotification(message: "Impossible de traiter la réponse du serveur ")
                    return
                }
                print("JSON OK")
                let searchWheather: MyData = responseJSON
                callback(true, searchWheather)
                print(searchWheather)
                
                               let temperature = responseJSON.main.temp
                            let weatherId = responseJSON.weather[0].id
                                let weatherCondition = responseJSON.weather[0].main
                                let weatherDescription = responseJSON.weather[0].description
                                let weatherIcon = responseJSON.weather[0].icon
                                let townName = responseJSON.name
                                let dayDate = responseJSON.dt
                                print(weatherId!)
                                print(weatherCondition)
                                print(weatherDescription)
                                print(weatherIcon)
                                print(townName)
                                print(dayDate)
                                print (temperature!)}
                

                               
        }
        
    task?.resume()
            
    
    }
                

// MARK: conversion de la date dt au format jour heure (am ou pm)
func convertDt(dt: Int) -> String {
        let todayDateAndTime = Date(timeIntervalSince1970: TimeInterval(dt))
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.locale = Locale(identifier: "fr_FR")
        dayTimePeriodFormatter.dateFormat = "dd MMM YYYY à hh:mm a"

        let dtString = dayTimePeriodFormatter.string(from: todayDateAndTime)
    
        return dtString
}
    
//creation de l'URL
    private func createCityURL(cityName: String) -> URL {
        var url = URLComponents()
        url.scheme = "https"
        url.host = "api.openweathermap.org"
        url.path = "/data/2.5/weather"
        url.queryItems = [
            URLQueryItem(name: "APPID", value: "42ef11e464f874781da0ff6e8f8e972d"),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "lang", value: "fr"),
            URLQueryItem(name: "q", value: "\(cityName)")
        ]
        guard let apiURL = url.url else {
            fatalError("Could not create URL from components")
        }
        return apiURL
    }
            
// creation de la requête
    func createRequest(name: String) -> URLRequest {
        var request = URLRequest(url: createCityURL(cityName: name))
        request.httpMethod = "GET"
        return request
    } // end of createWeatherRequest
  
            //Notification des alertes
    private func sendAlertNotification(message : String) {
        let alertName = Notification.Name("alertDisplay")
        NotificationCenter.default.post(name: alertName, object: nil, userInfo: ["message": message])
    } // end of sendAlertNotification

    
    }



