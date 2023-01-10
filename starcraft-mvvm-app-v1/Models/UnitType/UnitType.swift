//
//  UnitType.swift
//  starcraft-mvvm-app-v1
//
//  Created by Matthew Roberts on 09/01/2023.
//

import RealmSwift

struct UnitType: Codable {
    var biological, mechanical, psionic, summoned: String?
}

final class UnitTypeObject: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var biological: String = ""
    @Persisted var mechanical: String = ""
    @Persisted var psionic: String = ""
    @Persisted var summoned: String = ""
    
}

extension UnitType: Persistable {
    init(managedObject: UnitTypeObject) {
        biological = managedObject.biological
        mechanical = managedObject.mechanical
        psionic = managedObject.psionic
        summoned = managedObject.summoned
    }
    
    func toManagedObject() -> UnitTypeObject {
        let unitTypeData = UnitTypeObject()
        unitTypeData.biological = biological ?? ""
        unitTypeData.mechanical = mechanical ?? ""
        unitTypeData.psionic = psionic ?? ""
        unitTypeData.summoned = summoned ?? ""
        
        return unitTypeData
    }
}
