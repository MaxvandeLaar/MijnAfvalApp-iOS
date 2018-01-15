//
//  String.swift
//  MijnAfval
//
//  Created by Max van de Laar on 13/01/2018.
//  Copyright © 2018 Max van de Laar. All rights reserved.
//

import Foundation

extension String {
    func removeWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}
