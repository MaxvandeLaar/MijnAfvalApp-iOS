//
//  Constants.swift
//  MijnAfval
//
//  Created by Max van de Laar on 13/01/2018.
//  Copyright © 2018 Max van de Laar. All rights reserved.
//

import Foundation
import UIKit

struct Constants{
    //    static let tabletUUID: String = UIDevice.current.identifierForVendor!.uuidString
    static let tabletUUID: String = "c8962d4c-0cd8-48bc-a59e-def2b7cd7ca6"
    static let systemName: String = UIDevice.current.systemName
    static let systemVersion: String  = UIDevice.current.systemVersion
    static let appVersion: String = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    static let buildVersion: String = Bundle.main.infoDictionary!["CFBundleVersion"] as! String
    
}
