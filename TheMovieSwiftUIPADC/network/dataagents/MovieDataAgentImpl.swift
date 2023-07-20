//
//  MovieDataAgentImpl.swift
//  TheMovieSwiftUIPADC
//
//  Created by Wai Yan Moe on 15/07/2023.
//

import Foundation

class MovieDataAgentImpl : MovieDataAgent {
   
    
  
    
    
  
    
   
    
    
    static let shared = MovieDataAgentImpl()
    
    private init(){
        
    }
    
    func getNowPlayingMovies(page: Int, onSuccess: @escaping ([MovieVO]) -> Void, onFailure: @escaping (Error) -> Void) {
        let parameters : [String : Any] = [
            PARAM_API_KEY : API_KEY,
            PARAM_PAGE : page
        ]
        fetchDataWithParameters(forEndPoint: ENDPOINT_NOW_PLAYING, parameters: parameters) { (movieListResponse : MovieListResponse ) in
            onSuccess(movieListResponse.results ?? [])
        } onError: { error in
            onFailure(error)
            
        }

    }
    
    func getPopularMovies(page: Int, onSuccess: @escaping ([MovieVO]) -> Void, onFailure: @escaping (Error) -> Void) {
        let parameters : [String : Any] = [
            PARAM_API_KEY : API_KEY,
            PARAM_PAGE : page
        ]
        
        fetchDataWithParameters(forEndPoint: ENDPOINT_GET_POPULAR, parameters: parameters) { (movieListResponse : MovieListResponse ) in
            onSuccess(movieListResponse.results ?? [])
        } onError: { error in
            onFailure(error)
        }
    }
    
    func getTopRatedMovies(page: Int, onSuccess: @escaping ([MovieVO]) -> Void, onFailure: @escaping (Error) -> Void) {
        let parameters : [String : Any] = [
            PARAM_API_KEY : API_KEY,
            PARAM_PAGE : page
        ]
        fetchDataWithParameters(forEndPoint: ENDPOINT_GET_TOPRATED, parameters: parameters) { (movieListResponse : MovieListResponse ) in
            onSuccess(movieListResponse.results ?? [])
        } onError: { error in
            onFailure(error)
        }
    }
    
    func getGenres(onSuccess: @escaping ([GenreVO]) -> Void, onFailure: @escaping (Error) -> Void) {
        let parameters : [String : Any] = [
            PARAM_API_KEY : API_KEY,
            
        ]
        fetchDataWithParameters(forEndPoint: ENDPOINT_GET_GENRES, parameters: parameters) { (genres : GenreListResponse ) in
            onSuccess(genres.genres ?? [])
        } onError: { error in
            onFailure(error)
        }
    }
    
    func getMoviesByGenre(genreId: Int?, onSuccess: @escaping ([MovieVO]) -> Void, onFailure: @escaping (Error) -> Void) {
        let parameters : [String : Any] = [
            PARAM_API_KEY : API_KEY,
            PARAM_WITH_GENRES : genreId ?? 0
        ]
        
        fetchDataWithParameters(forEndPoint: ENDPOINT_GET_MOVIES_BY_GENRE, parameters: parameters) { (movieListResponse : MovieListResponse ) in
            onSuccess(movieListResponse.results ?? [])
        } onError: { error in
            onFailure(error)
        }
    }
    
    func getActors(onSuccess: @escaping ([ActorVO]) -> Void, onFailure: @escaping (Error) -> Void) {
        let parameters : [String : Any] = [
            PARAM_API_KEY : API_KEY
        ]
        fetchDataWithParameters(forEndPoint: ENDPOINT_GET_ACTORS, parameters: parameters) { (response : ActorListResponse) in
            onSuccess(response.results ?? [])
        } onError: { error in
            onFailure(error)
        }

    }
    
    func getMovieDetails(movieId: Int, onSuccess: @escaping (MovieVO) -> Void, onFailure: @escaping (Error) -> Void) {
        let parameters : [String : Any] = [
            PARAM_API_KEY : API_KEY
        ]
        
        fetchDataWithParameters(forEndPoint: "\(ENDPOINT_GET_MOVIE_DETAILS)/\(movieId)", parameters: parameters) { (response : MovieVO) in
            onSuccess(response)
        } onError: { error in
                onFailure(error)
            }
        }

    
    
    func getCredits(movieId: Int, onSuccess: @escaping ([ActorVO], [ActorVO]) -> Void, onFailure: @escaping (Error) -> Void) {
        let parameters : [String : Any] = [
            PARAM_API_KEY : API_KEY
        ]
        
        fetchDataWithParameters(forEndPoint: "\(ENDPOINT_GET_CREDITS_BY_MOVIE)/\(movieId)/credits", parameters: parameters) { (respons : CreditsListResponse) in
            onSuccess(respons.cast ?? [], respons.crew ?? [])
        } onError: { error in
            onFailure(error)
        }

    }
    
}

