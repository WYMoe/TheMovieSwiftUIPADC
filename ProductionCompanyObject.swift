//
//  ProductionCompanyObject.swift
//  TheMovieSwiftUIPADC
//
//  Created by Wai Yan Moe on 13/08/2023.
//

import Foundation
import RealmSwift

class ProductionCompanyObject : Object {
    
    @Persisted(primaryKey: true)
    var id : Int?
    
    @Persisted
    var loginPath : String?
    
    @Persisted
    var name : String?
    
    @Persisted
    var originCountry : String?
    
    func toProductionCompanyVO() -> ProductionCompanyVO {
        return ProductionCompanyVO(id: id,loginPath: loginPath,name: name,originCountry: originCountry)
    }
}
