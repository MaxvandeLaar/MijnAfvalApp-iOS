//
//  MapViewController.swift
//  MijnAfval
//
//  Created by Max van de Laar on 13/01/2018.
//  Copyright © 2018 Max van de Laar. All rights reserved.
//

import Foundation
import UIKit
import SwiftIcons

class MapViewController: UIViewController {
    
    @IBOutlet weak var barButtonSettings: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        barButtonSettings.setIcon(icon: .ionicons(.iosCogOutline), iconSize: 23, color: UIColor.white)
        
        
    }
    
}
