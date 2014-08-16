//
//  ViewController.swift
//  weather
//
//  Created by pw's air on 2014/8/16.
//  Copyright (c) 2014年 pw's air. All rights reserved.
//

import UIKit

class ViewController: UIViewController, NSURLConnectionDataDelegate{

    
    var api: String = ""
    
    @IBOutlet var city: UILabel!
    @IBOutlet var rainImage: UIImageView!
    
    var data: NSMutableData = NSMutableData()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.city.text = "I-Lan"
        var image = UIImage(named: "cloud.rain.png")
        self.rainImage.image = image
        
        let background = UIImage(named: "oreo.jpg")
        
        self.view.backgroundColor = UIColor(patternImage: background)
        
        startConnection()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func startConnection(){
        var restAPI: String = "http://api.openweathermap.org/data/2.5/weather?q=Taipei"
        var url: NSURL = NSURL(string: restAPI)
        var request: NSURLRequest = NSURLRequest(URL: url)
        var connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: true)
        println("start download")
    }
    
    func connection(connection: NSURLConnection!, didReceiveData dataReceived: NSData!) {
        println("Downloading...")
        
        self.data.appendData(dataReceived)
        
       // NSString(data: self.data, encoding: NSUTF8StringEncoding)
        println("current data is \( NSString(data: self.data, encoding: NSUTF8StringEncoding))")
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        println("download finished")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

