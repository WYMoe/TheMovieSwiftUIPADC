//
//  AppActions.swift
//  TheMovieSwiftUIPADC
//
//  Created by Wai Yan Moe on 06/09/2023.
//

import Foundation

enum AppAction {
    case getnowPlayingMovies
    case startObservingNowPlayingMovies
    case onNowPlayingMoviesLoaded(nowPlayingMovies : [MovieVO])
    
    case getPopularMovies
    case startObservingPopularMovies
    case onPopularMoviesLoaded(popularMovies : [MovieVO])
    
    case getTopRatedMovies
    case startObservingTopRatedMovies
    case onTopRatedMoviesLoaded(topRatedMovies : [MovieVO])
    
    case getGenres
    case onGenresLoaded(genres : [GenreVO])
    
    case setSelectedGenre(genreId : Int)
    
    case getMoviesByGenre(genreId : Int)
    case onMoviesByGenreLoaded(moviesByGenres : [MovieVO])
    
    case getActors
    case onActorsLoaded(actors : [ActorVO])
    
    case getMovieDetails(movieId : Int)
    case onMovieDetailsLoaded(movieDetail : MovieVO?)
    
    case getCreditsByMovie(movieId : Int)
    case onCastLoaded(cast : [ActorVO])
    case onCrewLoaded(crew : [ActorVO])
    
   
}
