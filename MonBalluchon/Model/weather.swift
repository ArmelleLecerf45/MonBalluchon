//
//  Weather.swift
//  MonBalluchon
//
//  Created by macmini-Armelle on 07/11/2021.
//

import Foundation
struct MyData : Decodable {
   
    var main : Main
    var weather : [Weather]
    var dt : Int
    var name : String
}
struct Main : Decodable{
   var temp : Float?
    
}
struct Weather : Decodable{
   var id : Int?
   var  main : String
    var description : String
    var icon : String
}
