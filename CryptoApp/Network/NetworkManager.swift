//
//  NetworkManager.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/6/25.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() { }
    
    func getData<T:Decodable, U:Router>(_ api: U) -> Observable<T> {
        return Observable.create { observer in
            AF.request(api)
                .validate(statusCode: 200..<500)
                .responseDecodable(of: T.self) { response in
//                    print(response.debugDescription)
                    switch response.result {
                    case let .success(data):
                        observer.onNext(data)
                        observer.onCompleted()
                    case let .failure(error):
                        let customError = error.statusCodeToErrorType(response.response?.statusCode, api)
                        observer.onError(customError)
                    }
                }
            return Disposables.create()
        }
    }
    
}
