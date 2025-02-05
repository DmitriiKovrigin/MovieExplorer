//
//  Model.swift
//  MovieExplorer
//
//  Created by Dima Kovrigin on 05.02.2025.
//



import Foundation

struct Movie: Identifiable, Codable {
    let id: Int
    let title: String
    let overview: String?
    let posterPath: String?
    let releaseDate: String?
    let voteAverage: Double?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path" // Исправляем ключ, чтобы он совпадал с JSON
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
}

