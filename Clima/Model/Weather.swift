//
//  Weather.swift
//  Clima
//
//  Created by Berkat Bhatti on 8/12/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation




struct Weather {
    let name: String
    let condition: String
    let id: Int
    let temp: Double
    
    
    var tempString: String {
        return String(format: "%.1f", temp)
    }
    
    var imageName: String {
       switch id {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    
    
}
