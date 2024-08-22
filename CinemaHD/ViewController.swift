import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    private var viewModel: MovieViewModel!
    private var locationManager: CLLocationManager!
    private var userLocation: CLLocation?
    
    @IBOutlet weak var tableView: UITableView!
    var schedule : [Schedule] = []
    var theatres: [Theatre] = []
    var movies: [MovieDetail] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MovieViewModel()
        setupLocationManager()
        setupTableView()
    }

    func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            userLocation = location
            updateTheatreDistances()
        }
    }

    func updateTheatreDistances() {
        if let userLocation = userLocation {
            theatres = viewModel.getTheatres().map { theatre in
                var updatedTheatre = theatre
                let theatreLocation = CLLocation(latitude: Double(theatre.lat)!, longitude: Double(theatre.long)!)
                let distance = userLocation.distance(from: theatreLocation)
                updatedTheatre.distance = distance
                return updatedTheatre
            }.sorted { $0.distance ?? 0 < $1.distance ?? 0 }

            tableView.reloadData()
        }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return theatres.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        let theatre = theatres[indexPath.row]
        cell.lblThreator.text = theatre.theatreName
        if let distance = theatre.distance {
            cell.lblLocation.text = String(format: "%.2f km", distance / 1000)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTheatre = theatres[indexPath.row]
        movies = viewModel.getMovies(forTheatre: selectedTheatre)
        bindMovies(movies)
        if let movieDetailsVC = storyboard?.instantiateViewController(withIdentifier: "MoviesViewController") as? MoviesViewController {
            movieDetailsVC.movies = movies
            movieDetailsVC.schedule = schedule
            navigationController?.pushViewController(movieDetailsVC, animated: true)
        }
    }
    
}

extension ViewController {
    func bindMovies(_ movies: [MovieDetail]) {
        self.movies = movies
    }
}
