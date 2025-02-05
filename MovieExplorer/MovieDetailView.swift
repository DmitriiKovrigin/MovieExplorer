//
//  MovieDetailView.swift
//  MovieExplorer
//
//  Created by Dima Kovrigin on 05.02.2025.
//

import SwiftUI

struct MovieDetailView: View {
    let movie: Movie

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let posterPath = movie.posterPath,
                   let posterURL = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") {
                    AsyncImage(url: posterURL) { image in
                        image.resizable()
                             .scaledToFit()
                             .cornerRadius(10)
                             .shadow(radius: 10)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(maxWidth: .infinity)
                } else {
                    Image(systemName: "film")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 300)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity)
                }

                Text(movie.title)
                    .font(.title)
                    .bold()

                Text("Рейтинг: \(String(format: "%.1f", movie.voteAverage ?? 0))/10")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Text("Дата релиза: \(movie.releaseDate ?? "Неизвестна")")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                if let overview = movie.overview {
                    Text(overview)
                        .font(.body)
                        .padding(.top, 8)
                } else {
                    Text("Описание недоступно")
                        .font(.body)
                        .foregroundColor(.secondary)
                }
            }
            .padding()
        }
        .navigationTitle("Детали фильма")
    }
}
