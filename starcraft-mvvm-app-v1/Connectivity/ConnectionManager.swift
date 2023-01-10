//
//  ConnectionManager.swift
//  starcraft-mvvm-app-v1
//
//  Created by Matthew Roberts on 09/01/2023.
//

import Foundation
import Reachability

struct ConnectionManager {
    let reachability = try! Reachability()
    
    func noInternet() -> Bool {
        return reachability.connection == .unavailable
    }
    
    func isConnected() -> Bool {
        return reachability.connection != .unavailable
    }
}
