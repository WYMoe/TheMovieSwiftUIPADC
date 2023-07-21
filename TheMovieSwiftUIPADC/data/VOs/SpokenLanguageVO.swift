//
//  SpokenLanguageVO.swift
//  TheMovieSwiftUIPADC
//
//  Created by Wai Yan Moe on 15/07/2023.
//

import Foundation
import RealmSwift

@objcMembers
class SpokenLanguageVO : Object,Codable {
    
    @Persisted dynamic var englishName : String?
    @Persisted(primaryKey: true) dynamic var iso_639_1 : String?
    @Persisted dynamic var name : String?
    
    enum CodingKeys : String,CodingKey {
        case englishName = "english_name"
        case iso_639_1
        case name
    }
}
