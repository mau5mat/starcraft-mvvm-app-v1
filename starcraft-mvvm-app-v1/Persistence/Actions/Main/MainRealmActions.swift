//
//  MainRealmActions.swift
//  starcraft-mvvm-app-v1
//
//  Created by Matt Roberts on 14/01/2023.
//

import Foundation

protocol MainRealmActionsDelegate {
    func getUnitsFromRealm(with building: BuildingType) -> [SCUnit]
    func removeUnitsFromRealm()
    func removeBuildingsFromRealm()
    func removeUnitTypesFromRealm()
}

struct MainRealmActions: MainRealmActionsDelegate {
    let realm = PersistenceManager.shared.realm
    
    func getUnitsFromRealm(with building: BuildingType) -> [SCUnit] {
        let buildingString = building.rawValue
        let unitObject = SCUnit.read(from: realm)
        let unitData = unitObject.compactMap { SCUnit(managedObject: $0) }
        let unitArray = Array(unitData)
        let filteredUnits = unitArray.filter({ $0.builtFrom == buildingString })
        
        return filteredUnits
    }
    
    func removeUnitsFromRealm() {
        let unitObjects = SCUnit.read(from: realm)
        SCUnit.remove(results: unitObjects, from: realm)
        
        removeBuildingsFromRealm()
        removeUnitTypesFromRealm()
    }
    
    internal func removeBuildingsFromRealm() {
        let buildingObjects = Building.read(from: realm)
        Building.remove(results: buildingObjects, from: realm)
    }
    
    internal func removeUnitTypesFromRealm() {
        let unitTypeObjects = UnitType.read(from: realm)
        UnitType.remove(results: unitTypeObjects, from: realm)
    }
}
