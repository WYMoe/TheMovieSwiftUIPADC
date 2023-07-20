//
//  CreditsList.swift
//  TheMovieSwiftUIPADC
//
//  Created by Wai Yan Moe on 15/07/2023.
//

import Foundation

struct CreditsListResponse : Codable {
    var id : Int?
    var cast : [ActorVO]?
    var crew : [ActorVO]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case cast
        case crew
    }
}
