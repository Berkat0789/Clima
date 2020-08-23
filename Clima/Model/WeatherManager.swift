//
//  WeatherManager.swift
//  Clima
//
//  Created by Berkat Bhatti on 8/23/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

// Protocol to pass data
protocol weatherDelegate {
    func didReceiveWeatherData(weather: Weather)
}

struct WeatherManager {
    
    var delegate: weatherDelegate?
    
    func getWeatherDatafor(cityName: String) {
        let url = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(PrivateServive.apiKEy)&units=imperial"
        fetchWeatherDatafor(url: url)
        print(url)
    }
    
    func getWeatherDataFor(location: CLLocationCoordinate2D) {
        let locaitonURL = "https://api.openweathermap.org/data/2.5/weather?lat=\(location.latitude)&lon=\(location.longitude)&appid=\(PrivateServive.apiKEy)&units=imperial"
        print(locaitonURL)
        fetchWeatherDatafor(url: locaitonURL)
    }
    func fetchWeatherDatafor(url: String) {
        guard let url = URL(string: url) else {return}
        //Create url session
        let session = URLSession(configuration: URLSessionConfiguration.default)
        //Set up task
        let task = session.dataTask(with: url) { (data, response, error) in
            if let err = error {
                print("HERe is the the error fetching weather data \(err)")
            } else {
                // There was no error/ ecode the data
                if let returnedData = data {
                    let dataString = String(data: returnedData, encoding: String.Encoding.utf8)
                    print("\(dataString!)")
                    if let weather = self.decodeWeatherData(data: returnedData) {
                        self.delegate?.didReceiveWeatherData(weather: weather)
                    }
                }
            }
        }
        task.resume()
    }
    //Decoding the data for processing
    func decodeWeatherData(data: Data) -> Weather? {
        // create decoder
        let decoder = JSONDecoder()
        do {
            let weather = try decoder.decode(WeatherData.self, from: data)
            let WeatherData = Weather(cityName: weather.name, id: weather.weather[0].id, description: weather.weather[0].description, temp: weather.main.temp)
            return WeatherData
        } catch let err as NSError {
            print("There was an erroor decoding data \(err)")
            return nil
        }
    }
}
