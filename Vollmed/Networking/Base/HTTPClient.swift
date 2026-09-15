//
//  HttpClient.swift
//  Vollmed
//
//  Created by Patric Pereira on 15/09/26.
//

import Foundation

protocol HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async -> Result<T, RequestError>
}
