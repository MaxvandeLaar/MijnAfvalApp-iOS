//
//  Utils.swift
//  MijnAfval
//
//  Created by Max van de Laar on 13/01/2018.
//  Copyright © 2018 Max van de Laar. All rights reserved.
//

import Foundation

class Utils {
    
    func getUrlParams(zipcode: String, houseNumber: Int, houseNumberAddition: String? = "") -> String {
        if let addition = houseNumberAddition {
            return "zipcode=\(zipcode.uppercased().removeWhitespaces())&houseNumber=\(houseNumber)&houseNumberAddition=\(addition.removeWhitespaces())"
        }
        return "zipcode=\(zipcode.uppercased().removeWhitespaces())&houseNumber=\(houseNumber)"
    }
    
}
