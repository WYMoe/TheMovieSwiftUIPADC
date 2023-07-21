//
//  Persistence.swift
//  TheMovieSwiftUIPADC
//
//  Created by Wai Yan Moe on 21/07/2023.
//

import Foundation
import CoreData

struct PersistenceController{
    static let shared = PersistenceController()
    
    let container : NSPersistentContainer
    
    private init() {
        container = NSPersistentContainer(name: "MovieApp")
        container.loadPersistentStores { _, error in
            if let error = error as? NSError{
                fatalError("Unresolved Error : \(error).\(error.userInfo)")
            }
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.name = "MovieApp"
        container.viewContext.mergePolicy = NSOverwriteMergePolicy
        container.viewContext.undoManager = nil
        container.viewContext.shouldDeleteInaccessibleFaults = false

    }
}
