//
//  MovieModel.swift
//  TheMovieSwiftUIPADC
//
//  Created by Wai Yan Moe on 16/07/2023.
//

import Foundation
protocol MovieModel {
    func getNowPlayingMovies(page : Int, onSuccess : @escaping([MovieVO]) -> Void, onFailure: @escaping (Error) -> Void)
    
    func getPopularMovies(page : Int, onSuccess : @escaping([MovieVO]) -> Void, onFailure: @escaping (Error) -> Void)
    
    func getTopRatedMovies(page : Int, onSuccess : @escaping([MovieVO]) -> Void, onFailure: @escaping (Error) -> Void)
    
    func getGenres(onSuccess : @escaping([GenreVO]) -> Void, onFailure: @escaping (Error) -> Void)
    
    func getMoviesByGenre(genreId : Int?, onSuccess : @escaping([MovieVO]) -> Void, onFailure: @escaping (Error) -> Void)
    
    func getActors(onSuccess : @escaping([ActorVO]) -> Void, onFailure: @escaping (Error) -> Void)
    
    func getMovieDetails(movieId : Int, onSuccess : @escaping(MovieVO) -> Void, onFailure: @escaping (Error) -> Void)
    
    func getCredits(movieId : Int, onSuccess : @escaping([ActorVO],[ActorVO]) -> Void, onFailure: @escaping (Error) -> Void)
}
