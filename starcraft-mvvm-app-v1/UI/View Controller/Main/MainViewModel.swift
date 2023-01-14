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
    
    private(set) var barracksUnits: [SCUnit] = []
    private(set) var factoryUnits: [SCUnit] = []
    private(set) var starportUnits: [SCUnit] = []
    
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
    func fetchAllUnits() async {
        loadingState = .loading
        
        await fetchBarracksUnits()
        await fetchFactoryUnits()
        await fetchStarportUnits()
        
        loadingState = .loaded
    }
    
    @MainActor
    func fetchBarracksUnits() async {
        do {
            guard connectionManager.noInternet() else {
                barracksUnits = fetchUnitsWithRealmIfOffline(from: "Barracks")
                loadingState = .noInternet
                return
            }
            
            let unitData: [SCUnit] = try await responseService.decodeData(from: TerranEndpoint.getBarracksUnits)
            barracksUnits = unitData
            
            persistenceService.realm.writeAsync {
                self.realmActions.removeUnitsFrom(realm: self.persistenceService.realm)
                
                for unit in unitData {
                    unit.add(to: self.persistenceService.realm, with: .all)
                }
            }
        } catch {
            loadingState = .failed(error)
        }
    }
    
    @MainActor
    func fetchFactoryUnits() async {
        do {
            guard connectionManager.noInternet() else {
                factoryUnits = fetchUnitsWithRealmIfOffline(from: "Factory")
                loadingState = .noInternet
                return
            }
            
            let unitData: [SCUnit] = try await responseService.decodeData(from: TerranEndpoint.getFactoryUnits)
            factoryUnits = unitData
            
            persistenceService.realm.writeAsync {
                self.realmActions.removeUnitsFrom(realm: self.persistenceService.realm)
                
                for unit in unitData {
                    unit.add(to: self.persistenceService.realm, with: .all)
                }
            }
        } catch {
            loadingState = .failed(error)
        }
    }
    
    @MainActor
    func fetchStarportUnits() async {
        do {
            guard connectionManager.noInternet() else {
                starportUnits = fetchUnitsWithRealmIfOffline(from: "Starport")
                loadingState = .noInternet
                return
            }
            
            let unitData: [SCUnit] = try await responseService.decodeData(from: TerranEndpoint.getStarportUnits)
            starportUnits = unitData
            
            persistenceService.realm.writeAsync {
                self.realmActions.removeUnitsFrom(realm: self.persistenceService.realm)
                
                for unit in unitData {
                    unit.add(to: self.persistenceService.realm, with: .all)
                }
            }
        } catch {
            loadingState = .failed(error)
        }
    }
    
    private func fetchUnitsWithRealmIfOffline(from building: String) -> [SCUnit] {
        return realmActions.getUnitsFrom(realm: persistenceService.realm, with: building)
    }
}
