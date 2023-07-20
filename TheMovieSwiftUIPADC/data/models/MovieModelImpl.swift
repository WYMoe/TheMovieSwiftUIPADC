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
    
    func getNowPlayingMovies(page: Int, onSuccess: @escaping ([MovieVO]) -> Void, onFailure: @escaping (Error) -> Void) {
        mDataAgent.getNowPlayingMovies(page: page, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    func getPopularMovies(page: Int, onSuccess: @escaping ([MovieVO]) -> Void, onFailure: @escaping (Error) -> Void) {
        mDataAgent.getPopularMovies(page: page, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    func getTopRatedMovies(page: Int, onSuccess: @escaping ([MovieVO]) -> Void, onFailure: @escaping (Error) -> Void) {
        mDataAgent.getTopRatedMovies(page: page, onSuccess: onSuccess, onFailure: onFailure)
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
        mDataAgent.getMovieDetails(movieId: movieId, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    func getCredits(movieId: Int, onSuccess: @escaping ([ActorVO], [ActorVO]) -> Void, onFailure: @escaping (Error) -> Void) {
        mDataAgent.getCredits(movieId: movieId, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    
}
