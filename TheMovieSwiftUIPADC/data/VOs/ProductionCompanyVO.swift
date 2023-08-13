//
//  ProductionCompanyVO.swift
//  TheMovieSwiftUIPADC
//
//  Created by Wai Yan Moe on 15/07/2023.
//

import Foundation

struct ProductionCompanyVO : Codable {
     var id : Int?
     var loginPath : String?
     var name : String?
     var originCountry : String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case loginPath = "login_path"
        case originCountry = "origin_country"
    }
    
    
    func toProductionCompanyObj() -> ProductionCompanyObject{
        
    let obj = ProductionCompanyObject()
        obj.id = id
        obj.loginPath = loginPath
        obj.name = name
        obj.originCountry = originCountry
        return obj
    }

}
