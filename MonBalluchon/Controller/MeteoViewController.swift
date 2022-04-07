//
//  MeteoViewController.swift
//  MonBalluchon
//
//  Created by macmini-Armelle on 30/03/2022.
//

import UIKit

class MeteoViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchTownButton: UIButton!
    @IBOutlet weak var chosenTownTemp: UILabel!
    @IBOutlet weak var choosenTown: UITextField!
    @IBOutlet weak var chosenTownConditions: UILabel!
    @IBOutlet weak var NYIcon: UIImageView!
    @IBOutlet weak var NYConditions: UILabel!
    @IBOutlet weak var NYTemp: UILabel!
    @IBOutlet weak var newYorkname: UILabel!
    @IBOutlet weak var TownIchosed: UILabel!
    @IBOutlet weak var chosenTownIcon: UIImageView!
    
    @IBOutlet weak var dayDate: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(presentAlert(notification:)), name: Notification.Name("alertDisplay"), object: nil)
        activityIndicator.isHidden = true
        
        searchTownButtonTaped()
        
        TownIchosed.textColor = .blue
        newYorkname.textColor = .purple
    } // end of viewDidLoad

    @objc private func presentAlert(notification : Notification) {
        guard let alertInfo = notification.userInfo!["message"] as? String else { return }

        let alert = UIAlertController(title: "Erreur", message: alertInfo, preferredStyle: .alert)
        let action  = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    } // end of presentAlert

    // MARK: - keyboard control
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        choosenTown.resignFirstResponder()
        searchTownButtonTaped()
    } // end of dismissKeyboard

    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        choosenTown.resignFirstResponder()
        searchTownButtonTaped()
        return true
    } // end of textFieldShouldReturn

    // MARK: - IBAction : button control

   
    @IBAction func searchTownButtonTaped(){
     
        toggleActivityIndicator(shown: true)
        choosenTown.resignFirstResponder()
        MeteoService.shared.getMeteo(town: choosenTown.text!) { (true, searchWeather) in
            self.toggleActivityIndicator(shown: false)
            if true, let resultWeather = searchWeather {
                self.displayWeatherInfo(weather: resultWeather)
                self.NYWeatherUpdate()
            }
        }
    }// end of searchButtonTaped

    private func NYWeatherUpdate() {
        MeteoService.shared.getMeteo(town: "new york") { (true, searchWeather) in
            if true, let NYWeather = searchWeather {
                let NYdegreeDec = String(NYWeather.main.temp)
                self.NYTemp.text = "\(NYdegreeDec)°C"
                self.NYIcon.image = UIImage(named: "\(NYWeather.weather[0].icon).png")
                self.NYConditions.text = NYWeather.weather[0].description
            }
        }
    } // end of NYWeatherUpdate

    private func displayWeatherInfo(weather: MyData) {
       
        let degreeDec = String(weather.main.temp)
       
        
        chosenTownTemp.text = "\(degreeDec)°C"
        dayDate.text = MeteoService.shared.convertDt(dt: weather.dt)
        chosenTownIcon.image = UIImage(named: "\(weather.weather[0].icon).png")
        chosenTownConditions.text = weather.weather[0].description
        TownIchosed.text = choosenTown.text
    } // end fo displayWeatherInfo

    private func toggleActivityIndicator(shown: Bool) {
        searchTownButton.isHidden = shown
        activityIndicator.isHidden = !shown
    } // end of toggleActivityIndicator

} // end of MeteoViewController

    


   
   

    

