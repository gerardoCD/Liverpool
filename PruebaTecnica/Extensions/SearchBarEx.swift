//
//  SearchBarEx.swift
//  PruebaTecnica
//
//  Created by Gerardo Castillo Duran  on 19/04/20.
//  Copyright © 2020 Gerardo Castillo Duran . All rights reserved.
//

import Foundation
import UIKit


extension UISearchBar {
func enable() {
    isUserInteractionEnabled = true
    alpha = 1.0
}

func disable() {
    isUserInteractionEnabled = false
    alpha = 0.5
}
}
