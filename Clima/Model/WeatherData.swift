//
//  WeatherData.swift
//  Clima
//
//  Created by Berkat Bhatti on 8/12/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation



struct WeatherData: Decodable {
    let name: String
    let weather: [Condition]
    let main: Temperature
}
struct Condition: Decodable {
    let description: String
    let id: Int
}
struct Temperature: Decodable {
    let temp: Double
}
