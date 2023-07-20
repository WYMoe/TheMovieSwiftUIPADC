//
//  MovieVO.swift
//  TheMovieSwiftUIPADC
//
//  Created by Wai Yan Moe on 13/07/2023.
//

import Foundation

struct MovieVO : Hashable,Codable {
    static func == (lhs: MovieVO, rhs: MovieVO) -> Bool {
        false //true -> error
    }
    
  
 
    
    
    var adult : Bool?
    var backdropPath : String?
    var belongsToCollection: BelongsToCollectionVO?
    var budget : Int?
    var genres : [GenreVO]?
    var homepage : String?
    var id : Int?
    var imdbID : String?
    var originalLanguage : String?
    var originalTitle: String?
    var overview: String?
    var popularity: Double?
    var posterPath: String?
    var productionCompanies : [ProductionCompanyVO]?
    var productionCountries : [ProductionCountryVO]?
    var releaseDate : String?
    var revenue: Int?
    var runtime: Int?
    var spokenLanguages: [SpokenLanguageVO]?
    var status : String?
    var tagline: String?
    var title : String?
    var video: Bool?
    var voteAverage: Double?
    var voteCount: Int?
    
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
        return genres?.map({ genre in
            genre.name ?? ""
        }).joined(separator: ",") ?? ""
    }
    func getProductionCountryAsCommaSeparatedString() -> String {
        return productionCountries?.map({ productionCountry in
            productionCountry.name ?? ""
        }).joined(separator: ",") ?? ""
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    
}
