//
//  NetworkManager.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/6/25.
//

import Foundation
import Alamofire

protocol NetworkManagerType {
    func getData()
}

final class NetworkManager: NetworkManagerType {
    static let shared = NetworkManager()
    
    private init() { }
    
    func getData() {
        
    }
    
}
