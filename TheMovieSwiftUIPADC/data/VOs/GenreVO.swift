//
//  GenreVO.swift
//  TheMovieSwiftUIPADC
//
//  Created by Wai Yan Moe on 20/04/2023.
//

import Foundation
import RealmSwift



struct GenreVO : Codable {
     var id : Int?
     var name : String?
    
    var isSelected : Bool = false
    
    enum CodingKeys: CodingKey {
        case id
        case name
      
    }
    
    
    func toGenreObj() -> GenreObject {
     
        let genre = GenreObject()
        
        genre.id = id
        genre.name = name
        genre.isSelected = isSelected
        
        return genre
    }
    
//    override init() {
//        super.init()
//    }
//
//
//    init(id: Int? = nil, name: String? = nil, isSelected: Bool = false) {
//        super.init()
//        self.id = id
//        self.name = name
//        self.isSelected = isSelected
//    }
//    enum CodingKeys : String, CodingKey {
//        case id
//        case name
//    }
    

    

}
