
//
//  SCBTestsHelper.swift
//  SCB
//
//  Created by Dev on 3/12/2561 BE.
//  Copyright © 2561 Chiabro. All rights reserved.
//

public enum APIError: Swift.Error, Equatable {
    case noData
    case noConnection
    case apiError
    case apiDataError(statusCode:Int, message:String)
    case otherError
    
    public static func ==(lhs: APIError, rhs: APIError) -> Bool {
        switch (lhs, rhs) {
        case (let .apiDataError(lhsCode, lhsMessage), let .apiDataError(rhsCode, rhsMessage)):
            return lhsCode == rhsCode && lhsMessage == rhsMessage
        case (.noData,.noData):
            return true
        case (.noConnection,.noConnection):
            return true
        case (.apiError,.apiError):
            return true
        case (.otherError,.otherError):
            return true
        default:
            return false
        }
    }
}


public struct APIHelper {
    static let shared = APIHelper()
}
