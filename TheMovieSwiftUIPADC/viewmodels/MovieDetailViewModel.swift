//
//  MovieDetailViewModel.swift
//  TheMovieSwiftUIPADC
//
//  Created by Wai Yan Moe on 06/09/2023.
//

import Foundation

class MovieDetailViewModel : ObservableObject {
    
    var movieId : Int?
    
    //state
    @Published var mMovieVO : MovieVO?
    @Published var mCasts : [ActorVO]?
    @Published var mCrews : [ActorVO]?
    
    // model
    let mMovieModel : MovieModel = MovieModelImpl.shared
    
    
    init(movieId : Int?){
        self.movieId = movieId
        requestData()
    }
    
    func requestData() {
        if let movieId = movieId {
            
            //database
            self.mMovieVO = mMovieModel.getMovieByIdFromDatabase(id: movieId)
          
            //detail
            mMovieModel.getMovieDetails(movieId: movieId) { movieDetailVO in
                self.mMovieVO = movieDetailVO
              
            } onFailure: { error in
                
            }
            
            //credit
            mMovieModel.getCredits(movieId: movieId) { casts, crews in
                self.mCasts = casts
                self.mCrews = crews
            } onFailure: { error in
                
            }

        }
    }
}
