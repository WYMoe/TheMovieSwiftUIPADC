//
//  BelongsToCollectionVO.swift
//  TheMovieSwiftUIPADC
//
//  Created by Wai Yan Moe on 15/07/2023.
//

import Foundation

struct BelongsToCollectionVO : Codable {
    
    var id : Int?
    var name : String?
    var posterPath : String?
    var backdropPath : String?
    
    enum CodingKeys: String, CodingKey{
        case id
        case name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}
