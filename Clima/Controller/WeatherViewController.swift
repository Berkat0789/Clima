//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var weatherCondition: UILabel!
    
    
    var service = WeatherManager()
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        service.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
    }
    
    
    @IBAction func locaitonButtonPressed(_ sender: Any) {
        locationManager.requestLocation()
    }
}

//MARK: - Extensions for protocol use

extension WeatherViewController: weatherDelegate {
    func didReceiveWeatherData(weather: Weather) {
        DispatchQueue.main.async {
            self.cityLabel.text = weather.cityName
            self.temperatureLabel.text = weather.tempString
            self.weatherCondition.text = weather.description
            self.conditionImageView.image = UIImage(systemName: weather.setWeatherImage)
        }
    }
}

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        let userLocaiton = locations[0]
        service.getWeatherDataFor(location: userLocaiton.coordinate)
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("HEre is the error getting the data \(error)")
    }
}

extension WeatherViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let cityName = searchTextField.text {
            service.getWeatherDatafor(cityName: cityName)
            searchTextField.text = ""
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let cityName = searchTextField.text {
            service.getWeatherDatafor(cityName: cityName)
            searchTextField.text = ""
        }
        return true
    }
}
