import Foundation

class MovieViewModel {
    var movies: MovieData?

    init() {
        loadMovies()
    }

    private func loadMovies() {
        guard let fileLocation = Bundle.main.url(forResource: "MovieTest", withExtension: "json") else {
            print("File not found.")
            return
        }
        do {
            let data = try Data(contentsOf: fileLocation)
            let decoder = JSONDecoder()
            movies = try decoder.decode(MovieData.self, from: data)
            print("Movies loaded successfully")
            if let movieDetails = movies?.movieDetails {
                        for movie in movieDetails {
                            print("Movie name: \(movie.filmName)")
                        }
                    }
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }

    func getMovies(forTheatre theatre: Theatre) -> [MovieDetail] {
        var theatreData:[MovieDetail] = []
        theatreData.append(contentsOf: movies?.movieDetails.filter { movie in
            movie.movieIDS.contains(where: { $0.contains(theatre.posTheatreID) })
        } ?? [])
        print("aaa", theatreData)
        return movies?.movieDetails ?? []
    }

    func getSchedules(forMovie movie: MovieDetail) -> [Schedule] {
        var movieData:[Schedule] = []
        movieData.append(contentsOf: movies?.schedules.filter { schedule in
            schedule.showTimings.contains(where: { $0.first == movie.filmcommonID })
        } ?? [])
        return movies?.schedules ?? []
    }

    func getTheatres() -> [Theatre] {
        return movies?.theatres ?? []
    }
}
