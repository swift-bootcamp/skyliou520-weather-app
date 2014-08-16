//
//  ViewController.swift
//  weather
//
//  Created by pw's air on 2014/8/16.
//  Copyright (c) 2014年 pw's air. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    var api: String = ""
    
    @IBOutlet var city: UILabel!
    @IBOutlet var rainImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.city.text = "I-Lan"
        var image = UIImage(named: "cloud.rain.png");
        self.rainImage.image = image;
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

