//
//  SpokenLanguageVO.swift
//  TheMovieSwiftUIPADC
//
//  Created by Wai Yan Moe on 15/07/2023.
//

import Foundation

struct SpokenLanguageVO : Codable {
    
    var englishName : String?
    var iso_639_1 : String?
    var name : String?
    
    enum CodingKeys : String,CodingKey {
        case englishName = "english_name"
        case iso_639_1
        case name
    }
}
