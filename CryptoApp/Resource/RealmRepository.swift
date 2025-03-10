//
//  RealmManager.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/9/25.
//

import Foundation
import RealmSwift

struct RealmEntity {
    var bool: Bool
    var message: String
    
    enum RealmType {
        case add
        case delete
        case error
        
        var description: String {
            switch self {
            case .add:
                "즐겨찾기되었습니다."
            case .delete:
                "즐겨찾기에서 제거되었습니다"
            case .error:
                "실패! 잠시후 다시 시도해 보세요"
            }
        }
    }
}

final class CoinData: Object {
    @Persisted(primaryKey: true)
    var id: String
    
    convenience init(id: String) {
        self.init()
        self.id = id
    }
}

protocol RealmRepositoryType {
    func addItem(_ id: String) -> RealmEntity.RealmType
    func deleteItem(_ id: String) -> RealmEntity.RealmType
    func getState(_ id: String) -> Bool
}

final class RealmRepository: RealmRepositoryType {
    private var realm = try! Realm()
    
    func addItem(_ id: String) -> RealmEntity.RealmType {
        do {
            try realm.write {
                let object = CoinData(id: id)
                realm.create(CoinData.self, value: object, update: .modified)
            }
            return .add
        } catch {
            return .error
        }
    }
    
    func deleteItem(_ id: String) -> RealmEntity.RealmType {
        do {
            try realm.write {
                if let data = realm.object(ofType: CoinData.self, forPrimaryKey: id) {
                    realm.delete(data)
                }
            }
            return .delete
        } catch {
            return .error
        }
    }
    
    func getState(_ id: String) -> Bool {
        if let _ = realm.object(ofType: CoinData.self, forPrimaryKey: id) {
            return true
        } else {
            return false
        }
    }
    
}
