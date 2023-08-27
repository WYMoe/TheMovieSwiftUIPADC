//
//  SearchViewModel.swift
//  TheMovieSwiftUIPADC
//
//  Created by Wai Yan Moe on 27/08/2023.
//

import Foundation
import Combine

class SearchViewModel : ObservableObject {
    //state
    @Published var query : String = ""
    @Published var results : [MovieVO] = []
    
    //cancellable == disposebag
    
    var cancellable : AnyCancellable?
    
    //Model
    let mMovieModel = MovieModelImpl.shared
    
    init() {
        cancellable = $query
            //get latest event in 700 milisecond
            .debounce(for: .milliseconds(700), scheduler: DispatchQueue.main)
            .sink(receiveValue: { [weak self] text in
                print(text)
                self?.searchMovie(query: text)
                print(self?.results ?? [])
            })
    }
    
    
    private func searchMovie(query : String) {
        mMovieModel.searchMovie(query: query) { [weak self] results in
            self?.results = results
            
            print(results)
        } onFailure: { error in
            
        }

    }
}
