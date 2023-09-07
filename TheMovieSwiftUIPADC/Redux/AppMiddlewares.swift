//
//  AppMiddlewares.swift
//  TheMovieSwiftUIPADC
//
//  Created by Wai Yan Moe on 07/09/2023.
//

import Foundation
import RxSwift


//type alias for middleware
typealias Middleware = (inout AppState, AppAction, @escaping (AppAction) -> Void) -> Void

let disposeBag = DisposeBag()

// same actions from middle must not be triggered again after asynchronous calls
func createAsyncMiddleWare() -> Middleware {
    return { state, action, dispatchToReducer in
        switch(action){
            
        case .getnowPlayingMovies:
            MovieModelImpl.shared.getNowPlayingMovies(page: 1, onSuccess: { _ in}, onFailure: { error in })
            
        case .startObservingNowPlayingMovies:
            MovieModelImpl.shared.getNowPlayingMoviesFromDatabaseObservable()
                .observe(on: MainScheduler.instance)
                .subscribe(onNext: { nowPlayingMovies in
                    dispatchToReducer(.onNowPlayingMoviesLoaded(nowPlayingMovies: nowPlayingMovies))
                })
                .disposed(by: disposeBag)
            
        case .getPopularMovies:
            MovieModelImpl.shared.getPopularMovies(page: 1, onSuccess: {_ in}, onFailure: { error in })
        case .startObservingPopularMovies:
            MovieModelImpl.shared.getPopularMoviesFromDatabaseObservable()
                .observe(on: MainScheduler.instance)
                .subscribe(onNext: { popularMovies in
                    dispatchToReducer(.onPopularMoviesLoaded(popularMovies: popularMovies))
                })
                .disposed(by: disposeBag)
       
        case .getTopRatedMovies:
            MovieModelImpl.shared.getTopRatedMovies(page: 1, onSuccess: { _ in }, onFailure: { error in })
        case .startObservingTopRatedMovies:
            MovieModelImpl.shared.getTopRatedMoviesFromDatabaseObservable()
                .observe(on: MainScheduler.instance)
                .subscribe(onNext: { topRatedMovies in
                    dispatchToReducer(.onTopRatedMoviesLoaded(topRatedMovies: topRatedMovies))
                })
                .disposed(by: disposeBag)
        
        case .getGenres:
            MovieModelImpl.shared.getGenres { genres  in
                //select first item
                let genresWIthFirstItemSelected = genres.selectGenreAndReturnArray(withId: genres.first?.id ?? 0)
                dispatchToReducer(.onGenresLoaded(genres: genresWIthFirstItemSelected))
                getMovieByGenre(genreId: genres.first?.id ?? 0, dispatchToReducer: dispatchToReducer)
            } onFailure: { error in
            
            }

        
        case .getMoviesByGenre(genreId: let genreId):
            getMovieByGenre(genreId: genreId, dispatchToReducer: dispatchToReducer)
       
        case .getActors:
            MovieModelImpl.shared.getActors { actors in
                dispatchToReducer(.onActorsLoaded(actors: actors))
            } onFailure: { error in
                
            }

        
        case .getMovieDetails(movieId: let movieId):
            MovieModelImpl.shared.getMovieDetails(movieId: movieId) { movieDetails in
                dispatchToReducer(.onMovieDetailsLoaded(movieDetail: movieDetails))
            } onFailure: { error in
                
            }

        
        case .getCreditsByMovie(movieId: let movieId):
            MovieModelImpl.shared.getCredits(movieId: movieId) { cast, crew in
                dispatchToReducer(.onCastLoaded(cast: cast))
                dispatchToReducer(.onCrewLoaded(crew: crew))
            } onFailure: { error in
                
            }
            
      
            
            
        default:
            break

        
        }
    }
    
   
}

fileprivate func getMovieByGenre(genreId : Int, dispatchToReducer : @escaping (AppAction) -> Void){
    //GetMovie
    MovieModelImpl.shared.getMoviesByGenre(genreId: genreId) { moviesByGenre in
        dispatchToReducer(.onMoviesByGenreLoaded(moviesByGenres: moviesByGenre))
    } onFailure: { error in
        
    }

    
}
