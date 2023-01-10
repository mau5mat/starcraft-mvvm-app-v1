//
//  ErrorResponseMessage.swift
//  starcraft-mvvm-app-v1
//
//  Created by Matthew Roberts on 09/01/2023.
//

import Foundation

enum ErrorResponseMessage: Int {
    case badRequest = 400
    case unauthorized = 401
    case paymentRequired = 402
    case forbidden = 403
    case notFound = 404
    case methodNotAllowed = 405
    case notAcceptable = 406
    case proxyAuthenticationRequired = 407
    case requestTimeout = 408
    case conflict = 409
    case gone = 410
    case lengthRequired = 411
    case preconditionFailed = 412
    case payloadTooLarge = 413
    case URITooLong = 414
    case unsupportedMediaType = 415
    case rangeNotSatisfiable = 416
    case expectationFailed = 417
    case teapot = 418
    case misdirectedRequest = 421
    case unprocessableEntity = 422
    case locked = 423
    case failedDependency = 424
    case upgradeRequired = 426
    case preconditionRequired = 428
    case tooManyRequests = 429
    case requestHeaderFieldsTooLarge = 431
    case noResponse = 444
    case unavailableForLegalReasons = 451
    case SSLCertificateError = 495
    case SSLCertificateRequired = 496
    case HTTPRequestSentToHTTPSPort = 497
    case clientClosedRequest = 499
    case internalServerError = 500
    case notImplemented = 501
    case badGateway = 502
    case serviceUnavailable = 503
    case gatewayTimeout = 504
    case HTTPVersionNotSupported = 505
    case variantAlsoNegotiates = 506
    case insufficientStorage = 507
    case loopDetected = 508
    case notExtended = 510
    case networkAuthenticationRequired = 511
    case unknownError = 999
    
    var message: String {
        switch self {
        case .badRequest:
            return "Bad Request."
        case .unauthorized:
            return "Unauthorized."
        case .paymentRequired:
            return "Payment Required."
        case .forbidden:
            return "Forbidden."
        case .notFound:
            return "Not Found."
        case .methodNotAllowed:
            return "Method Not Allowed."
        case .notAcceptable:
            return "Not Acceptable."
        case .proxyAuthenticationRequired:
            return "Proxy Authentication Required."
        case .requestTimeout:
            return "Request Timeout."
        case .conflict:
            return "Conflict."
        case .gone:
            return "Gone."
        case .lengthRequired:
            return "Length Required."
        case .preconditionFailed:
            return "Precondition Failed."
        case .payloadTooLarge:
            return "Payload Too Large."
        case .URITooLong:
            return "URI Too Long."
        case .unsupportedMediaType:
            return "Unsupported Media Type."
        case .rangeNotSatisfiable:
            return "Range Not Satisfiable."
        case .expectationFailed:
            return "Expectation Failed."
        case .teapot:
            return "I'm a teapot."
        case .misdirectedRequest:
            return "Misdirected Request."
        case .unprocessableEntity:
            return "Unprocessable Entity."
        case .locked:
            return "Locked."
        case .failedDependency:
            return "Failed Dependency."
        case .upgradeRequired:
            return "Upgrade Required."
        case .preconditionRequired:
            return "Precondition Required"
        case .tooManyRequests:
            return "Too Many Requests."
        case .requestHeaderFieldsTooLarge:
            return "Request Header Fields Too Large."
        case .noResponse:
            return "No Response."
        case .unavailableForLegalReasons:
            return "Unavailable For Legal Reasons."
        case .SSLCertificateError:
            return "SSL Certificate Error."
        case .SSLCertificateRequired:
            return "SSL Certificate Required."
        case .HTTPRequestSentToHTTPSPort:
            return "HTTP Request Sent to HTTPS Port."
        case .clientClosedRequest:
            return "Client Closed Request."
        case .internalServerError:
            return "Internal Server Error."
        case .notImplemented:
            return "Not Implemented."
        case .badGateway:
            return "Bad Gateway."
        case .serviceUnavailable:
            return "Service Unavailable."
        case .gatewayTimeout:
            return "Gateway Timeout."
        case .HTTPVersionNotSupported:
            return "HTTP Version Not Supported."
        case .variantAlsoNegotiates:
            return "Variant Also Negotiates."
        case .insufficientStorage:
            return "Insufficient Storage."
        case .loopDetected:
            return "Loop Detected."
        case .notExtended:
            return "Not Extended."
        case .networkAuthenticationRequired:
            return "Network Authentication Required."
        case .unknownError:
            return "Unknown Error."
        }
    }
}
