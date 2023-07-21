//
//  ProductionCompanyVO.swift
//  TheMovieSwiftUIPADC
//
//  Created by Wai Yan Moe on 15/07/2023.
//

import Foundation
import RealmSwift

@objcMembers
class ProductionCompanyVO : Object,Codable {
    @Persisted(primaryKey: true) dynamic var id : Int?
    @Persisted dynamic var loginPath : String?
    @Persisted dynamic var name : String?
    @Persisted dynamic var originCountry : String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case loginPath = "login_path"
        case originCountry = "origin_country"
    }
}
