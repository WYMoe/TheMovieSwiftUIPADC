//
//  BaseDataAgent.swift
//  TheMovieSwiftUIPADC
//
//  Created by Wai Yan Moe on 15/07/2023.
//

import Foundation
import Alamofire
import RxSwift
func fetchDataWithParameters<T: Codable>(forEndPoint endpoint: String, parameters : [String: Any]?, onSuccess: @escaping(T) -> Void, onError: @escaping (Error) -> Void) {
   
    
    AF.request("\(BASE_URL)\(endpoint)", parameters: parameters)
        .validate()
        .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let result):
                onSuccess(result)
            case .failure(let error):
                onError(error)
            }
        }
}


func fetchDataWithParametersObservable<T: Codable>(forEndPoint endpoint: String, parameters : [String: Any]?) -> Observable<T> {
   
    return Observable.create { observer in
        AF.request("\(BASE_URL)\(endpoint)", parameters: parameters)
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let result):
                    observer.onNext(result)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
        
        return  Disposables.create()
        
    }
 
}
