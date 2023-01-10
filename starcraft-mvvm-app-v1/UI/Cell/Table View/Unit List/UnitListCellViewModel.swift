//
//  UnitListCellViewModel.swift
//  starcraft-mvvm-app-v1
//
//  Created by Matthew Roberts on 09/01/2023.
//

import UIKit

class UnitListCellViewModel {
    private(set) var title: String?
    
    init(unit: SCUnit) {
        self.title = unit.name ?? ""
    }
}
