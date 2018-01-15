//
//  Upcoming.swift
//  MijnAfval
//
//  Created by Max van de Laar on 15/01/2018.
//  Copyright © 2018 Max van de Laar. All rights reserved.
//

import Foundation
import RealmSwift

final class Upcoming: Object {
    @objc dynamic var id = 0
    let items = List<Item>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

final class Item: Object{
    @objc dynamic var type: String = ""
    @objc dynamic var date: String = ""
}

