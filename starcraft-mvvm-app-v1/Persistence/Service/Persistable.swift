//
//  Persistable.swift
//  starcraft-mvvm-app-v1
//
//  Created by Matthew Roberts on 09/01/2023.
//

import RealmSwift

protocol Persistable {
    associatedtype ManagedObject: RealmSwift.Object
    init(managedObject: ManagedObject)
    func toManagedObject() -> ManagedObject
}

extension Persistable {
    func add(to realm: Realm, with updatePolicy: Realm.UpdatePolicy) {
        realm.add(self.toManagedObject(), update: updatePolicy)
    }
    
    func remove(from realm: Realm) {
        realm.delete(self.toManagedObject())
    }
    
    static func remove(results: Results<ManagedObject>, from realm: Realm) {
        realm.delete(results)
    }
    
    static func read(from realm: Realm) -> Results<ManagedObject> {
        let results = realm.objects(ManagedObject.self)
        return results
    }
}
