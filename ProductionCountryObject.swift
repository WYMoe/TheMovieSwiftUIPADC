//
//  ProductionCountryObject.swift
//  TheMovieSwiftUIPADC
//
//  Created by Wai Yan Moe on 13/08/2023.
//

import Foundation
import RealmSwift
class ProductionCountryObject : Object {
    
    @Persisted var iso_3166_1 : String?
    
    @Persisted var name: String?
    
    func toProductionCountyVO()->ProductionCountryVO{
        return ProductionCountryVO(iso_3166_1: iso_3166_1, name: name)
    }

}
