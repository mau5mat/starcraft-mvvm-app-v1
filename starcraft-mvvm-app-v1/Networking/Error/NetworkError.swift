//
//  NetworkError.swift
//  starcraft-mvvm-app-v1
//
//  Created by Matthew Roberts on 09/01/2023.
//
import Foundation

enum NetworkError: Error {
    case invalidServerResponse
    case invalidURL
    case unknownApi
    case offline
}
