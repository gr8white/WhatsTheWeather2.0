//
//  ViewController.swift
//  API Demo
//
//  Created by Derrick White on 2/12/19.
//  Copyright © 2019 Derrick White. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBAction func getWeather(_ sender: Any) {
        
        if let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=" + cityTextField.text!.replacingOccurrences(of: " ", with: "%20") + ",us&appid=3c8cd5b05b20e443edea687440154b52") {
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in // giving the URL a task
            
            if error != nil { // Checking that we can get the data
                
                print(error!)
                
            } else {
                
                if let urlContent = data {
                    
                    do { // If we can, processing the JSON data into an array that we can deal with
                        
                        let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        
                        print(jsonResult)
                        
                        print(jsonResult["name"]!!)
                        
                        if let description = ((jsonResult["weather"] as? NSArray)?[0] as? NSDictionary)?["description"] as? String {
                            
                            DispatchQueue.main.sync(execute: {
                                
                                self.resultLabel.text = description
                                
                            })
                            
                        } // <==This function shows how to grab certain object from array
                        
                    } catch {
                        
                        print("JSON Processing Failed")
                        
                    }
                    
                    
                    
                }
                
            }
            
            
        }
        
        task.resume()
            
        } else {
            
            resultLabel.text = "The weather there coudn't be found. Please try again."
            
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
   


}

