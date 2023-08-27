//
//  MovieModelImpl.swift
//  TheMovieSwiftUIPADC
//
//  Created by Wai Yan Moe on 16/07/2023.
//

import Foundation
import RxSwift
struct MovieModelImpl : MovieModel {
   
    
    
    static let shared = MovieModelImpl()
    
    private init(){
        
    }
    
    //data agent
    let mDataAgent : MovieDataAgent = MovieDataAgentImpl.shared
    
    //dao
    let mMovieDao = MovieDAO.shared
    
    var disposeBag = DisposeBag()
    
    
    func getNowPlayingMovies(page: Int, onSuccess: @escaping ([MovieVO]) -> Void, onFailure: @escaping (Error) -> Void) {
        mDataAgent.getNowPlayingMovies(page: page)
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .observe(on: MainScheduler.instance)
            .subscribe(onNext : {
                nowPlayingMovies in
                    onSuccess(nowPlayingMovies)
                
                    //save to db
                    self.mMovieDao.saveMovies(movies: nowPlayingMovies, for: MOVIE_TYPE_NOW_PLAYING)
            }, onError: {
                error in
                onFailure(error)
            })
            .disposed(by: disposeBag)
    }
    
    func getPopularMovies(page: Int, onSuccess: @escaping ([MovieVO]) -> Void, onFailure: @escaping (Error) -> Void) {
        mDataAgent.getPopularMovies(page: page)
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {
                popularMovies in
                onSuccess(popularMovies)
                //save to db
                self.mMovieDao.saveMovies(movies: popularMovies, for: MOVIE_TYPE_POPULAR)
            }, onError: {
                 error in
                onFailure(error)
            })
            .disposed(by: disposeBag)
    }
    
    func getTopRatedMovies(page: Int, onSuccess: @escaping ([MovieVO]) -> Void, onFailure: @escaping (Error) -> Void) {
        mDataAgent.getTopRatedMovies(page: page)
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .observe(on: MainScheduler.instance)
            .subscribe(onNext : {
                topratedMovies in
                onSuccess(topratedMovies)
                //save to db
                self.mMovieDao.saveMovies(movies: topratedMovies, for: MOVIE_TYPE_TOP_RATED)
            }, onError: {
                error in
                onFailure(error)
            }).disposed(by: disposeBag)
    }
    
    func getGenres(onSuccess: @escaping ([GenreVO]) -> Void, onFailure: @escaping (Error) -> Void) {
        mDataAgent.getGenres()
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .observe(on: MainScheduler.instance)
            .subscribe(onNext : {
                genres in
                onSuccess(genres)
                
            }, onError: {
                error in
                onFailure(error)
            }).disposed(by: disposeBag)
        
    }
    
    func getMoviesByGenre(genreId: Int?, onSuccess: @escaping ([MovieVO]) -> Void, onFailure: @escaping (Error) -> Void) {
     
        
        mDataAgent.getMoviesByGenre(genreId: genreId)
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .observe(on: MainScheduler.instance)
            .subscribe(onNext : {
                moviesByGenres in
                onSuccess(moviesByGenres)
                
            }, onError: {
                error in
                onFailure(error)
            }).disposed(by: disposeBag)
            
    }
    
    func getActors(onSuccess: @escaping ([ActorVO]) -> Void, onFailure: @escaping (Error) -> Void) {
        mDataAgent.getActors()
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .observe(on: MainScheduler.instance)
            .subscribe(onNext : {
                actors in
                onSuccess(actors)
                
            }, onError: {
                error in
                onFailure(error)
            }).disposed(by: disposeBag)
    }
    
    func getMovieDetails(movieId: Int, onSuccess: @escaping (MovieVO) -> Void, onFailure: @escaping (Error) -> Void) {
      
        
        mDataAgent.getMovieDetails(movieId: movieId)
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .observe(on: MainScheduler.instance)
            .subscribe(onNext : {
                movieDetails in
                onSuccess(movieDetails)
                
            }, onError: {
                error in
                onFailure(error)
            }).disposed(by: disposeBag)
    }
    
    func getCredits(movieId: Int, onSuccess: @escaping ([ActorVO], [ActorVO]) -> Void, onFailure: @escaping (Error) -> Void) {
      //  mDataAgent.getCredits(movieId: movieId, onSuccess: onSuccess, onFailure: onFailure)
        
        mDataAgent.getCredits(movieId: movieId)
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .observe(on: MainScheduler.instance)
            .subscribe(onNext : {
                (actor,crew) in
                onSuccess(actor,crew)
                
            }, onError: {
                error in
                onFailure(error)
            }).disposed(by: disposeBag)
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
