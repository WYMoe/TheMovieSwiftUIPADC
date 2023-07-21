//
//  MovieDao.swift
//  TheMovieSwiftUIPADC
//
//  Created by Wai Yan Moe on 21/07/2023.
//

import Foundation
import CoreData

class MovieDao {
    //singleton
    static let shared = MovieDao()
    private init(){
        
    }
    
    //persistence context
    let managedContext = PersistenceController.shared.container.viewContext
    
    
    //save movies
    
    func saveMovies(movies: [MovieVO], for type: String){
        movies.forEach { movie in
            movie.createManagedObject(managedObjectContext: managedContext, for: type)
        }
        
        do {
            try managedContext.save()
        } catch {
            let error = error as NSError
            fatalError("Error saving movies: \(error) \(error.userInfo)")
        }
        
    }
    
    
    // get movies by type
    func getMoviesByType( type : String ) -> [MovieVOEntity] {
        let typePredicate = NSPredicate(format: "type == %@", type)
        let fetchRequest = MovieVOEntity.fetchRequest()
        fetchRequest.predicate = typePredicate
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            return results
        }catch {
            let error = error as NSError
            fatalError("Unresolved error: \(error) \(error.userInfo)")
        }
    }
    
    //get all movies
    func getAllMovies() -> [MovieVOEntity] {
        let allMoviesFetchRequest = MovieVOEntity.fetchRequest()
        do {
            let results = try managedContext.fetch(allMoviesFetchRequest)
            return results
        } catch {
            let error = error as NSError
            fatalError("Error saving movies: \(error) \(error.userInfo)")
        }
    }
    
    //get movie by id
    func getMovieById(movieId : Int) -> MovieVO {
        let idPredicate = NSPredicate(format: "id == %@", NSNumber(value: movieId))
        
        let fetchRequest = MovieVOEntity.fetchRequest()
        fetchRequest.predicate = idPredicate
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            return results.first?.convertToMovieVO() ?? MovieVO()
        }catch {
            let error = error as NSError
            fatalError("Error saving movies: \(error) \(error.userInfo)")
        }
    }
}
