//
//  Building.swift
//  starcraft-mvvm-app-v1
//
//  Created by Matthew Roberts on 09/01/2023.
//

import RealmSwift

struct Building: Codable {
    var commandCenter, barracks, factory, starport: String?
}

final class BuildingObject: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var commandCenter: String = ""
    @Persisted var barracks: String = ""
    @Persisted var factory: String = ""
    @Persisted var starport: String = ""
    
}

extension Building: Persistable {
    init(managedObject: BuildingObject) {
        commandCenter = managedObject.commandCenter
        barracks = managedObject.barracks
        factory = managedObject.factory
        starport = managedObject.starport
    }
    
    func toManagedObject() -> BuildingObject {
        let buildingData = BuildingObject()
        buildingData.commandCenter = commandCenter ?? ""
        buildingData.barracks = barracks ?? ""
        buildingData.factory = factory ?? ""
        buildingData.starport = starport ?? ""
        
        return buildingData
    }
}
