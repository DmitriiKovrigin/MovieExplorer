//
//  MovieService.swift
//  MovieExplorer
//
//  Created by Dima Kovrigin on 05.02.2025.
//

import Foundation

class MovieService {
    private let apiKey = "89f9418e414edbd95100c5b434b60122" // Вставь свой API ключ
    private let baseURL = "https://api.themoviedb.org/3/movie/popular"

    func fetchMovies(completion: @escaping ([Movie]?) -> Void) {
        guard let url = URL(string: "\(baseURL)?api_key=\(apiKey)&language=en-US&page=1") else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("❌ Ошибка запроса: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("❌ Нет данных от сервера")
                completion(nil)
                return
            }
            
            // 🟢 Выводим сырые данные JSON
            if let jsonString = String(data: data, encoding: .utf8) {
                print("✅ JSON от API: \(jsonString)")
            }

            do {
                let decoder = JSONDecoder()
                let movieResponse = try decoder.decode(MovieResponse.self, from: data)
                completion(movieResponse.results)
            } catch {
                print("❌ Ошибка парсинга JSON: \(error.localizedDescription)")
                completion(nil)
            }
        }
        
        task.resume()
    }

}

struct MovieResponse: Codable {
    var results: [Movie]
}
