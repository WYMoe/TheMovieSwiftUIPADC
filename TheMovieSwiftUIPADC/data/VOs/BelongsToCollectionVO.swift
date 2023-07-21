//
//  BelongsToCollectionVO.swift
//  TheMovieSwiftUIPADC
//
//  Created by Wai Yan Moe on 15/07/2023.
//

import Foundation
import RealmSwift

@objcMembers
class BelongsToCollectionVO : Object, Codable {
    
    @Persisted(primaryKey: true) dynamic var id : Int?
    @Persisted dynamic var name : String?
    @Persisted dynamic var posterPath : String?
    @Persisted dynamic var backdropPath : String?
    
    enum CodingKeys: String, CodingKey{
        case id
        case name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}
