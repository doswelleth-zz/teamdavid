//
//  MovieController.swift
//  TeamDavid-Sprint-1
//
//  Created by David Doswell on 12/15/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import Foundation

class MovieController {
    
    // create an array to hold added movies
    var movies: [Movie] = []
    
    // create a shared instance of `MovieController` to be used within the app
    static let shared = MovieController()
    
    // create a function to save a movie to our array
    func saveNewMovie(name: String, hasSeen: Bool) {
        let movie = Movie(name: name, hasSeen: hasSeen)
        movies.append(movie)
    }
}
