//
//  LoadingState.swift
//  starcraft-mvvm-app-v1
//
//  Created by Matthew Roberts on 09/01/2023.
//

import Foundation

enum LoadingState<E: Error> {
    case idle
    case loading
    case loaded
    case failed(E)
    case noInternet
}
