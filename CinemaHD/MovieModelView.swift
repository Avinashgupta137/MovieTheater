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
        return movies?.schedules.filter { schedule in
            schedule.showTimings.contains { timing in
                // Safely unwrap `timing.first` which is a String?
                if let timingMovieID = timing[1] {
                    // Check if the movie's `movieIDS` contains the `timingMovieID`
                    return movie.movieIDS.contains { movieIDArray in
                        movieIDArray.contains(timingMovieID)
                    }
                }
                return false
            }
        } ?? []
    }
    func getTheatres() -> [Theatre] {
        return movies?.theatres ?? []
    }
}
