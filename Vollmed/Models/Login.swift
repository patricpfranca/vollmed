//
//  Login.swift
//  Vollmed
//
//  Created by Patric Pereira on 10/09/26.
//

import Foundation

struct LoginRequest: Codable {
    let email: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case email
        case password = "senha"
    }
}

struct LoginResponse: Codable, Identifiable {
    let id: String
    let auth: Bool
    let token: String
}
