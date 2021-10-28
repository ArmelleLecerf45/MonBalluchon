//
//  WeatherViewController.swift
//  MonBalluchon
//
//  Created by macmini-Armelle on 30/05/2021.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var ville: UILabel!
    
    @IBOutlet weak var imageTemps: UIImageView!
    @IBOutlet weak var temperature: UILabel!
   
    @IBOutlet weak var ville2: NSLayoutConstraint!
   
    @IBOutlet weak var temperature2: UILabel!
    
    @IBOutlet weak var imageTemps2: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        Weather.getWeather()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
