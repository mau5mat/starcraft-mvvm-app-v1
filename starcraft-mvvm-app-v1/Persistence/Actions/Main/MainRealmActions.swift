//
//  MainRealmActions.swift
//  starcraft-mvvm-app-v1
//
//  Created by Matt Roberts on 14/01/2023.
//

import Foundation
import RealmSwift

protocol MainRealmActionsProtocol {
    func getUnitsFrom(realm: Realm, with building: String) -> [SCUnit]
    func removeUnitsFrom(realm: Realm)
    func removeBuildingsFrom(realm: Realm)
    func removeUnitTypesFrom(realm: Realm)
}

struct MainRealmActions: MainRealmActionsProtocol {
    func getUnitsFrom(realm: Realm, with building: String) -> [SCUnit] {
        let unitObject = SCUnit.read(from: realm)
        let unitData = unitObject.compactMap { SCUnit(managedObject: $0) }
        let unitArray = Array(unitData)
        let filteredUnits = unitArray.filter({ $0.builtFrom == building })
        
        return filteredUnits
    }
    
    func removeUnitsFrom(realm: Realm) {
        let unitObjects = SCUnit.read(from: realm)
        SCUnit.remove(results: unitObjects, from: realm)
        
        removeBuildingsFrom(realm: realm)
        removeUnitTypesFrom(realm: realm)
    }
    
    internal func removeBuildingsFrom(realm: Realm) {
        let buildingObjects = Building.read(from: realm)
        Building.remove(results: buildingObjects, from: realm)
    }
    
    internal func removeUnitTypesFrom(realm: Realm) {
        let unitTypeObjects = UnitType.read(from: realm)
        UnitType.remove(results: unitTypeObjects, from: realm)
    }
}
