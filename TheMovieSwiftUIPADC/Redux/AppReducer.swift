//
//  AppReducer.swift
//  TheMovieSwiftUIPADC
//
//  Created by Wai Yan Moe on 07/09/2023.
//

import Foundation

func dispatch(state : inout AppState, action : AppAction) {
    
    switch (action) {
    
        

    case .onNowPlayingMoviesLoaded(nowPlayingMovies: let nowPlayingMovies):
        state.nowPlayingMovies = nowPlayingMovies
        
    case .onPopularMoviesLoaded(popularMovies: let popularMovies):
        state.popularMovies = popularMovies

    
    case .onTopRatedMoviesLoaded(topRatedMovies: let topRatedMovies):
        state.topRatedMovies = topRatedMovies
    
    case .onGenresLoaded(genres: let genres):
        state.genres = genres
   
    case .setSelectedGenre(genreId: let genreId):
        state.genres = state.genres?.selectGenreAndReturnArray(withId: genreId) ?? []
    case .onMoviesByGenreLoaded(moviesByGenres: let moviesByGenres):
        state.moviesByGenre = moviesByGenres
    
    case .onActorsLoaded(actors: let actors):
        state.actors = actors
    
    case .onMovieDetailsLoaded(movieDetail: let movieDetail):
        state.movieDetails = movieDetail
    
    case .onCastLoaded(cast: let cast):
        state.casts = cast
    case .onCrewLoaded(crew: let crew):
        state.crews = crew
        
    default:
        break
    }
}
