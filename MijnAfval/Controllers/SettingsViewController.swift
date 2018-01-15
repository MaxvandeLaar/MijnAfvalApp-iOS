//
//  SecondViewController.swift
//  MijnAfval
//
//  Created by Max van de Laar on 12/01/2018.
//  Copyright © 2018 Max van de Laar. All rights reserved.
//

import UIKit
import Eureka
import RealmSwift
import SCLAlertView

class SettingsViewController: FormViewController {
    
    var address: Address!
    var tmpAddress: Address = Address()
    var realm: Realm!
    let location = Location()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.realm = try! Realm()
        let objs = realm.objects(Address.self).count
        if (objs > 0) {
            self.address = realm.objects(Address.self).first!
        } else {
            self.address = Address()
            self.address.id = 0
        }
        
        form
            +++ Section("Gegevens")
                <<< TextRow(){ row in
                    row.title = "Postcode"
                    row.placeholder = "Uw postcode"
                    row.tag = "zipcode"
                    row.add(rule: RuleRequired(msg: "Verplicht"))
                    row.add(rule: RuleZipCode(msg: "Geen geldige postcode"))
                    row.value = self.address.zipCode
                    
                }
                .onChange { row in
                    if (row.isValid){
                        self.getAddress(form: self.form)
                    }
                }
                .cellUpdate { cell, row in
                    let zipValRow: LabelRow? = self.form.rowBy(tag: "zipcodeValidation")
                    if (!row.isValid) {
                        zipValRow?.hidden = false
                        cell.titleLabel?.textColor = .red
                        zipValRow?.value = row.validationErrors[0].msg
                    } else {
                        cell.titleLabel?.textColor = .black
                        zipValRow?.hidden = true
                    }
                    zipValRow?.reload()
                    zipValRow?.evaluateHidden()
                }
                <<< LabelRow(){ row in
                    row.tag = "zipcodeValidation"
                    row.hidden = true
                }
                .cellUpdate{cell, row in
                    cell.detailTextLabel?.textColor = .red
                }
                <<< IntRow(){ row in
                    row.title = "Huisnummer"
                    row.placeholder = "Uw huisnummer"
                    row.tag = "houseNumber"
                    row.add(rule: RuleRequired(msg: "Verplicht"))
                    if self.address.houseNumber > 0 {
                        row.value = self.address.houseNumber
                    }
                }
                .onChange { row in
                    if (row.isValid){
                        self.getAddress(form: self.form)
                    }
                }
                .cellUpdate{ cell, row in
                    let houseNumberValRow: LabelRow? = self.form.rowBy(tag: "houseNumberValidation")
                    if (!row.isValid) {
                        houseNumberValRow?.hidden = false
                        cell.titleLabel?.textColor = .red
                        houseNumberValRow?.value = row.validationErrors[0].msg
                    } else {
                        cell.titleLabel?.textColor = .black
                        houseNumberValRow?.hidden = true
                    }
                    houseNumberValRow?.reload()
                    houseNumberValRow?.evaluateHidden()
                }
                <<< LabelRow(){ row in
                    row.tag = "houseNumberValidation"
                    row.hidden = true
                }
                .cellUpdate{cell, row in
                        cell.detailTextLabel?.textColor = .red
                }
                <<< TextRow() { row in
                    row.title = "Toevoeging"
                    row.placeholder = "Uw huisnummer toevoeging"
                    row.tag = "houseNumberAddition"
                    row.value = self.address.houseNumberAddition
                }
                .onChange { row in
                    self.getAddress(form: self.form)
                }
            +++ Section("Adres")
                <<< LabelRow() {row in
                    if (self.address.success){
                       row.title = self.address.toString()
                    }
                    row.cell.textLabel?.numberOfLines = 0
                    row.tag = "address"
                }
    }

    override func viewWillDisappear(_ animated: Bool) {
        let valid = self.form.validate().count == 0
        if (self.tmpAddress.success && valid) {
            try! realm.write {
                realm.add(self.tmpAddress, update: true)
            }
        }
        super.viewWillDisappear(animated)
    }
    
    func getAddress(form: Form){
        let zipcodeRow: TextRow? = form.rowBy(tag: "zipcode")
        let houseNumberRow: IntRow? = form.rowBy(tag: "houseNumber")
        let houseNumberAdditionRow: TextRow? = form.rowBy(tag: "houseNumberAddition")
        if let zipcode = zipcodeRow?.value, let houseNumber = houseNumberRow?.value {
            
            let houseNumberAddition = houseNumberAdditionRow?.value
            
            location.getAddress(zipcode: zipcode, houseNumber: houseNumber, houseNumberAddition:  houseNumberAddition).then{ address -> Void in
                self.tmpAddress = Address(value: address)
                self.tmpAddress.id = 0;
                
                let addressRow: LabelRow? = form.rowBy(tag: "address")
                addressRow?.title = self.tmpAddress.toString()
                addressRow?.reload()
                }.catch { error -> Void in
                    self.tmpAddress = Address()
                    self.tmpAddress.error = error.localizedDescription
                 
                    SCLAlertView().showError("Oeps", subTitle: error.localizedDescription)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

