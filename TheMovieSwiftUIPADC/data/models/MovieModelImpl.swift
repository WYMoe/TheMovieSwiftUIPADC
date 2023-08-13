//
//  MovieModelImpl.swift
//  TheMovieSwiftUIPADC
//
//  Created by Wai Yan Moe on 16/07/2023.
//

import Foundation
struct MovieModelImpl : MovieModel {
   
    
    
    static let shared = MovieModelImpl()
    
    private init(){
        
    }
    
    //data agent
    let mDataAgent : MovieDataAgent = MovieDataAgentImpl.shared
    
    //dao
    let mMovieDao = MovieDAO.shared
    
    
    func getNowPlayingMovies(page: Int, onSuccess: @escaping ([MovieVO]) -> Void, onFailure: @escaping (Error) -> Void) {
        mDataAgent.getNowPlayingMovies(page: page, onSuccess: { nowPlayingMovies in
            onSuccess(nowPlayingMovies)
            //save to db
            self.mMovieDao.saveMovies(movies: nowPlayingMovies, for: MOVIE_TYPE_NOW_PLAYING)
        }, onFailure: onFailure)

    }
    
    func getPopularMovies(page: Int, onSuccess: @escaping ([MovieVO]) -> Void, onFailure: @escaping (Error) -> Void) {
        mDataAgent.getPopularMovies(page: page, onSuccess: { popularMovies in
            onSuccess(popularMovies)
            
            //save to db
            self.mMovieDao.saveMovies(movies: popularMovies, for: MOVIE_TYPE_POPULAR)
        }, onFailure: onFailure)
    }
    
    func getTopRatedMovies(page: Int, onSuccess: @escaping ([MovieVO]) -> Void, onFailure: @escaping (Error) -> Void) {
        mDataAgent.getTopRatedMovies(page: page, onSuccess: { topRatedMovies in
            onSuccess(topRatedMovies)
            //save to db
            self.mMovieDao.saveMovies(movies: topRatedMovies, for: MOVIE_TYPE_TOP_RATED)
        }, onFailure: onFailure)
    }
    
    func getGenres(onSuccess: @escaping ([GenreVO]) -> Void, onFailure: @escaping (Error) -> Void) {
        mDataAgent.getGenres(onSuccess: onSuccess, onFailure: onFailure)
    }
    
    func getMoviesByGenre(genreId: Int?, onSuccess: @escaping ([MovieVO]) -> Void, onFailure: @escaping (Error) -> Void) {
        mDataAgent.getMoviesByGenre(genreId: genreId, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    func getActors(onSuccess: @escaping ([ActorVO]) -> Void, onFailure: @escaping (Error) -> Void) {
        mDataAgent.getActors(onSuccess: onSuccess, onFailure: onFailure)
    }
    
    func getMovieDetails(movieId: Int, onSuccess: @escaping (MovieVO) -> Void, onFailure: @escaping (Error) -> Void) {
        mDataAgent.getMovieDetails(movieId: movieId, onSuccess: { movieDetails in
            onSuccess(movieDetails)
            
           
            
            
            //save to db
            self.mMovieDao.saveMovieDetail(movie: movieDetails)
            
        }, onFailure: onFailure)
    }
    
    func getCredits(movieId: Int, onSuccess: @escaping ([ActorVO], [ActorVO]) -> Void, onFailure: @escaping (Error) -> Void) {
        mDataAgent.getCredits(movieId: movieId, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    
    //database
    func getAllMoviesFromDatabase() -> [MovieVO] {
       return mMovieDao.getAllMovies()
    }
    
    func getMovieByIdFromDatabase(id: Int) -> MovieVO? {
        return mMovieDao.getMovieById(movieId: id)
    }
    
    func getNowPlayingMoviesFromDatabase() -> [MovieVO] {
        return mMovieDao.getMoviesByType(type: MOVIE_TYPE_NOW_PLAYING)
    }
    
    func getPopularMoviesFromDatabase() -> [MovieVO] {
        return mMovieDao.getMoviesByType(type: MOVIE_TYPE_POPULAR)

    }
    
    func getTopRatedMoviesFromDatabase() -> [MovieVO] {
        return mMovieDao.getMoviesByType(type: MOVIE_TYPE_TOP_RATED)

    }
    
    
}
