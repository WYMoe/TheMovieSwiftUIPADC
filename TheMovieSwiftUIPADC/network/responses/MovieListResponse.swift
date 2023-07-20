//
//  MovieListResponse.swift
//  TheMovieSwiftUIPADC
//
//  Created by Wai Yan Moe on 15/07/2023.
//

import Foundation

struct MovieListResponse : Codable {
    var dates : DateVO?
    var page : Int?
    var results : [MovieVO]?
    
    enum CodingKeys: String, CodingKey {
        case dates
        case page
        case results
    }
}
