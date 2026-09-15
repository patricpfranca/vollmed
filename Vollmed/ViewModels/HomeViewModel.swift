//
//  HomeViewModel.swift
//  Vollmed
//
//  Created by Patric Pereira on 14/09/26.
//

import Foundation

@MainActor
struct HomeViewModel {
    
    // MARK: - Attributes
    let service: HomeServiceable
    var authManager = AuthenticationManager.shared
    
    // MARK: - Init
    init(service: HomeServiceable) {
        self.service = service
    }
    
    // MARK: - Class Methods
    func getSpecialists() async throws -> [Specialist]? {
        let result = try await service.getAllSpecialists()
        
        switch result {
        case .success(let response):
            return response
        case .failure(let error):
            throw error
        }
    }
    
    func logout() async {
        let oldService = WebService()
        do {
            _ = try await oldService.logoutPatient()
            
            authManager.removeToken()
            authManager.removePatientID()
        } catch {
            print("Ocorreu um erro no logout: \(error)")
        }
    }
}
