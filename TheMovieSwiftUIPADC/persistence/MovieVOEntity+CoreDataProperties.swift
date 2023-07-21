//
//  MovieVOEntity+CoreDataProperties.swift
//  
//
//  Created by Wai Yan Moe on 21/07/2023.
//
//

import Foundation
import CoreData


extension MovieVOEntity {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieVOEntity> {
        return NSFetchRequest<MovieVOEntity>(entityName: "MovieVOEntity")
    }
    
    @NSManaged public var adult: Bool
    @NSManaged public var backdropPath: String?
    @NSManaged public var belongsToCollection: String?
    @NSManaged public var budget: Int32
    @NSManaged public var genres: String?
    @NSManaged public var homepage: String?
    @NSManaged public var id: Int32
    @NSManaged public var imdbID: String?
    @NSManaged public var originalLanguage: String?
    @NSManaged public var originalTitle: String?
    @NSManaged public var overview: String?
    @NSManaged public var popularity: Double
    @NSManaged public var posterPath: String?
    @NSManaged public var productionCompanies: String?
    @NSManaged public var productionCountires: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var revenue: Int32
    @NSManaged public var runtime: Int32
    @NSManaged public var spokenLanguages: String?
    @NSManaged public var status: String?
    @NSManaged public var tagline: String?
    @NSManaged public var title: String?
    @NSManaged public var type: String?
    @NSManaged public var video: Bool
    @NSManaged public var voteAverage: Double
    @NSManaged public var voteCount: Int32
    
    func convertToMovieVO() -> MovieVO {
        do {
            let decoder = JSONDecoder()
            
            var movieVO = MovieVO()
            
            movieVO.adult = self.adult
            movieVO.backdropPath = self.backdropPath
            movieVO.budget = Int(self.budget)
            movieVO.homepage =  self.homepage
            movieVO.id = Int(self.id)
            movieVO.imdbID = self.imdbID
            movieVO.originalTitle = self.originalTitle
            movieVO.overview = self.overview
            movieVO.popularity = self.popularity
            movieVO.posterPath = self.posterPath
            movieVO.releaseDate = self.releaseDate
            movieVO.revenue = Int(self.revenue)
            movieVO.runtime = Int(self.runtime)
            movieVO.status = self.status
            movieVO.tagline = self.tagline
            movieVO.video = self.video
            movieVO.voteAverage = self.voteAverage
            movieVO.voteCount = Int(self.voteCount)
            movieVO.type = self.type
            
            if belongsToCollection != nil {
                movieVO.belongsToCollection = try decoder.decode(BelongsToCollectionVO.self, from: self.belongsToCollection?.data(using: .utf8) ?? Data())
            }
            
            if productionCompanies != nil {
                movieVO.productionCompanies = try decoder.decode([ProductionCompanyVO].self, from: self.productionCompanies?.data(using: .utf8) ?? Data())
            }
            
            if productionCountires != nil {
                movieVO.productionCountries = try decoder.decode([ProductionCountryVO].self, from: self.productionCountires?.data(using: .utf8) ?? Data())
            }
            
            if spokenLanguages != nil {
                movieVO.spokenLanguages = try decoder.decode([SpokenLanguageVO].self, from: self.spokenLanguages?.data(using: .utf8) ?? Data())
            }
            
            if genres != nil {
                movieVO.genres = try decoder.decode([GenreVO].self, from: self.genres?.data(using: .utf8) ?? Data())
            }
            
            return movieVO
        } catch {
            let error = error as NSError
            fatalError("Unresolved Error : \(error) \(error.userInfo)")
        }
        
    }
    
   
}

//movie types
let MOVIE_TYPE_NOW_PLAYING = "Now Playing"
let MOVIE_TYPE_POPULAR = "Popular"
let MOVIE_TYPE_TOP_RATED = "Top Rated"
