//
//  WeatherViewController.swift
//  MonBalluchon
//
//  Created by macmini-Armelle on 30/05/2021.
//

import UIKit

//class WeatherViewController: UIViewController {
//    // MARK: - IBOutlet
//  //Ajouter l'activity indicator et le connecter
//
//    @IBOutlet weak var DateDuJour: UILabel!
//
//    @IBOutlet weak var newYorkCityName: UILabel!
//
//    @IBOutlet weak var nytemperature: UILabel!
//
//    @IBOutlet weak var nyIcone: UIImageView!
//
//    @IBOutlet weak var nyDescriptionWeather: UILabel!
//
//    @IBOutlet weak var gienCityName: UILabel!
//
//    @IBOutlet weak var gienTemperature: UILabel!
//
//    @IBOutlet weak var gienIcone: UIImageView!
//
//    @IBOutlet weak var gienDescriptionWeather: UILabel!
//
//
//
//
//
//    // MARK: - viewDidLoad & presentAlert
//
//        override func viewDidLoad() {
//            super.viewDidLoad()
//
////            NotificationCenter.default.addObserver(self, selector: #selector(presentAlert(notification:)), name: Notification.Name("alertDisplay"), object: nil)
//
//
//        } // end of viewDidLoad
//
//        @objc private func presentAlert(notification : Notification) {
//            guard let alertInfo = notification.userInfo!["message"] as? String else { return }
//
//            let alert = UIAlertController(title: "Erreur", message: alertInfo, preferredStyle: .alert)
//            let action  = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//            alert.addAction(action)
//            present(alert, animated: true, completion: nil)
//        } // end of presentAlert
//
//    private func displayWeatherInfo(weather: MyData) {
//        self.DateDuJour.text = WeatherService.sharedInstance.convertDt(dt: weather.dt)
//        let degreeInt = Int(weather.main.temp)
//        nytemperature.text = "\(degreeInt)°C"
//
//        nyIcone.image = UIImage(named: "\(weather.weather[0].icon).png")
//        nyDescriptionWeather.text = weather.weather[0].description
//    } // end of displayWeatherInfo
//
//    private func NYWeatherUpdate() {
//        WeatherService.sharedInstance.getWeather(city: "new york") { (true, searchWeather) in
//            if true, let NYWeather = searchWeather {
//                let nydegreeInt = Int(NYWeather.main.temp)
//                self.nytemperature.text = "\(nydegreeInt)°C"
//                self.nyIcone.image = UIImage(named: "\(NYWeather.weather[0].icon).png")
//                self.nyDescriptionWeather.text = NYWeather.weather[0].description
//            }
//        }
//    } // end of NYWeatherUpdate
//    @IBAction func MiseAJour(_ sender: Any) {
//
//
//
//        WeatherService.sharedInstance.getWeather(city: "new york") { (true, searchWeather) in
//
//             self.NYWeatherUpdate()
//
//            }
//        WeatherService.sharedInstance.getWeather(city: "gien") { (true, searchWeather) in
//            self.GienWeatherUpdate()
//
//    }
//
//    }
//
//    private func GienWeatherUpdate() {
//        WeatherService.sharedInstance.getWeather(city: "gien") { (true, searchWeather) in
//            if true, let GienWeather = searchWeather {
//                let gienDegreeInt = Int(GienWeather.main.temp)
//                self.gienTemperature.text = "\(gienDegreeInt)°C"
//                self.gienIcone.image = UIImage(named: "\(GienWeather.weather[0].icon).png")
//                self.nyDescriptionWeather.text = GienWeather.weather[0].description
//            }
//        }
//    } // end of GienWeatherUpdate
////
//
//}
    


class WeatherViewController: UIViewController, UITextFieldDelegate {

    // MARK: - IBOutlet
  //  @IBOutlet weak var city: UITextField!
    @IBOutlet weak var iconWeather: UIImageView!
    @IBOutlet weak var degree: UILabel!
    @IBOutlet weak var descriptionWeather: UILabel!
    @IBOutlet weak var update: UILabel!

    @IBOutlet weak var NYiconWeather: UIImageView!
    @IBOutlet weak var NYdegree: UILabel!
    @IBOutlet weak var NYdescriptionWeather: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchCityButton: UIButton!

// MARK: - viewDidLoad & presentAlert
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(presentAlert(notification:)), name: Notification.Name("alertDisplay"), object: nil)
        activityIndicator.isHidden = true
     //   searchButtonTaped()
    } // end of viewDidLoad

    @objc private func presentAlert(notification : Notification) {
        guard let alertInfo = notification.userInfo!["message"] as? String else { return }

        let alert = UIAlertController(title: "Erreur", message: alertInfo, preferredStyle: .alert)
        let action  = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    } // end of presentAlert

//    // MARK: - keyboard control
//    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
//        city.resignFirstResponder()
//        searchButtonTaped()
//    } // end of dismissKeyboard

//    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        city.resignFirstResponder()
//        searchButtonTaped()
//        return true
//    } // end of textFieldShouldReturn

//    // MARK: - IBAction : button control
//    @IBAction func searchButtonTaped() {
//        toggleActivityIndicator(shown: true)
////        city.resignFirstResponder()
//        WeatherService.sharedInstance.getWeather(city: city.text!) { (true, searchWeather) in
//            self.toggleActivityIndicator(shown: false)
//            if true, let resultWeather = searchWeather {
//                self.displayWeatherInfo(weather: resultWeather)
//                self.NYWeatherUpdate()
//            }
//        }
//    }// end of searchButtonTaped

    private func NYWeatherUpdate() {
        WeatherService.sharedInstance.getWeather(city: "new york") { (true, searchWeather) in
            if true, let NYWeather = searchWeather {
                let NYdegreeInt = Int(NYWeather.main.temp)
                self.NYdegree.text = "\(NYdegreeInt)°C"
                self.NYiconWeather.image = UIImage(named: "\(NYWeather.weather[0].icon).png")
                self.NYdescriptionWeather.text = NYWeather.weather[0].description
            }
        }
    } // end of NYWeatherUpdate

    private func displayWeatherInfo(weather: MyData) {
        let degreeInt = Int(weather.main.temp)
        degree.text = "\(degreeInt)°C"
        update.text = WeatherService.sharedInstance.convertDt(dt: weather.dt)
        iconWeather.image = UIImage(named: "\(weather.weather[0].icon).png")
        descriptionWeather.text = weather.weather[0].description
    } // end of displayWeatherInfo

    private func toggleActivityIndicator(shown: Bool) {
        searchCityButton.isHidden = shown
        activityIndicator.isHidden = !shown
    } // end of toggleActivityIndicator

} // end of WeatherViewController

    
