//
//  Error + Extension.swift
//  CryptoApp
//
//  Created by 정성윤 on 3/9/25.
//

import Foundation

extension Error {
    func statusCodeToErrorType(_ statusCode: Int?,_ router: Router) -> Error {
        guard let statusCode = statusCode else { return RouterError.network }
        if let _ = router as? UpbitRouter {
            return UpbitError(rawValue: statusCode) ?? RouterError.network
        } else if let _ = router as? CoingeckoRouter {
            return CoingeckoError(rawValue: statusCode) ?? RouterError.network
        }
        return RouterError.network
    }
}
