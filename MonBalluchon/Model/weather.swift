//
//  weather.swift
//  MonBalluchon
//
//  Created by macmini-Armelle on 14/10/2021.
//

import Foundation
class Weather{
private static let weatherURL=URL(string: "api.openweathermap.org/data/2.5/weather?q={Gien}&appid={fd950a8245079d9cdddded5a65e935b1}")!
    static func getWeather(){
        var request = URLRequest(url : weatherURL)
        request.httpMethod = "POST"
        let body = "lang=fr&units=metrics&format=json"
        request.httpBody = body.data(using: .utf8)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, response, error) in
            if let data = data, error == nil {
                    if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                        if let responseJSON = try? JSONDecoder().decode([String: String].self, from: data),
            let date = responseJSON["dt"],
            let temp = responseJSON["temp"],
             let id = responseJSON["id"]
                        {
            print(date)
            print(temp)
            print(id)
                        }
                }        }
        
        
    }
        task.resume()
        
    }
}
