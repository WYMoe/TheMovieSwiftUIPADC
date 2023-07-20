//
//  ActorListResponse.swift
//  TheMovieSwiftUIPADC
//
//  Created by Wai Yan Moe on 15/07/2023.
//

import Foundation

struct ActorListResponse : Codable {
    
    var page : Int?
    var results : [ActorVO]?
     
    enum CodingKeys: String, CodingKey {
        case page
        case results
    }
}
