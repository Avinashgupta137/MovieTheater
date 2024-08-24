//
//  MoviesViewController.swift
//  CinemaHD
//
//  Created by Avinash on 22/08/24.
//

import UIKit

class MoviesViewController: UIViewController {
    
    private var viewModel: MovieViewModel!
    var movies: [MovieDetail] = []
    var schedule: [Schedule] = []
    
    @IBOutlet weak var tableViewMovie: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func bindschedule(_ schedule: [Schedule]) {
        self.schedule = schedule
    }
    
    func setupTableView() {
        viewModel = MovieViewModel()
        // Assuming you have a selected theatre
        if let selectedTheatre = viewModel.getTheatres().first {
            movies = viewModel.getMovies(forTheatre: selectedTheatre)
        }
        tableViewMovie.delegate = self
        tableViewMovie.dataSource = self
        tableViewMovie.reloadData()
    }
    
}

extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieSelectCell", for: indexPath) as? MovieSelectCell
        cell?.movieTitleLbl.text = movies[indexPath.row].filmName
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMovieId = movies[indexPath.row].filmcommonID
        schedule = viewModel.movies?.schedules.filter{ schedule in
            schedule.showTimings.contains { showTiming in
                if showTiming[1] == selectedMovieId {
                    print(showTiming[7])
                }
                
                   return showTiming[1] == selectedMovieId
                }
        } ?? []
        bindschedule(schedule)
        if let movieDetailsVC = storyboard?.instantiateViewController(withIdentifier: "ScheduleViewController") as? ScheduleViewController {
            movieDetailsVC.schedule = schedule
            movieDetailsVC.selectedMovieId = selectedMovieId
            navigationController?.pushViewController(movieDetailsVC, animated: true)
        }
    }
}
