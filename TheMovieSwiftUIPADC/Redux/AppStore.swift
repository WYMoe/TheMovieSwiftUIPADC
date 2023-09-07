//
//  AppStore.swift
//  TheMovieSwiftUIPADC
//
//  Created by Wai Yan Moe on 07/09/2023.
//

import Foundation

final class AppStore : ObservableObject {
    @Published var state : AppState = AppState()
    
    private let middleWares : [Middleware] = [createAsyncMiddleWare()]
    
    //dispatch goes here
    func dispatchAction(action : AppAction) {
        
        //grigger middlewares first
        middleWares.forEach { middleWare in
            middleWare(&state, action, dispatchAction)
        }
        
        //reducer
        dispatch(state: &state, action: action)
    }
}
