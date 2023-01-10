//
//  Unit.swift
//  starcraft-mvvm-app-v1
//
//  Created by Matthew Roberts on 09/01/2023.
//

import RealmSwift

struct SCUnit: Codable {
    var name, hotkey: String?
    var unitType: String?
    var builtFrom: String?
    var mineralCost: Int?
    var gasCost: Int?
    var supply: Int?
    
}

final class SCUnitObject: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name: String = ""
    @Persisted var hotkey: String = ""
    @Persisted var unitType: String = ""
    @Persisted var builtFrom: String = ""
    @Persisted var mineralCost: Int = 0
    @Persisted var gasCost: Int = 0
    @Persisted var supply: Int = 0
    
}

extension SCUnit: Persistable {
    init(managedObject: SCUnitObject) {
        name = managedObject.name
        hotkey = managedObject.hotkey
        unitType = managedObject.unitType
        builtFrom = managedObject.builtFrom
        mineralCost = managedObject.mineralCost
        gasCost = managedObject.gasCost
        supply = managedObject.supply
    }
    
    func toManagedObject() -> SCUnitObject {
        let unitData = SCUnitObject()
        unitData.name = name ?? ""
        unitData.hotkey = hotkey ?? ""
        unitData.unitType = unitType ?? ""
        unitData.builtFrom = builtFrom ?? ""
        unitData.mineralCost = mineralCost ?? 0
        unitData.gasCost = gasCost ?? 0
        unitData.supply = supply ?? 0
        
        return unitData
    }
}
