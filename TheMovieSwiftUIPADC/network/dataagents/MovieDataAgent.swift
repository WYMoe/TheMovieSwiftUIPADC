//
//  MovieDataAgent.swift
//  TheMovieSwiftUIPADC
//
//  Created by Wai Yan Moe on 15/07/2023.
//

import Foundation
import Alamofire
import RxSwift

protocol MovieDataAgent {
    
    func getNowPlayingMovies(page : Int) -> Observable<[MovieVO]>
    
    func getPopularMovies(page : Int) -> Observable<[MovieVO]>
    
    func getTopRatedMovies(page : Int) -> Observable<[MovieVO]>
    
    func getGenres() -> Observable<[GenreVO]>
    
    func getMoviesByGenre(genreId : Int?) -> Observable<[MovieVO]>
    
    func getActors() -> Observable<[ActorVO]>
    
    func getMovieDetails(movieId : Int) -> Observable<MovieVO>
    
    func getCredits(movieId : Int) -> Observable<([ActorVO],[ActorVO])>
    
}
