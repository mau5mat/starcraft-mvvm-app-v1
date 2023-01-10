//
//  DataParser.swift
//  starcraft-mvvm-app-v1
//
//  Created by Matthew Roberts on 09/01/2023.
//

import Foundation

protocol DataParserProtocol {
    func parse<T: Codable>(data: Data) throws -> T
}

struct DataParser: DataParserProtocol {
    private var jsonDecoder: JSONDecoder
    
    init(jsonDecoder: JSONDecoder = JSONDecoder()) {
        self.jsonDecoder = jsonDecoder
        self.jsonDecoder.keyDecodingStrategy = .useDefaultKeys
    }
    
    func parse<T: Codable>(data: Data) throws -> T {
        return try jsonDecoder.decode(T.self, from: data)
    }
}
