//
//  EndpointResponseService.swift
//  starcraft-mvvm-app-v1
//
//  Created by Matthew Roberts on 09/01/2023.
//

import Foundation

protocol NetworkServiceProtocol {
    func requestData(with endpoint: Endpoint) async throws -> Data
}

struct NetworkService: NetworkServiceProtocol {
    private let urlSession: URLSession
    private let parser: DataParserProtocol
    
    init(urlSession: URLSession = URLSession.shared, parser: DataParserProtocol = DataParser()) {
        self.urlSession = urlSession
        self.parser = parser
    }
    
    func requestData(with endpoint: Endpoint) async throws -> Data {
        let (data, response) = try await urlSession.data(for: endpoint.createURLRequest())
        let statusCode = try convertToHttpUrlResponse(with: response).statusCode
        
        try handleApiErrors(with: statusCode, and: data)
        
        return data
    }
    
    private func convertToHttpUrlResponse(with response: URLResponse) throws -> HTTPURLResponse {
        guard let httpResponse = response as? HTTPURLResponse else { throw NetworkError.invalidServerResponse }
        
        return httpResponse
    }
    
    private func handleApiErrors(with statusCode: Int, and data: Data) throws {
        guard (200...308).contains(statusCode) else {
            do {
                let apiError: ApiError = try parser.parse(data: data)
                throw apiError
                
            } catch let error {
                guard error is ApiError else {
                    throw ApiError(name: "Error", code: statusCode, error: ApiError.getErrorResponseMessage(with: statusCode))
                }
                throw error
            }
        }
    }
}
