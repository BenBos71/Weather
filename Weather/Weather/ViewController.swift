//
//  ViewController.swift
//  Weather
//
//  Created by Ben Bos on 5/1/23.
//

import UIKit

class ViewController: UIViewController {
//    @IBAction func weatherButtonTapped(_ sender: UIButton) {
//        getWeather()
//    }
    @IBAction func WeatherButton(_ sender: UIButton) {
        getWeather()
    }
    
    @IBOutlet weak var temperature: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getWeather()
    }

    func getWeather() {
        let session = URLSession.shared

        let weatherURL = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=Ogden,us?&units=imperial&APPID=256d5124fdc6e20ac717f8011ee24fee")!

        let dataTask = session.dataTask(with: weatherURL) {
            (data: Data?, response: URLResponse?, error: Error?) in

            if let error = error {
                print("Error:\n\(error)")
            } else {
                if let data = data {
                
                    let dataString = String(data: data, encoding: String.Encoding.utf8)
                    print("All the weather data:\n\(dataString!)")
                    
                    if let jsonObj = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary {
                        
                        if let mainDictionary = jsonObj.value(forKey: "main") as? NSDictionary {
                            if let temperature = mainDictionary.value(forKey: "temp") {
                                DispatchQueue.main.async {
                                    self.temperature.text = "Ogden Temperature: \(temperature)°F"
                                }
                            }
                        } else {
                          print("Error: unable to find temperature in dictionary")
                        }
                    } else {
                        print("Error: unable to convert json data")
                    }
                } else {
                    print("Error: did not receive data")
                }
            }
        }

        dataTask.resume()
    }

}

