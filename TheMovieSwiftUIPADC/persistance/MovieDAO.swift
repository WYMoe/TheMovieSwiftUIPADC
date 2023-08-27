//
//  MovieDAO.swift
//  TheMovieSwiftUIPADC
//
//  Created by Wai Yan Moe on 21/07/2023.
//

import Foundation
import RealmSwift
import RxSwift
import RxRealm
class MovieDAO {
    //singleton
    
    static let shared = MovieDAO()
    
    private init(){
        
        do {
            let realmPath = try Realm().configuration.fileURL?.absoluteString ?? "undefined"
            print("Default Realm is at : \( realmPath )")
        } catch {
            
        }
     
    }
    
    
    
    //save movies
    
    func saveMovies(movies:[MovieVO],for type:String){
        do {
            let realm = try Realm()

         let movieObjs =   movies.map { movieVO in
            
             movieVO.toMovieObj(type: type)
            }
            
            try realm.write({
                
                realm.add(movieObjs,update: .all)
              //  print("save result : \(movieObjs)")
            })
        }catch {
            let error = error as NSError
            fatalError("Unresolved error : \(error) \(error.userInfo)")
        }
    }
    
    //save movie detail
    func saveMovieDetail(movie:MovieVO){
        do {
            let realm = try Realm()

         let movieObj = movie.toMovieDetailObj()
            
            
            try realm.write({
                
                realm.add(movieObj,update: .all)
               
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
            let results = realm.objects(MovieObject.self)
         
            return results.map { movieObj in
                movieObj.toMovieVO()
            }
        }catch {
            let error = error as NSError
            fatalError("Unresolved error : \(error) \(error.userInfo)")
        }
    }
    
    //get movies by type
    
    func getMoviesByType(type:String)->[MovieVO]{
        do{
            let realm = try Realm()
            let moviesByType = realm.objects(MovieObject.self).filter { movie in
                movie.type == type
            }
            return moviesByType.map { movieObj in
                movieObj.toMovieVO()
            }
            
        }catch {
            let error = error as NSError
            fatalError("Unresolved error : \(error) \(error.userInfo)")
        }
    }

    func getMoviesByTypeObservable(type:String) -> Observable<[MovieVO]>{
        do {
            let realm = try Realm()
            let moviesByType = realm.objects(MovieObject.self).filter("type == %@",type)
            return Observable.collection(from: moviesByType)
                .map { realmResults in
                    realmResults.toArray()
                }.map { moviesObjs in
                    moviesObjs.map { mObj in
                        mObj.toMovieVO()
                    }
                }
            
        }catch {
            let error = error as NSError
            fatalError("Unresolved error : \(error) \(error.userInfo)")
        }
    }
    
    //get movie by id
    
    func getMovieById(movieId:Int) -> MovieVO?{
        do{
            let realm = try Realm()
            let result = realm.object(ofType: MovieDetailObject.self, forPrimaryKey: movieId)
            //print("get result : \(result?.toMovieVO())")
            return result?.toMovieVO()
        }catch {
            let error = error as NSError
            fatalError("Unresolved error : \(error) \(error.userInfo)")
        }
    }
}
