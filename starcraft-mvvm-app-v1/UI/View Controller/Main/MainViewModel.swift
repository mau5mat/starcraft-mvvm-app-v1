//
//  MainViewModel.swift
//  starcraft-mvvm-app-v1
//
//  Created by Matthew Roberts on 09/01/2023.
//

import UIKit
import RealmSwift
import Combine

class MainViewModel: ObservableObject {
    @Published private(set) var loadingState: LoadingState<Error>
    
    private let responseService: EndpointResponseServiceProtocol
    private let realmActions: MainRealmActionsProtocol
    
    private let persistenceService: PersistenceService
    private let connectionManager: ConnectionManager
    
    var cancellables: Set<AnyCancellable> = []
    
    private(set) var units: [SCUnit] = []
    
    init(responseService: EndpointResponseServiceProtocol, realmActions: MainRealmActionsProtocol, persistenceService: PersistenceService, connectionManager: ConnectionManager) {
        self.responseService = responseService
        self.realmActions = realmActions
        self.persistenceService = persistenceService
        self.connectionManager = connectionManager
        
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
        loadingState = .loading
        do {
            fetchUnitsWithRealmIfOffline(from: "Barracks")
            
            let unitData: [SCUnit] = try await responseService.decodeData(from: TerranEndpoint.getBarracksUnits)
            units = unitData
            
            persistenceService.realm.writeAsync {
                self.realmActions.removeUnitsFrom(realm: self.persistenceService.realm)
                
                for unit in unitData {
                    unit.add(to: self.persistenceService.realm, with: .all)
                }
            }
            loadingState = .loaded
        } catch {
            loadingState = .failed(error)
            print(error.localizedDescription)
        }
    }
    
    @MainActor
    func fetchFactoryUnits() async {
        loadingState = .loading
        do {
            fetchUnitsWithRealmIfOffline(from: "Factory")
            
            let unitData: [SCUnit] = try await responseService.decodeData(from: TerranEndpoint.getFactoryUnits)
            units = unitData
            
            persistenceService.realm.writeAsync {
                self.realmActions.removeUnitsFrom(realm: self.persistenceService.realm)
                
                for unit in unitData {
                    unit.add(to: self.persistenceService.realm, with: .all)
                }
            }
            loadingState = .loaded
        } catch {
            loadingState = .failed(error)
            print(error.localizedDescription)
        }
    }
    
    @MainActor
    func fetchStarportUnits() async {
        loadingState = .loading
        do {
            fetchUnitsWithRealmIfOffline(from: "Starport")
            
            let unitData: [SCUnit] = try await responseService.decodeData(from: TerranEndpoint.getStarportUnits)
            units = unitData
            
            persistenceService.realm.writeAsync {
                self.realmActions.removeUnitsFrom(realm: self.persistenceService.realm)
                
                for unit in unitData {
                    unit.add(to: self.persistenceService.realm, with: .all)
                }
            }
            loadingState = .loaded
        } catch {
            loadingState = .failed(error)
            print(error.localizedDescription)
        }
    }
    
    private func fetchUnitsWithRealmIfOffline(from building: String) {
        if connectionManager.noInternet() {
            loadingState = .noInternet
            
            let unitsFromRealm = realmActions.getUnitsFrom(realm: persistenceService.realm, with: building)
            units = unitsFromRealm
            
            loadingState = .loaded
        }
    }
}
