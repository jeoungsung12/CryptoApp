//
//  RealmManager.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/9/25.
//

import Foundation
import RealmSwift

final class CoinData: Object {
    @Persisted(primaryKey: true)
    var id: String
    
    convenience init(id: String) {
        self.init()
        self.id = id
    }
}

protocol RealmRepositoryType {
    func addItem(_ id: String) -> Bool
    func deleteItem(_ id: String) -> Bool
    func getState(_ id: String) -> Bool
}

final class RealmRepository: RealmRepositoryType {
    private var realm = try! Realm()
    
    func addItem(_ id: String) -> Bool {
        do {
            try realm.write {
                let object = CoinData(id: id)
                realm.add(object)
            }
            return true
        } catch {
            print("즐겨찾기 등록 실패!")
            return false
        }
    }
    
    func deleteItem(_ id: String) -> Bool {
        do {
            try realm.write {
                if let data = realm.object(ofType: CoinData.self, forPrimaryKey: id) {
                    realm.delete(data)
                }
            }
            return true
        } catch {
            print("즐겨찾기 삭제 실패!")
            return false
        }
    }
    
    func getState(_ id: String) -> Bool {
        if let data = realm.object(ofType: CoinData.self, forPrimaryKey: id) {
            return true
        } else {
            return false
        }
    }
    
}
