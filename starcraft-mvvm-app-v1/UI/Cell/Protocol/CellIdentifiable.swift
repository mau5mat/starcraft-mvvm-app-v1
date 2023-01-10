//
//  CellIdentifiable.swift
//  starcraft-mvvm-app-v1
//
//  Created by Matthew Roberts on 09/01/2023.
//

import UIKit

protocol CellIdentifiable {
    static func nib() -> UINib
    static func reuseIdentifier() -> String
}
