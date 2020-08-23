//
//  WeatherService.swift
//  Clima
//
//  Created by Berkat Bhatti on 8/12/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation


protocol WeatherDelegate {
    func didReceive(weather: Weather)
}

let apiKey = "94575f2b659527a9f2e2d58b8a2c7044"

struct WeatherService {
    
    
    var delegate: WeatherDelegate?
    
    func getWeatherDataFor(_ cityName: String) {
        let weatherURL = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(apiKey)&units=imperial"
        print(weatherURL)
        fetchWeatherData(from: weatherURL)
    }
    ///Get weathe from Coordinates
    
    func getWeatherDatafor(user coordinates: CLLocationCoordinate2D) {
        let coordURL = "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=\(apiKey)&units=imperial"
        print(coordURL)
        fetchWeatherData(from: coordURL)
    }
    
    ///Func to fetch weather data from API
    func fetchWeatherData(from url: String) {
        guard let url = URL(string: url) else {return}
        //Creating Session
        let session = URLSession(configuration: URLSessionConfiguration.default)
        ///Creating taks for session
        let task = session.dataTask(with: url) { (data, resource, error) in
            if error != nil {
                print("Here is the error \(error!)")
                return
            }
            if let returnedData = data {
                if let weatherData = self.decode(weather: returnedData) {
                    self.delegate?.didReceive(weather: weatherData)
                }
            }
        }
        
        task.resume()
    }
    //Decode the Data
    func decode(weather: Data) -> Weather? {
        let decoder = JSONDecoder()
        do {
            let decodedWeather = try decoder.decode(WeatherData.self, from: weather)
            let weather = Weather(name: decodedWeather.name, condition: decodedWeather.weather[0].description, id: decodedWeather.weather[0].id, temp: decodedWeather.main.temp)
            return weather
        } catch {
            print("Here is the error for the decoder \(error)")
            return nil
        }
    }
    
}
