//
//  MainViewModel.swift
//  starcraft-mvvm-app-v1
//
//  Created by Matthew Roberts on 09/01/2023.
//

import UIKit
import RealmSwift

class MainViewModel: ObservableObject {
    @Published private(set) var loadingState: LoadingState<Error>
    
    private let connectionManager: ConnectionManager
    
    private let responseService: EndpointResponseServiceProtocol
    private let persistenceService: PersistenceService
    private let realm: Realm
 
    private(set) var units: [SCUnit] = []
    
    init(responseService: EndpointResponseServiceProtocol) {
        self.connectionManager = ConnectionManager()
        
        self.responseService = responseService
        self.persistenceService = PersistenceService()
        self.realm = persistenceService.realm
        
        loadingState = .idle
    }
    
    func buildingData() -> [BuildingData] {
        let buildingData = [BuildingData(title: "Barracks", thumbnailImage: UIImage(named: "barracks")!),
                            BuildingData(title: "Factory", thumbnailImage: UIImage(named: "factory")!),
                            BuildingData(title: "Starport", thumbnailImage: UIImage(named: "starport")!)]
        return buildingData
    }
    
    @MainActor
    func fetchBarracksUnits() async {
        do {
            loadingState = .loading
            
            fetchUnitsWithRealmIfOffline(from: "Barracks")
            
            let unitData: [SCUnit] = try await responseService.decodeData(from: TerranEndpoint.getBarracksUnits)
            units = unitData
            
            loadingState = .loaded
            
            realm.writeAsync { [weak self] in
                self?.removeUnitsFromRealm()
                
                for unit in unitData {
                    unit.add(to: self!.realm, with: .all)
                }
            }
        } catch {
            loadingState = .failed(error)
            print(error.localizedDescription)
        }
    }
    
    @MainActor
    func fetchFactoryUnits() async {
        do {
            loadingState = .loading
            
            fetchUnitsWithRealmIfOffline(from: "Factory")
            
            let unitData: [SCUnit] = try await responseService.decodeData(from: TerranEndpoint.getFactoryUnits)
            units = unitData
            
            loadingState = .loaded
            
            realm.writeAsync { [weak self] in
                self?.removeUnitsFromRealm()
                
                for unit in unitData {
                    unit.add(to: self!.realm, with: .all)
                }
            }
        } catch {
            loadingState = .failed(error)
            print(error.localizedDescription)
        }
    }
    
    @MainActor
    func fetchStarportUnits() async {
        do {
            loadingState = .loading
            
            fetchUnitsWithRealmIfOffline(from: "Starport")
            
            let unitData: [SCUnit] = try await responseService.decodeData(from: TerranEndpoint.getStarportUnits)
            units = unitData
            
            loadingState = .loaded
            
            realm.writeAsync { [weak self] in
                self?.removeUnitsFromRealm()
                
                for unit in unitData {
                    unit.add(to: self!.realm, with: .all)
                }
            }
        } catch {
            loadingState = .failed(error)
            print(error.localizedDescription)
        }
    }
    
    private func fetchUnitsWithRealmIfOffline(from building: String) {
        if connectionManager.noInternet() {
            loadingState = .noInternet
            
            let unitsFromRealm = getUnitsFromRealm(from: building)
            units = unitsFromRealm
            
            loadingState = .loaded
        }
    }
    
    private func removeUnitsFromRealm() {
        let unitObjects = SCUnit.read(from: realm)
        SCUnit.remove(results: unitObjects, from: realm)
        
        removeBuildingsFromRealm()
        removeUnitTypesFromRealm()
    }
    
    private func removeBuildingsFromRealm() {
        let buildingObjects = Building.read(from: realm)
        Building.remove(results: buildingObjects, from: realm)
    }
    
    private func removeUnitTypesFromRealm() {
        let unitTypeObjects = UnitType.read(from: realm)
        UnitType.remove(results: unitTypeObjects, from: realm)
    }
    
    private func getUnitsFromRealm(from building: String) -> [SCUnit] {
        let unitObject = SCUnit.read(from: realm)
        let unitData = unitObject.compactMap { SCUnit(managedObject: $0) }
        let unitArray = Array(unitData)
        let filteredUnits = unitArray.filter({ $0.builtFrom == building })
    
        return filteredUnits
    }
}
