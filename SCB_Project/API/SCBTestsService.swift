//
//  SCBTestsAPIService.swift
//  SCB
//
//  Created by Dev on 7/12/2561 BE.
//  Copyright © 2561 Chiabro. All rights reserved.
//

import Moya
import Alamofire

public enum SCBTestsAPIService {
    case getSCBTestHome()
    case getSCBObjectData(id: Int)
}

extension SCBTestsAPIService: TargetType {
    public var baseURL: URL {
        return URL(string: "https://scb-test-mobile.herokuapp.com")!
    }
    
    public var path: String {
        switch self {
        case .getSCBTestHome:
            return "/api/mobiles/"
        case .getSCBObjectData(let id):
            return "/api/mobiles/\(id)/images/"
        }
    }
    public var method: Alamofire.HTTPMethod {
        switch self {
        case .getSCBTestHome, .getSCBObjectData:
            return Method.get
        }
    }
    
    public var parameters: [String: Any] {
        switch self {
        case .getSCBTestHome, .getSCBObjectData:
            return [:]
        }
    }
    
    public var sampleData: Data {
        switch self {
        case .getSCBTestHome, .getSCBObjectData:
            return """
[]
""".utf8Encoded
        }
    }
    
    public var task: Task {
        let encoding: ParameterEncoding = method == .get ? Alamofire.URLEncoding.default : Alamofire.JSONEncoding.default
        return Task.requestParameters(parameters: parameters, encoding: encoding)
    }
    
    public var headers: [String : String]? {
        return [
            "Content-Type" : "application/json"
        ]
    }
}

extension String {
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
