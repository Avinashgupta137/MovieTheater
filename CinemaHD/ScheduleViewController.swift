//
//  ScheduleViewController.swift
//  CinemaHD
//
//  Created by Avinash on 22/08/24.
//

import UIKit

class ScheduleViewController: UIViewController {
    
    @IBOutlet weak var scheduleTablView: UITableView!
    var schedule: [Schedule] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView() {
        scheduleTablView.delegate = self
        scheduleTablView.dataSource = self
        scheduleTablView.reloadData()
        
    }
    
}

extension ScheduleViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schedule.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieScheduleCell", for: indexPath) as? MovieScheduleCell
        cell?.movieTitleLbl.text = schedule[indexPath.row].day
        
        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let movieDetailsVC = storyboard?.instantiateViewController(withIdentifier: "MovieTimeViewController") as? MovieTimeViewController {
            movieDetailsVC.movieTimes = schedule[indexPath.row].showTimings
            navigationController?.pushViewController(movieDetailsVC, animated: true)
        }
            
    }
    
}


class MovieScheduleCell: UITableViewCell {

    @IBOutlet weak var movieTitleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
