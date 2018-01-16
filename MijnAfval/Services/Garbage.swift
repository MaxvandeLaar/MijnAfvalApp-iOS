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
import SwiftDate

class Garbage {
    func getUpcoming(zipcode: String, houseNumber: Int, houseNumberAddition: String? = "") -> Promise<Upcoming>  {
        let url = "\(Urls.apiBaseUrl)\(Urls.apiVersion)\(Urls.getUpcoming)?\(Utils().getUrlParams(zipcode: zipcode, houseNumber: houseNumber, houseNumberAddition: houseNumberAddition))"
        print(url)
        return Promise { fulfill, reject in
            Alamofire.request(url).responseJSON() { response in
                switch response.result {
                case .success(let value):
                    
                    var json = JSON(value)
          
                    let region = Region(tz: TimeZoneName.europeAmsterdam, cal: CalendarName.gregorian, loc: LocaleName.dutch)

                    var items = [Any]()
                    for (key, _) in json.enumerated() {
                        var item: Dictionary<String, Any> = [:]
                        item["type"] = json[key]["type"].string!
                        print(json[key]["date"])
                        item["date"] = DateInRegion(string: json[key]["date"].string!, format: .iso8601(options: .withInternetDateTime), fromRegion: region)?.absoluteDate
                        
                        let regionDate = DateInRegion(absoluteDate: item["date"]! as! Date, in: region).string(custom: "dd-MM-yyyy")
                        print(regionDate)
                        items.append(item)
                    }

                    let data: NSDictionary = ["id":0, "items": items]
                    let upcoming = Upcoming(value: data)
                  
                    fulfill(upcoming)
                case .failure(let error):
                    reject(error)
                }
            }
        }
    }
}
