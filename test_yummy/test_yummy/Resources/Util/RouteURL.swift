//
//  RouteURL.swift
//  TestSoyYo
//
//  Created by Pedro Alonso Daza B on 7/09/20.
//  Copyright © 2020 Pedro Alonso Daza B. All rights reserved.
//

import Foundation
import UIKit

    func getStringOfInfo(key:String) -> String{
        
        if let value = Bundle.main.object(forInfoDictionaryKey: key) {
            if let stringValue = value as? String {
                return stringValue
            }
        }
        
        return ""
         
    }
    
    func getApiKey() -> String {
        return getStringOfInfo(key: "API_KEY")
    }
    
    func getUrlApod() -> String {
        return "https://api.nasa.gov/planetary/apod" + "?api_key=" + "m9loOd79vKI0ArBwtmhX2gOGRQbIMi7vNttpIzaR&date={date}"
    }




