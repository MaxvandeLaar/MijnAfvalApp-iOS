//
//  Communication.swift
//  MijnAfval
//
//  Created by Max van de Laar on 13/01/2018.
//  Copyright © 2018 Max van de Laar. All rights reserved.
//

import Foundation
import PromiseKit
import Alamofire

class Location {
    
    func getAddress(zipcode: String, houseNumber: Int, houseNumberAddition: String? = "") -> Promise<Address>  {
        let url = "\(Urls.apiBaseUrl)\(Urls.apiVersion)\(Urls.getAddress)?\(Utils().getUrlParams(zipcode: zipcode, houseNumber: houseNumber, houseNumberAddition: houseNumberAddition))"
        return Promise { fulfill, reject in
            Alamofire.request(url).responseJSON() { response in
                switch response.result {
                case .success(let value):
                    let address = Address(value: value)
                    if let fullCountryName = Countries.convert[address.country] {
                        address.country = fullCountryName
                    }
                    fulfill(address)
                case .failure(let error):
                    reject(error)
                }
            }
        }
    }
    
}
