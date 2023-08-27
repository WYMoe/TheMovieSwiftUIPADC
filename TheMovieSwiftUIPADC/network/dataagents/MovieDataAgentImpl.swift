//
//  MovieDataAgentImpl.swift
//  TheMovieSwiftUIPADC
//
//  Created by Wai Yan Moe on 15/07/2023.
//

import Foundation
import RxSwift
class MovieDataAgentImpl : MovieDataAgent {
  
    static let shared = MovieDataAgentImpl()
    
    private init(){
        
    }
    
    func getNowPlayingMovies(page: Int) ->  Observable<[MovieVO]> {
        let parameters : [String : Any] = [
            PARAM_API_KEY : API_KEY,
            PARAM_PAGE : page
        ]
        return fetchDataWithParametersObservable(forEndPoint: ENDPOINT_NOW_PLAYING, parameters: parameters)
            .map { (response : MovieListResponse) in
                return response.results	 ?? []
            }
        
    }
    
    func getPopularMovies(page: Int) -> Observable<[MovieVO]> {
        let parameters : [String : Any] = [
            PARAM_API_KEY : API_KEY,
            PARAM_PAGE : page
        ]
        
        return fetchDataWithParametersObservable(forEndPoint: ENDPOINT_GET_POPULAR, parameters: parameters)
            .map { (response:MovieListResponse) in
                return response.results ?? []
            }
        
        
    }
    
    func getTopRatedMovies(page: Int) -> Observable<[MovieVO]> {
        let parameters : [String : Any] = [
            PARAM_API_KEY : API_KEY,
            PARAM_PAGE : page
        ]
        return fetchDataWithParametersObservable(forEndPoint: ENDPOINT_GET_TOPRATED, parameters: parameters).map { (response : MovieListResponse) in
            return response.results ?? []
        }
    }
    
    func getGenres() -> Observable<[GenreVO]>   {
        let parameters : [String : Any] = [
            PARAM_API_KEY : API_KEY,
            
        ]
        return fetchDataWithParametersObservable(forEndPoint: ENDPOINT_GET_GENRES, parameters: parameters)
            .map { (response : GenreListResponse) in
                return response.genres ?? []
            }
    }
    
    func getMoviesByGenre(genreId: Int?) -> Observable<[MovieVO]> {
        let parameters : [String : Any] = [
            PARAM_API_KEY : API_KEY,
            PARAM_WITH_GENRES : genreId ?? 0
        ]
        
        return fetchDataWithParametersObservable(forEndPoint: ENDPOINT_GET_MOVIES_BY_GENRE, parameters: parameters).map { (response : MovieListResponse) in
            return response.results ?? []
        }
    }
    
    func getActors() -> Observable<[ActorVO]> {
        let parameters : [String : Any] = [
            PARAM_API_KEY : API_KEY
        ]
        
        return fetchDataWithParametersObservable(forEndPoint: ENDPOINT_GET_ACTORS, parameters: parameters)
            .map { (response : ActorListResponse) in
                return response.results ?? []
            }
        
    }
    
    func getMovieDetails(movieId: Int) -> Observable<MovieVO> {
        let parameters : [String : Any] = [
            PARAM_API_KEY : API_KEY
        ]
        
        return fetchDataWithParametersObservable(forEndPoint: "\(ENDPOINT_GET_MOVIE_DETAILS)/\(movieId)", parameters: parameters)
        
    }
    
    func getCredits(movieId: Int) -> Observable<([ActorVO],[ActorVO])> {
        let parameters : [String : Any] = [
            PARAM_API_KEY : API_KEY
        ]
        
        return fetchDataWithParametersObservable(forEndPoint: "\(ENDPOINT_GET_CREDITS_BY_MOVIE)/\(movieId)/credits", parameters: parameters)
            .map { (response : CreditsListResponse) in
                return (response.cast ?? [], response.crew ?? [])
            }
    }
    
}
