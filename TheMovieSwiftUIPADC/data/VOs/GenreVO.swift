//
//  GenreVO.swift
//  TheMovieSwiftUIPADC
//
//  Created by Wai Yan Moe on 20/04/2023.
//

import Foundation
import RealmSwift

@objcMembers

class GenreVO : Object,Codable {
    @Persisted dynamic var id : Int?
    @Persisted dynamic var name : String?
    
    var isSelected : Bool = false
    
    
    override init() {
        super.init()
    }
    
    
    init(id: Int? = nil, name: String? = nil, isSelected: Bool = false) {
        super.init()
        self.id = id
        self.name = name
        self.isSelected = isSelected
    }
    enum CodingKeys : String, CodingKey {
        case id
        case name
    }
    

    

}
