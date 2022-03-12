//
//  WeatherViewController.swift
//  MonBalluchon
//
//  Created by macmini-Armelle on 30/05/2021.
//

import UIKit

class WeatherViewController: UIViewController {
    // MARK: - IBOutlet
  //Ajouter l'activity indicator et le connecter
    @IBOutlet weak var dateDuJour: UILabel!
    
    @IBOutlet weak var newYorkCityName: UILabel!
    
    @IBOutlet weak var nytemperature: UILabel!
    
    @IBOutlet weak var nyIcone: UIImageView!
    
    @IBOutlet weak var nyDescriptionWeather: UILabel!
    
    @IBOutlet weak var gienCityName: UILabel!
    
    @IBOutlet weak var gienTemperature: UILabel!
    
    @IBOutlet weak var gienIcone: UIImageView!
    
    @IBOutlet weak var gienDescriptionWeather: UILabel!
    
    @IBOutlet weak var miseAJour: UIButton!
    
    
    // MARK: - viewDidLoad & presentAlert
    
        override func viewDidLoad() {
            super.viewDidLoad()
            NotificationCenter.default.addObserver(self, selector: #selector(presentAlert(notification:)), name: Notification.Name("alertDisplay"), object: nil)
            newYorkCityName.textColor = .blue
            newYorkCityName.font = .boldSystemFont(ofSize: 35)
            gienCityName.textColor = .red
            gienCityName.font = .boldSystemFont(ofSize: 35)
            self.GienWeatherUpdate()
            self.NYWeatherUpdate()
            self.updateButton()
        } // end of viewDidLoad

        @objc private func presentAlert(notification : Notification) {
            guard let alertInfo = notification.userInfo!["message"] as? String else { return }

            let alert = UIAlertController(title: "Erreur", message: alertInfo, preferredStyle: .alert)
            let action  = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        } // end of presentAlert

    private func displayWeatherInfo(weather: MyData) {
        self.dateDuJour.text = WeatherService.sharedInstance.convertDt(dt: weather.dt)
        let degreeInt = Int(weather.main.temp)
        nytemperature.text = "\(degreeInt)°C"
        dateDuJour.text = WeatherService.sharedInstance.convertDt(dt:  weather.dt)
        nyIcone.image = UIImage(named: "\(weather.weather[0].icon).png")
        nyDescriptionWeather.text = weather.weather[0].description
    } // end of displayWeatherInfo
    
    private func NYWeatherUpdate() {
        WeatherService.sharedInstance.getWeather(city: "new york") { (true, searchWeather) in
            if true, let NYWeather = searchWeather {
                let nydegreeInt = Int(NYWeather.main.temp)
                self.nytemperature.text = "\(nydegreeInt)°C"
                self.nyIcone.image = UIImage(named: "\(NYWeather.weather[0].icon).png")
                self.nyDescriptionWeather.text = NYWeather.weather[0].description
            }
        }
    } // end of NYWeatherUpdate
    
    @IBAction func updateButton() {
        WeatherService.sharedInstance.getWeather(city: "new york") { (true, searchWeather) in
            
             self.NYWeatherUpdate()
            
            }
        WeatherService.sharedInstance.getWeather(city: "gien") { (true, searchWeather) in
            self.GienWeatherUpdate()
    }
    
    }
    private func GienWeatherUpdate() {
        WeatherService.sharedInstance.getWeather(city: "gien") { (true, searchWeather) in
            if true, let GienWeather = searchWeather {
                let gienDegreeInt = Int(GienWeather.main.temp)
                self.gienTemperature.text = "\(gienDegreeInt)°C"
                self.gienIcone.image = UIImage(named: "\(GienWeather.weather[0].icon).png")
                self.nyDescriptionWeather.text = GienWeather.weather[0].description
            }
        }
    } // end of GienWeatherUpdate
//
   
   
    
}
    
    
