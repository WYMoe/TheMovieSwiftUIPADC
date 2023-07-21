//
//  ProductionCountryVO.swift
//  TheMovieSwiftUIPADC
//
//  Created by Wai Yan Moe on 15/07/2023.
//

import Foundation
import RealmSwift

@objcMembers
class ProductionCountryVO : Object,Codable {
    @Persisted dynamic var iso_3166_1 :String?
    @Persisted(primaryKey: true) dynamic var name : String?
    
    enum CodingKeys: String, CodingKey {
        case iso_3166_1
        case name
    }
}
