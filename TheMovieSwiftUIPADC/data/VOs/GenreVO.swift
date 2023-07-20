//
//  GenreVO.swift
//  TheMovieSwiftUIPADC
//
//  Created by Wai Yan Moe on 20/04/2023.
//

import Foundation

struct GenreVO : Codable {
    var id : Int?
    var name : String?
    
    var isSelected : Bool = false
    
    enum CodingKeys : String, CodingKey {
        case id
        case name
    }
    

    

}
