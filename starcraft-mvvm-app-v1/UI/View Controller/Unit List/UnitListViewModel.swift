//
//  UnitListViewModel.swift
//  starcraft-mvvm-app-v1
//
//  Created by Matthew Roberts on 09/01/2023.
//

import Foundation
import RealmSwift

class UnitListViewModel {
    private(set) var units: [SCUnit] = []
    
    init(units: [SCUnit]) {
        self.units = units
    }
}
