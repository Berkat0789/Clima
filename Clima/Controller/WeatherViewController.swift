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
    
    var service = WeatherService()
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        service.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        locationManager.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func locationButtonPressed(_ sender: Any) {
        locationManager.requestLocation()
    }
    
    
    
}

//MARK: - Extensions for Protocols

extension WeatherViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let cityName = searchTextField.text {
            service.getWeatherDataFor(cityName)
        }
        textField.text = ""
        return true
    }
}

extension WeatherViewController: WeatherDelegate {
    func didReceive(weather: Weather) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.tempString
            self.cityLabel.text = weather.name
            self.conditionImageView.image = UIImage(systemName: weather.imageName)
            self.weatherCondition.text = weather.condition
        }
    }
}

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let coord = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
             service.getWeatherDatafor(user: coord)
        }
 
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Here is the locaiton \(error)")
    }
}


