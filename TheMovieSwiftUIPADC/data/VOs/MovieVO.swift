//
//  MovieVO.swift
//  TheMovieSwiftUIPADC
//
//  Created by Wai Yan Moe on 13/07/2023.
//

import Foundation
import CoreData

struct MovieVO : Hashable,Codable,Identifiable{
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
    var type : String?
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


extension MovieVO {
    func createManagedObject(managedObjectContext: NSManagedObjectContext, for type : String) -> MovieVOEntity {
        let encoder = JSONEncoder()
        do {
            let movieEntity = MovieVOEntity(context: managedObjectContext)
            movieEntity.adult = self.adult ?? false
            movieEntity.backdropPath = self.backdropPath ?? ""
            movieEntity.budget = Int32(self.budget ?? 0)
            
            //belongsToCollection
            if belongsToCollection != nil {
                let belongsToCollection : Data = try encoder.encode(belongsToCollection)
                movieEntity.belongsToCollection = String(data:belongsToCollection, encoding: .utf8)
            }
            
            //genres
            if genres != nil {
                let genres : Data = try encoder.encode(genres)
                movieEntity.genres = String(data:genres, encoding: .utf8)
            }
            
            movieEntity.homepage = self.homepage ?? ""
            movieEntity.id = Int32(self.id ?? 0)
            movieEntity.imdbID = self.imdbID ?? ""
            movieEntity.originalLanguage = self.originalLanguage ?? ""
            movieEntity.originalTitle = self.originalTitle ?? ""
            movieEntity.overview = self.overview ?? ""
            movieEntity.popularity = self.popularity ?? 0.0
            movieEntity.posterPath = self.posterPath ?? ""
            
            //productionCompanies
            if productionCompanies != nil {
                let productionCompanies : Data = try encoder.encode(productionCompanies)
                movieEntity.productionCompanies = String(data:productionCompanies, encoding: .utf8)
            }
            
            //productionCountries
            if productionCountries != nil {
                let productionCountries : Data = try encoder.encode(productionCountries)
                movieEntity.productionCountires = String(data:productionCountries, encoding: .utf8)
            }
            
            movieEntity.releaseDate = self.releaseDate ?? ""
            movieEntity.revenue = Int32(self.revenue ?? 0)
            movieEntity.runtime = Int32(self.runtime ?? 0)
            
            //spoken languages
            if spokenLanguages != nil {
                let spokenLanguages : Data = try encoder.encode(spokenLanguages)
                movieEntity.spokenLanguages = String(data:spokenLanguages, encoding: .utf8)
            }
            
            movieEntity.status = self.status ?? ""
            movieEntity.tagline = self.tagline ?? ""
            movieEntity.title = self.title ?? ""
            movieEntity.video = self.video ?? false
            movieEntity.voteAverage = self.voteAverage ?? 0.0
            movieEntity.voteCount = Int32(self.voteCount ?? 0)
            movieEntity.type = type
            
            return movieEntity
            
        }catch {
            let error = error as NSError
            fatalError("Unresolved Error : \(error) \(error.userInfo)")
        }
    }
}
