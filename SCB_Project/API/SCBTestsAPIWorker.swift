//
//  SCBTestsAPIWorker.swift
//  SCB
//
//  Created by Dev on 7/12/2561 BE.
//  Copyright © 2561 Chiabro. All rights reserved.
//

import Moya
import Result

public enum SCBTestsSubmitCodeError: Swift.Error {
    case webService
}

protocol SCBTestsWorkerProtocol: class {
    func getSCBTestHomeData(completion: @escaping (Result<[SCBTestModel], APIError>) -> Void)
    func getSCBObjectData(id: Int, completion: @escaping (Result<[SCBObjectArticle], APIError>) -> Void)
}

public class SCBTestsAPIWorker: SCBTestsWorkerProtocol {
    let SCBTestAPI = MoyaProvider<SCBTestsAPIService>()
    public static var shared = SCBTestsAPIWorker(provider: MoyaProvider<SCBTestsAPIService>())
    var provider: MoyaProvider<SCBTestsAPIService>
    
    public init(provider: MoyaProvider<SCBTestsAPIService>? = nil) {
        if let providerValue = provider {
            self.provider = providerValue
        } else {
            self.provider = MoyaProvider<SCBTestsAPIService>()
        }
    }
    
    
    func getSCBTestHomeData(completion: @escaping (Result<[SCBTestModel], APIError>) -> Void) {
        SCBTestAPI.request(.getSCBTestHome()) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                if statusCode == 200 {
                    do {
                        let SCBTestModelOutput = try JSONDecoder().decode([SCBTestModel].self, from: response.data)
                        completion(.success(SCBTestModelOutput))
                    } catch {
                        print("Error decode")
                        completion(.failure(.apiError))
                    }
                } else {
                    completion(.failure(.apiError))
                }
            case .failure:
                completion(.failure(.apiError))
            }
            
        }
    }
    
    func getSCBObjectData(id: Int, completion: @escaping (Result<[SCBObjectArticle], APIError>) -> Void) {
        SCBTestAPI.request(.getSCBObjectData(id: id)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                if statusCode == 200 {
                    do {
                        let SCBObjectDataOutput = try JSONDecoder().decode([SCBObjectArticle].self,
                                                                           from:response.data)
                        completion(.success(SCBObjectDataOutput))
                    } catch {
                        print("Error decode")
                        completion(.failure(.apiError))
                    }
                } else {
                    completion(.failure(.apiError))
                }
            case .failure:
                completion(.failure(.apiError))
            }
        }
    }
}
