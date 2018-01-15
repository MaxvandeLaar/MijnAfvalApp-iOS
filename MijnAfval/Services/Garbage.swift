//
//  Garbage.swift
//  MijnAfval
//
//  Created by Max van de Laar on 14/01/2018.
//  Copyright © 2018 Max van de Laar. All rights reserved.
//

import Foundation
import PromiseKit
import Alamofire
import SwiftyJSON

class Garbage {
    func getUpcoming(zipcode: String, houseNumber: Int, houseNumberAddition: String? = "") -> Promise<Upcoming>  {
        let url = "\(Urls.apiBaseUrl)\(Urls.apiVersion)\(Urls.getUpcoming)?\(Utils().getUrlParams(zipcode: zipcode, houseNumber: houseNumber, houseNumberAddition: houseNumberAddition))"
        print(url)
        return Promise { fulfill, reject in
            Alamofire.request(url).responseJSON() { response in
                switch response.result {
                case .success(let value):
                    
                    let json = JSON(value)
                    print("JSON")
                    print(json[0].date)
                    let data: NSDictionary = ["id":0, "items": value]
                    let upcoming = Upcoming(value: data)
                  
                    fulfill(upcoming)
                case .failure(let error):
                    reject(error)
                }
            }
        }
    }
}
