//
//  Meteo.swift
//  MonBalluchon
//
//  Created by macmini-Armelle on 01/04/2022.
//

import Foundation
struct MyData : Decodable {
   
    let main : Main
    let weather : [Weather]
    let dt : Int
    let name : String
}
struct Main : Decodable{
   let temp : Double
    
}
struct Weather : Decodable{
   let id : Int
   let  main : String
    let description : String
    let icon : String
}
