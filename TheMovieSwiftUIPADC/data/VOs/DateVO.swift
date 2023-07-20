//
//  DateVO.swift
//  TheMovieSwiftUIPADC
//
//  Created by Wai Yan Moe on 15/07/2023.
//

import Foundation

struct DateVO : Codable {
    let maximum : String?
    let minimum : String?
    
    enum CodingKeys: String, CodingKey {
        case maximum
        case minimum
    }
}
