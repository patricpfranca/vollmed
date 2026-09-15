//
//  RequestError.swift
//  Vollmed
//
//  Created by Patric Pereira on 14/09/26.
//

import Foundation

enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unknown
    case custom(_ error: [String: Any])
    
    var customMessage: String {
        switch self {
        case .decode:
            return "Erro de decodificação"
        case .unauthorized:
            return "Sessão expirada"
        default:
            return "erro desconhecido"
        }
    }
}
