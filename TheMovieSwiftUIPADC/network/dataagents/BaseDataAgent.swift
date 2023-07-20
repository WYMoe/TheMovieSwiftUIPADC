//
//  BaseDataAgent.swift
//  TheMovieSwiftUIPADC
//
//  Created by Wai Yan Moe on 15/07/2023.
//

import Foundation
import Alamofire
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
