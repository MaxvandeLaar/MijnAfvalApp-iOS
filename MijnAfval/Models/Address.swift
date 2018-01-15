//
//  Address.swift
//  MijnAfval
//
//  Created by Max van de Laar on 13/01/2018.
//  Copyright © 2018 Max van de Laar. All rights reserved.
//

import Foundation
import RealmSwift

final class Address: Object {
    @objc dynamic var id = 0
    @objc dynamic var street: String = ""
    @objc dynamic var houseNumber: Int = 0
    @objc dynamic var houseNumberAddition: String = ""
    @objc dynamic var zipCode: String = ""
    @objc dynamic var city: String = ""
    @objc dynamic var country: String = ""
    @objc dynamic var latitude: String = ""
    @objc dynamic var longitude: String = ""
    @objc dynamic var success: Bool = false
    @objc dynamic var error: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func toString() -> String {
        if (self.success){
            
            var street = self.street
            if (!street.isEmpty){
                street += " "
            }
            return "\(street)\(self.houseNumber)\(self.houseNumberAddition)\n\(self.zipCode) \(self.city)\n\(self.country)"
        }
        return self.error
    }
}
