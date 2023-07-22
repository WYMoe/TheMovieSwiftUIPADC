//
//  MovieObject.swift
//  TheMovieSwiftUIPADC
//
//  Created by Wai Yan Moe on 22/07/2023.
//

import Foundation
import RealmSwift

@objcMembers
class MovieObject : Object {
   
  
 
    
    
   @Persisted dynamic var adult : Bool?
   @Persisted dynamic var backdropPath : String?
   @Persisted dynamic var belongsToCollection: BelongsToCollectionVO?
   @Persisted dynamic var budget : Int?
   let genres  = List<GenreVO>()
   @Persisted dynamic var homepage : String?
   @Persisted(primaryKey: true) dynamic var id : Int?
   @Persisted dynamic var imdbID : String?
   @Persisted dynamic var originalLanguage : String?
   @Persisted dynamic var originalTitle: String?
   @Persisted dynamic var overview: String?
   @Persisted dynamic var popularity: Double?
   @Persisted dynamic var posterPath: String?
   let productionCompanies = List<ProductionCompanyVO>()
   let productionCountries = List<ProductionCountryVO>()
   @Persisted dynamic var releaseDate : String?
   @Persisted dynamic var revenue: Int?
   @Persisted dynamic var runtime: Int?
   let spokenLanguages = List<SpokenLanguageVO>()
   @Persisted dynamic var status : String?
   @Persisted dynamic var tagline: String?
   @Persisted dynamic var title : String?
   @Persisted dynamic var video: Bool?
   @Persisted dynamic var voteAverage: Double?
   @Persisted dynamic var voteCount: Int?
   @Persisted dynamic var type : String?
    
    
    
 
  
    //realm
    func getGenresArray()-> [GenreVO] {
        return Array(genres)
    }
    
    
    // custom euqtable
    static func == (lhs: MovieObject, rhs: MovieObject) -> Bool {
        return (lhs.id == rhs.id) && (lhs.overview == rhs.overview)
    }
    
    
    
}

