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
      
            let selectedMovie = movies[indexPath.row]
            schedule = viewModel.getSchedules(forMovie: selectedMovie)
            bindschedule(schedule)
            if let movieDetailsVC = storyboard?.instantiateViewController(withIdentifier: "ScheduleViewController") as? ScheduleViewController {
                movieDetailsVC.schedule = schedule
                navigationController?.pushViewController(movieDetailsVC, animated: true)
            }
        }
    
}

