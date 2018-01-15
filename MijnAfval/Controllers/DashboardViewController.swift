//
//  FirstViewController.swift
//  MijnAfval
//
//  Created by Max van de Laar on 12/01/2018.
//  Copyright © 2018 Max van de Laar. All rights reserved.
//

import UIKit
import RealmSwift

class DashboardViewController: UIViewController {

    @IBOutlet weak var barButtonSettings: UIBarButtonItem!
    
    let garbage = Garbage()
    var realm: Realm!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.realm = try! Realm()
        
        if let address = realm.object(ofType: Address.self, forPrimaryKey: 0) {
            garbage.getUpcoming(zipcode: address.zipCode, houseNumber: address.houseNumber).then{ upcoming -> Void in
                for (key, item) in upcoming.items.enumerated() {
                    print("TYPE")
                    print(item.type)
                }
                }.catch{ error -> Void in
                    print(error)
            }
        }
    
        barButtonSettings.setIcon(icon: .ionicons(.iosCogOutline), iconSize: 23, color: UIColor.white)

        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

