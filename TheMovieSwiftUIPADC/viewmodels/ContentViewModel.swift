//
//  ContentViewModel.swift
//  TheMovieSwiftUIPADC
//
//  Created by Wai Yan Moe on 06/09/2023.
//

import Foundation
import RxSwift

class ContentViewModel : ObservableObject {
    
    //data model
    let mMovieModel : MovieModel = MovieModelImpl.shared
    
    //state variables
    @Published var mNowPlayingMovies : [MovieVO]? = nil
    @Published var mPopularMovies : [MovieVO]? = nil
    @Published var mTopRatedMovies : [MovieVO]? = nil
    @Published var mGenres : [GenreVO]? = nil
    @Published var mMoviesByGenre : [MovieVO]? = nil
    @Published var mActors : [ActorVO]? = nil
    @Published var isPresented : Bool = false

   private let disposeBag = DisposeBag()
    
    
    init(){
        requestData()
    }
    
    func requestData() {
        
        //now playing movies
        mMovieModel.getNowPlayingMovies(page: 1) { _ in
            
        } onFailure: { error in
            
        }

        
        //popular movies
        mMovieModel.getPopularMovies(page: 1) { _ in
           
        } onFailure: { error in
        }
        
        //top rated movies
        mMovieModel.getTopRatedMovies(page: 1) { _ in
         
        } onFailure: { error in
            
        }
        
        //genres
        mMovieModel.getGenres { genres in
            self.mGenres = genres.enumerated().map({ index,genre in
             
                if index == 0 {
                   
                    return  GenreVO(id: genre.id, name: genre.name, isSelected: true)
                } else {
                    return genre
                }
                
                
            })
            self.getMoviesByGenre(genreId: self.mGenres?.first?.id ?? 0)
          
        } onFailure: { error in
           
        }
        
      
        
        //actors
        mMovieModel.getActors { actors in
            self.mActors = actors
        } onFailure: { error in
         //   print(error)
        }
        
        
        //get data from database
        mMovieModel.getNowPlayingMoviesFromDatabaseObservable()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {
                nowPlayingMovies in
                self.mNowPlayingMovies = nowPlayingMovies
            })
            .disposed(by: disposeBag)
        
        mMovieModel.getTopRatedMoviesFromDatabaseObservable()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {
                topRatedMovies in
                self.mTopRatedMovies = topRatedMovies
            })
            .disposed(by: disposeBag)
        
        mMovieModel.getPopularMoviesFromDatabaseObservable()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {
                popularMovies in
                self.mPopularMovies = popularMovies
            })
            .disposed(by: disposeBag)
        
        
    }
    
    func getMoviesByGenre(genreId:Int) {
        mMovieModel.getMoviesByGenre(genreId: genreId) { movies in
            self.mMoviesByGenre = movies
        
        } onFailure: { error in
            
        }

    }
    
    func onTapGenre(genreId : Int) {
        mGenres = mGenres?.map({ iteratedGenre in
            if genreId == iteratedGenre.id {
                return GenreVO(id: iteratedGenre.id,name: iteratedGenre.name,
                               isSelected:true)
            } else {
                return GenreVO(id:iteratedGenre.id,name: iteratedGenre.name,
                               isSelected:false)
            }
        })
        self.getMoviesByGenre(genreId: genreId)
        
    }
    
    func enableIsPresented() {
        self.isPresented = true
    }
}
