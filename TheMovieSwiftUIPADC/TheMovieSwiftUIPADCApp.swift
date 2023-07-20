//
//  TheMovieSwiftUIPADCApp.swift
//  TheMovieSwiftUIPADC
//
//  Created by Wai Yan Moe on 18/04/2023.
//

import SwiftUI
import RealmSwift

@main
struct TheMovieSwiftUIPADCApp: SwiftUI.App {
    
    init() {
        let config = Realm.Configuration(deleteRealmIfMigrationNeeded:true)
        Realm.Configuration.defaultConfiguration = config
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
            //GenreTabLayoutView()
            //MovieDetailScreen()
        }
    }
}
