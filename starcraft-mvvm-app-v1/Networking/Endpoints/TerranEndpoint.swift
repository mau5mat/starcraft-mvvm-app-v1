//
//  TerranEndpoint.swift
//  starcraft-mvvm-app-v1
//
//  Created by Matthew Roberts on 09/01/2023.
//

import Foundation

enum TerranEndpoint: Endpoint {
    case getAllUnits
    case getUnit(name: String)
    case getBarracksUnits
    case getFactoryUnits
    case getStarportUnits
    case getBiologicalUnits
    case getMechanicalUnits
    case getPsionicUnits
    case getSummonedUnits
    
    var scheme: URLScheme {
        switch self {
        default:
            return .https
        }
    }
    
    var baseURL: String {
        switch self {
        default:
            return BaseURL.localHost.rawValue
        }
    }
    
    var path: String {
        switch self {
        case .getAllUnits:
            return "/terran/units/all"
        case .getUnit(let name):
            return "/terran/units/named/\(name)"
        case .getBarracksUnits:
            return "/terran/units/from/barracks"
        case .getFactoryUnits:
            return "/terran/units/from/factory"
        case .getStarportUnits:
            return "/terran/units/from/starport"
        case .getBiologicalUnits:
            return "/terran/units/type/biological"
        case .getMechanicalUnits:
            return "/terran/units/type/mechanical"
        case .getPsionicUnits:
            return "/terran/units/type/psionic"
        case .getSummonedUnits:
            return "/terran/units/type/summoned"
        }
    }
    
    var parameters: [URLQueryItem]? {
        switch self {
        default:
            return nil
        }
    }
    
    var headers: [URLQueryItem] {
        switch self {
        default:
            return []
        }
    }
    
    var methodType: HTTPMethodType {
        switch self {
        default:
            return .GET
        }
    }
    
    var bearerToken: String? {
        switch self {
        default:
            return nil
        }
    }
    
    var httpBody: Data? {
        switch self {
        default:
            return nil
        }
    }
}
