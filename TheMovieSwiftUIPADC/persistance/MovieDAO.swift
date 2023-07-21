//
//  MovieDAO.swift
//  TheMovieSwiftUIPADC
//
//  Created by Wai Yan Moe on 21/07/2023.
//

import Foundation
import RealmSwift

class MovieDAO {
    //singleton
    
    static let shared = MovieDAO()
    
    private init(){
        
    }
    
    
    
    //save movies
    
    func saveMovies(movies:[MovieVO],for type:String){
        do {
            let realm = try Realm()
            movies.forEach { movie in
                movie.type = type
            }
            
            try realm.write({
                realm.add(movies,update: .all)
            })
        }catch {
            let error = error as NSError
            fatalError("Unresolved error : \(error) \(error.userInfo)")
        }
    }
    
    //get all movies
    
    func getAllMovies()->[MovieVO]{
        do{
            let realm = try Realm()
            return Array(realm.objects(MovieVO.self))
        }catch {
            let error = error as NSError
            fatalError("Unresolved error : \(error) \(error.userInfo)")
        }
    }
    
    //get movies by type
    
    func getMoviesByType(type:String)->[MovieVO]{
        do{
            let realm = try Realm()
            let moviesByType = realm.objects(MovieVO.self).filter { movie in
                movie.type == type
            }
            return Array(moviesByType)
        }catch {
            let error = error as NSError
            fatalError("Unresolved error : \(error) \(error.userInfo)")
        }
    }
    
    //get movie by id
    
    func getMovieById(movieId:Int) -> MovieVO?{
        do{
            let realm = try Realm()
            
            return realm.object(ofType: MovieVO.self, forPrimaryKey: movieId)
        }catch {
            let error = error as NSError
            fatalError("Unresolved error : \(error) \(error.userInfo)")
        }
    }
}
