//
//  MovieDataModel.swift
//  CinemaHD
//
//  Created by Avinash Gupta on 22/08/24.
//

import Foundation


// MARK: - MovieData
struct MovieData: Codable {
    let movieDetails: [MovieDetail]
    let schedules: [Schedule]
    let theatres: [Theatre]
}

// MARK: - MovieDetail
struct MovieDetail: Codable {
    let filmcommonID, filmName, pgRating, runTime: String
    let filmGenre, filmStatus, castCrew, director: String
    let synopsis: String
    let movieIDS: [[String]]
    let languages: [Language]

    enum CodingKeys: String, CodingKey {
        case filmcommonID = "filmcommonId"
        case filmName
        case pgRating = "PGRating"
        case runTime, filmGenre, filmStatus, castCrew, director, synopsis
        case movieIDS = "movieIds"
        case languages
    }
}

// MARK: - Language
struct Language: Codable {
    let language, potraitPoster, landscapePoster: String
    let filmFormats, posMovieID: [String]
    let trailerLink: String
    let releaseDate: String

    enum CodingKeys: String, CodingKey {
        case language, potraitPoster, landscapePoster, filmFormats
        case posMovieID = "PosMovieId"
        case trailerLink, releaseDate
    }
}

// MARK: - Schedule
struct Schedule: Codable {
    let day: String
    let showTimings: [[String?]]
}

// MARK: - Theatre
struct Theatre: Codable {
    let id, posCityID, posTheatreID, theatreName: String
    let address1, address2, lat, long: String
    let isOnline: String
    let imagesArr, galleryArr: [String]
    var distance: Double? // Add extra
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case posCityID = "PosCityID"
        case posTheatreID = "PosTheatreID"
        case theatreName = "TheatreName"
        case address1 = "Address1"
        case address2 = "Address2"
        case lat = "Lat"
        case long = "Long"
        case isOnline = "IsOnline"
        case imagesArr = "ImagesArr"
        case galleryArr = "GalleryArr"
    }
}
