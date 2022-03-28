//
//  WeatherViewController.swift
//  MonBalluchon
//
//  Created by macmini-Armelle on 30/05/2021.
//

import UIKit

class WeatherViewController: UIViewController {
    // MARK: - IBOutlet
  @IBOutlet weak var nyName: UILabel!
  @IBOutlet weak var gienName: UILabel!
  @IBOutlet weak var nyTemperature: UILabel!
  @IBOutlet weak var gienTemperature: UILabel!
  @IBOutlet weak var nyIcone: UIImageView!
  @IBOutlet weak var gienIcone: UIImageView!
  @IBOutlet weak var nyDescriptionWeather: UILabel!
  @IBOutlet weak var gienDescriptionWeather: UILabel!
  @IBOutlet weak var MiseAJour: UIButton!
  @IBOutlet weak var dateDuJour: UILabel!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - viewDidLoad 

        override func viewDidLoad() {
            super.viewDidLoad()
            NotificationCenter.default.addObserver(self, selector: #selector(presentAlert(notification:)), name: Notification.Name("alertDisplay"), object: nil)
            self.nyName.text = "New York"
            self.gienName.text = "Gien"
            NYWeatherUpdate()
            GienWeatherUpdate()
        } // end of viewDidLoad

    @IBAction func tappedMiseAJourButton() {
        
    }
    @objc private func presentAlert(notification : Notification) {
            guard let alertInfo = notification.userInfo!["message"] as? String else { return }

            let alert = UIAlertController(title: "Erreur", message: alertInfo, preferredStyle: .alert)
            let action  = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        } // end of presentAlert

    private func displayWeatherInfo(weather: MyData) {
    //let degreeInt = Int(weather.main.temp)
   // degree.text = "\(degreeInt)°C"
    dateDuJour.text = WeatherService.sharedInstance.convertDt(dt: weather.dt)
   // iconWeather.image = UIImage(named: "\(weather.weather[0].icon).png")
  //  descriptionWeather.text = weather.weather[0].description
} // end of displayWeatherInfo
//
    private func NYWeatherUpdate() {
        WeatherService.sharedInstance.getWeather(city: "new york") { (true, searchWeather) in
            if true, let NYWeather = searchWeather {
                let nydegreeInt = Int(NYWeather.main.temp)
                self.nyTemperature.text = "\(nydegreeInt)°C"
                self.nyIcone.image = UIImage(named: "\(NYWeather.weather[0].icon).png")
                self.nyDescriptionWeather.text = NYWeather.weather[0].description
            }
        }
    } // end of NYWeatherUpdate
   
       

            

    

    

    private func GienWeatherUpdate() {
        WeatherService.sharedInstance.getWeather(city: "gien") { (true, searchWeather) in
            if true, let GienWeather = searchWeather {
                let gienDegreeInt = Int(GienWeather.main.temp)
                self.gienTemperature.text = "\(gienDegreeInt)°C"
                self.gienIcone.image = UIImage(named: "\(GienWeather.weather[0].icon).png")
                self.gienDescriptionWeather.text = GienWeather.weather[0].description
            }
        }
    } // end of GienWeatherUpdate


}
    




   



    

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

//    private func NYWeatherUpdate() {
//        WeatherService.sharedInstance.getWeather(city: "new york") { (true, searchWeather) in
//            if true, let NYWeather = searchWeather {
//                let NYdegreeInt = Int(NYWeather.main.temp)
//                self.NYdegree.text = "\(NYdegreeInt)°C"
//                self.NYiconWeather.image = UIImage(named: "\(NYWeather.weather[0].icon).png")
//                self.NYdescriptionWeather.text = NYWeather.weather[0].description
//            }
//        }
//    } // end of NYWeatherUpdate
//
//
//
//    private func toggleActivityIndicator(shown: Bool) {
//       activityIndicator.isHidden = !shown
//    } // end of toggleActivityIndicator

