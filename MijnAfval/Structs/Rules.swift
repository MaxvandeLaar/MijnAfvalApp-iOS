//
//  Rules.swift
//  MijnAfval
//
//  Created by Max van de Laar on 13/01/2018.
//  Copyright © 2018 Max van de Laar. All rights reserved.
//

import Foundation
import Eureka

public struct RuleZipCode<T: Equatable>: RuleType {
    
    public init(msg: String = "Not a zip code!") {
        self.validationError = ValidationError(msg: msg)
    }
    
    public var id: String?
    public var validationError: ValidationError
    
    public func isValid(value: T?) -> ValidationError? {
        var isZipcode = false
        if var zipcode = value as? String {
            zipcode = zipcode.removeWhitespaces().lowercased()
            let patternNL = "^[1-9][0-9]{3} ?(?!sa|sd|ss)[a-z]{2}$"
            let patternBE = "^[1-9]{1}[0-9]{3}$"
            
            if (zipcode.range(of: patternNL, options:[.regularExpression, .caseInsensitive]) != nil){
                isZipcode = true
            }
            if (zipcode.range(of: patternBE, options:[.regularExpression, .caseInsensitive]) != nil){
                isZipcode = true
            }
        }
        return isZipcode ? nil : validationError
    }
}
