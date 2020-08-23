//
//  Weather.swift
//  Clima
//
//  Created by Berkat Bhatti on 8/23/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation



struct Weather {

    let cityName: String
    let id: Int
    let description: String
    let temp: Double
    
    
    //Computed property for the temperature
    
    var tempString: String {
        return String(format: "%.2f", temp)
    }
    
}
