//
//  HomeViewModel.swift
//  Vollmed
//
//  Created by Patric Pereira on 14/09/26.
//

import Foundation

@MainActor
struct HomeViewModel {
    
    let service = WebService()
    var authManager = AuthenticationManager.shared
    
    func getSpecialists() async throws -> [Specialist] {
        do {
            if let fetchedSpecialists = try await service.getAllSpecialists() {
                return fetchedSpecialists
            }
            
            return []
        } catch {
            print("Ocorreu um erro ao obter especialistas: \(error)")
            throw error
        }
    }
    
    func logout() async {
        do {
            _ = try await service.logoutPatient()
            
            authManager.removeToken()
            authManager.removePatientID()
        } catch {
            print("Ocorreu um erro no logout: \(error)")
        }
    }
}
