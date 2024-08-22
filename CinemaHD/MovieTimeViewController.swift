//
//  MovieTimeViewController.swift
//  CinemaHD
//
//  Created by Avinash on 22/08/24.
//

import UIKit

class MovieTimeViewController: UIViewController {
    
    @IBOutlet weak var movieTimeTablView: UITableView!
    var movieTimes: [[String?]] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    func setupTableView() {
        movieTimeTablView.delegate = self
        movieTimeTablView.dataSource = self
        movieTimeTablView.reloadData()
        
    }

}
extension MovieTimeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieTimes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieTimeCell", for: indexPath)
        let timings = movieTimes[indexPath.row][2]
        cell.textLabel?.text = timings
        return cell
    }
}
