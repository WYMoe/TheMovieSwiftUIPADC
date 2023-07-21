//
//  MovieVO.swift
//  TheMovieSwiftUIPADC
//
//  Created by Wai Yan Moe on 13/07/2023.
//

import Foundation
import RealmSwift

@objcMembers
class MovieVO : Object,Identifiable,Codable {
   
  
 
    
    
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
    
    
    enum CodingKeys: String,CodingKey{
        case adult
        case backdropPath = "backdrop_path"
        case belongsToCollection = "belongs_to_collection"
        case budget
        case genres
        case homepage
        case id
        case imdbID = "imdb_id"
        case originalLanguage
        case originalTitle
        case overview
        case popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue
        case runtime
        case spokenLanguages = "spoken_languages"
        case status
        case tagline
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    func getBackdropPathTogetherWithBaseUrl() -> String {
        return "\(BASE_IMAGE_URL)\(backdropPath ?? "")"
    }
    
    func getPosterPathTogetherWithBaseUrl() -> String {
        return "\(BASE_IMAGE_URL)\(posterPath ?? "")"
    }
    func getGenresAsCommaSeparatedString() -> String {
        return genres.map({ genre in
            genre.name ?? ""
        }).joined(separator: ",")
    }
    func getProductionCountryAsCommaSeparatedString() -> String {
        return productionCountries.map({ productionCountry in
            productionCountry.name ?? ""
        }).joined(separator: ",")
    }
  
    //realm
    func getGenresArray()-> [GenreVO] {
        return Array(genres)
    }
    
    
    // custom euqtable
    static func == (lhs: MovieVO, rhs: MovieVO) -> Bool {
        return (lhs.id == rhs.id) && (lhs.overview == rhs.overview)
    }
    
    
    
}

let MOVIE_TYPE_NOW_PLAYING = "Now Playing"
let MOVIE_TYPE_POPULAR = "Popular"
let MOVIE_TYPE_TOP_RATED = "Top Rated"
