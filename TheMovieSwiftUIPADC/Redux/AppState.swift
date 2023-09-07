//
//  AppState.swift
//  TheMovieSwiftUIPADC
//
//  Created by Wai Yan Moe on 06/09/2023.
//

import Foundation

struct AppState {
    //Home Screen
     var nowPlayingMovies : [MovieVO]? = []
     var popularMovies : [MovieVO]? = []
     var topRatedMovies : [MovieVO]? = []
     var genres : [GenreVO]? = []
     var moviesByGenre : [MovieVO]? = []
     var actors : [ActorVO]? = []
    
    
    //Details Screen
    
    var movieDetails : MovieVO? = nil
    var casts : [ActorVO]? = []
    var crews : [ActorVO]? = []
    
    
    
    
}
