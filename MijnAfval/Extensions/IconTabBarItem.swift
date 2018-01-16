//
//  IconTabBarItem.swift
//  MijnAfval
//
//  Created by Max van de Laar on 15/01/2018.
//  Copyright © 2018 Max van de Laar. All rights reserved.
//

import Foundation
import UIKit
import SwiftIcons

class IconTabBarItem: UITabBarItem {
    
    var icon: String! {
        didSet {
            print("didSet font, font = \(self.icon)")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        self.setIcon(icon: .ionicons(icon))
    }
    
}
