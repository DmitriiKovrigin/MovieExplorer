//
//  ContentView.swift
//  MovieExplorer
//
//  Created by Dima Kovrigin on 05.02.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var movies: [Movie] = []

    var body: some View {
        NavigationView {
            List(movies) { movie in
                NavigationLink(destination: MovieDetailView(movie: movie)) {
                    HStack {
                        if let posterPath = movie.posterPath,
                           let posterURL = URL(string: "https://image.tmdb.org/t/p/w200\(posterPath)") {
                            AsyncImage(url: posterURL) { image in
                                image.resizable()
                                     .scaledToFill()
                                     .frame(width: 50, height: 75)
                                     .clipped()
                            } placeholder: {
                                ProgressView()
                            }
                        } else {
                            Image(systemName: "film")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 75)
                                .foregroundColor(.gray)
                        }

                        VStack(alignment: .leading) {
                            Text(movie.title)
                                .font(.headline)
                            Text(movie.releaseDate ?? "Дата неизвестна")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .onAppear {
                MovieService().fetchMovies { fetchedMovies in
                    DispatchQueue.main.async {
                        self.movies = fetchedMovies ?? []
                    }
                }
            }
            .navigationTitle("Popular Movies")
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
