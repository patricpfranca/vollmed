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
    let authService: AuthenticationServiceable
    var authManager = AuthenticationManager.shared
    
    // MARK: - Init
    init(service: HomeServiceable, authService: AuthenticationServiceable) {
        self.service = service
        self.authService = authService
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
        let result = try await authService.logout()
        
        switch result {
        case .success(_ ):
            authManager.removeToken()
            authManager.removePatientID()
        case .failure(let error):
            print(error.localizedDescription)
        }
        
        

    }
}
