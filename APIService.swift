//
//  APIService.swift
//  NASA_APOD
//
//  Created by Shrikrishna Thodsare on 15/12/25.
//

import Foundation

class APIService {
    
    static let shared = APIService()
    private init() {}
    
    func fetchAPOD(
        date: String?,
        completion: @escaping (Result<APOD, Error>) -> Void
    ) {
        
        var components = URLComponents(string: AppConstants.baseURL)
        var queryItems = [
            URLQueryItem(name: "api_key", value: AppConstants.apiKey)
        ]
        
        if let date = date {
            queryItems.append(URLQueryItem(name: "date", value: date))
        }
        
        components?.queryItems = queryItems
        
        guard let url = components?.url else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let apod = try JSONDecoder().decode(APOD.self, from: data)
                completion(.success(apod))
            } catch {
                completion(.failure(error))
            }
            
        }.resume()
    }
}
