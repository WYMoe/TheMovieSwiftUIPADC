//
//  GenreListResponse.swift
//  TheMovieSwiftUIPADC
//
//  Created by Wai Yan Moe on 15/07/2023.
//

import Foundation

struct GenreListResponse : Codable {
    var genres : [GenreVO]?
    
    enum CodingKeys: String, CodingKey {
        case genres
    }
}
