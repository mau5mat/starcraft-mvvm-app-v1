//
//  UnitPageViewModel.swift
//  starcraft-mvvm-app-v1
//
//  Created by Matthew Roberts on 10/01/2023.
//

import Foundation

class UnitPageViewModel {
    private(set) var unit: SCUnit?
    
    init(unit: SCUnit) {
        self.unit = unit
    }
   
    func unitName() -> String {
        guard let name = unit?.name else { return "Unit Name: Not Found" }
        return "Unit Name: \(name)"
    }
    
    func unitType() -> String {
        guard let type = unit?.unitType else { return "Unit Type : Not Found"}
        return "Unit Type: \(type)"
    }
    
    func unitBuiltFrom() -> String {
        guard let building = unit?.builtFrom else { return "Built From : Not Found"}
        return "Built From: \(building)"
    }
    
    func unitMineralCost() -> String {
        guard let mineralCost = unit?.mineralCost else { return "Mineral Cost : Not Found"}
        return "Mineral Cost: \(mineralCost)"
    }
    
    func unitGasCost() -> String {
        guard let gasCost = unit?.gasCost else { return "Gas Cost : Not Found"}
        return "Gas Cost: \(gasCost)"
    }
    
    func unitSupply() -> String {
        guard let supply = unit?.supply else { return "Unit Supply : Not Found"}
        return "Unit Supply: \(supply)"
    }
    
    func unitHotkey() -> String {
        guard let hotkey = unit?.hotkey else { return "Unit Hotkey : Not Found"}
        return "Unit Hotkey: \(hotkey)"
    }
    
}
