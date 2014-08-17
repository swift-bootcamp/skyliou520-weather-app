//
//  ViewController.swift
//  weather
//
//  Created by pw's air on 2014/8/16.
//  Copyright (c) 2014年 pw's air. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mCity: UILabel!
    @IBOutlet weak var mCelsius: UILabel!
    @IBOutlet weak var mFahrenheit: UILabel!
    @IBOutlet weak var mImage: UIImageView!
    
    let cityName: String = "Taipei"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.mCity.text = self.cityName
        //let background = UIImage(named: "IMG_0997.png")
        
        //self.view.backgroundColor = UIColor(patternImage: background)
        
        //touch the screen for download
        self.view.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: "onTapHandler:"
            )
        )
        
        getWeather()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // onTap Handler
    func onTapHandler (recognizer: UITapGestureRecognizer) {
        self.mCelsius.text = "Celsius"
        self.mFahrenheit.text = "Fahrenheit"
        
        getWeather()
    }
    
    // Get Weather from open weather map API
    func getWeather() {
        NSURLConnection.sendAsynchronousRequest(
            NSURLRequest(URL: NSURL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(self.cityName)")),
            queue: NSOperationQueue.mainQueue(),
            completionHandler: {(response, data, error) in
                
                // check error
                if (error != nil) {
                    println("Cannot get weather information from server.")
                    return
                }
                
                // JSON Parse
                var jsonDictionaray: NSDictionary = NSJSONSerialization.JSONObjectWithData(
                    data,
                    options: NSJSONReadingOptions.MutableContainers,
                    error: nil) as NSDictionary
                
                println(jsonDictionaray)
                
                // get temperature
                let temp: AnyObject? = jsonDictionaray["main"]?["temp"]?
                
                let absolute_zero: Float = 273.15
                
                // convert to Celsius and Fahrenheit
                let celsiusTemp    = Int(round(temp!.floatValue - absolute_zero))
                let fahrenheitTemp = celsiusTemp * (9/5) + 32
                
                // set Text View
                self.mCelsius.text = "\(celsiusTemp) ℃"
                self.mFahrenheit.text = "\(fahrenheitTemp) ℉"
                
                // get weather ID & icon
                if let weather = jsonDictionaray["weather"]? as? NSArray {
                    let weatherDictionary = weather[0]? as NSDictionary
                    let weatherId = weatherDictionary["id"] as Int
                    println("weather ID: \(weatherId)")
                    
                    // show the icon on the screen
                    let weatherIcon = weatherDictionary["icon"] as String
                    println("weather icon: \(weatherIcon)")
                    self.mImage.image = UIImage(data: NSData(contentsOfURL: NSURL(string:"http://openweathermap.org/img/w/\(weatherIcon).png")))
                }
        })
    }
}
