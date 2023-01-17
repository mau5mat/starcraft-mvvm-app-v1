//
//  MainViewModel.swift
//  starcraft-mvvm-app-v1
//
//  Created by Matthew Roberts on 09/01/2023.
//

import UIKit
import Combine

class MainViewModel: ObservableObject {
    @Published private(set) var loadingState: LoadingState<Error>
    
    private let responseService: EndpointResponseServiceProtocol
    private let realmActions: MainRealmActionsDelegate
    private let connectionManager: ConnectionManager
    
    var cancellables: Set<AnyCancellable> = []
    
    private(set) var barracksUnits: [SCUnit] = []
    private(set) var factoryUnits: [SCUnit] = []
    private(set) var starportUnits: [SCUnit] = []
    
    init(responseService: EndpointResponseServiceProtocol, realmActions: MainRealmActionsDelegate, connectionManager: ConnectionManager) {
        self.responseService = responseService
        self.realmActions = realmActions
        self.connectionManager = connectionManager
        
        loadingState = .idle
    }
    
    func buildingData() -> [BuildingData] {
        let buildingData = [BuildingData(type: .barracks, thumbnailImage: UIImage(named: "barracks")!),
                            BuildingData(type: .factory, thumbnailImage: UIImage(named: "factory")!),
                            BuildingData(type: .starport, thumbnailImage: UIImage(named: "starport")!)]
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
            barracksUnits = try await responseService.decodeData(from: TerranEndpoint.getBarracksUnits)
            
            PersistenceManager.shared.realm.writeAsync {
                self.realmActions.removeUnitsFromRealm()
                
                for unit in self.barracksUnits {
                    unit.add(to: PersistenceManager.shared.realm, with: .all)
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
            factoryUnits = try await responseService.decodeData(from: TerranEndpoint.getFactoryUnits)
            
            PersistenceManager.shared.realm.writeAsync {
                self.realmActions.removeUnitsFromRealm()
                
                for unit in self.factoryUnits {
                    unit.add(to: PersistenceManager.shared.realm, with: .all)
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
            starportUnits = try await responseService.decodeData(from: TerranEndpoint.getStarportUnits)
            
            PersistenceManager.shared.realm.writeAsync {
                self.realmActions.removeUnitsFromRealm()
                
                for unit in self.starportUnits {
                    unit.add(to: PersistenceManager.shared.realm, with: .all)
                }
            }
        } catch {
            loadingState = .failed(error)
        }
    }
    
    private func fetchUnitsWithRealmIfOffline(from building: String) -> [SCUnit] {
        return realmActions.getUnitsFromRealm(with: building)
    }
}
