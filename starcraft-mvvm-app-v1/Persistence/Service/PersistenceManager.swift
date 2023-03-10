//
//  PersistenceManager.swift
//  starcraft-mvvm-app-v1
//
//  Created by Matthew Roberts on 09/01/2023.
//

import RealmSwift

struct PersistenceManager {
    static let shared = PersistenceManager()
    let realm: Realm
    
    // This would need removed in production ..
    let configuration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
    
    private init() {
        Realm.Configuration.defaultConfiguration = configuration
        self.realm = try! Realm()

        print("Realm is located at:", realm.configuration.fileURL!)
    }
}
