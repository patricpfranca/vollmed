//
//  Patient.swift
//  Vollmed
//
//  Created by Patric Pereira on 10/09/26.
//

import Foundation

struct Patient: Codable, Identifiable {
    let id: String?
    let name: String
    let cpf: String
    let email: String
    let password: String
    let phoneNumber: String
    let healthPlan: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case cpf
        case name = "nome"
        case email
        case password = "senha"
        case phoneNumber = "telefone"
        case healthPlan = "planoSaude"
    }
}
