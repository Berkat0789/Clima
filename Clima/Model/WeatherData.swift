//
//  WeatherData.swift
//  Clima
//
//  Created by Berkat Bhatti on 8/23/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation



struct WeatherData: Decodable {
    let name: String
    let main: Temperature
    let weather: [Condition]
}
struct Temperature: Decodable {
    let temp: Double
}
struct Condition: Decodable {
    let description: String
    let id: Int
}
