//
//  SCBTestHomeInteractor.swift
//  SCB
//
//  Created by Dev on 10/1/2562 BE.
//  Copyright (c) 2562 Chiabro. All rights reserved.
//

import UIKit

protocol SCBTestHomeBusinessLogic {
    func getSCBTestHomeData(request: SCBTestHome.GetSCBTestHome.Request)
    var SCBObject: SCBObjectArticle? { get set }
    var SCBTestModel : SCBTestModel? { get set }
}

protocol SCBTestHomeDataStore
{
    var SCBObject: SCBObjectArticle? { get set }
    var SCBTestModel : SCBTestModel? { get set }

}

class SCBTestHomeInteractor: SCBTestHomeBusinessLogic, SCBTestHomeDataStore {
    var presenter: SCBTestHomePresentationLogic?
    var scbTestsAPIWorker: SCBTestsAPIWorker?
    var SCBObject: SCBObjectArticle?
    var SCBTestModel : SCBTestModel?
    
    
    init(scbTestsAPIWorker: SCBTestsAPIWorker = SCBTestsAPIWorker()) {
        self.scbTestsAPIWorker = scbTestsAPIWorker
    }
    
 

    func getSCBTestHomeData(request: SCBTestHome.GetSCBTestHome.Request) {
        
        scbTestsAPIWorker?.getSCBTestHomeData(completion: { [weak self] result in
            switch result {
            case .success(let SCBTestModel):
                let response = SCBTestHome.GetSCBTestHome.Response(result: .success(SCBTestModel))
                self?.presenter?.presentGetSCBTestHomeData(response: response)
            case .failure(let error):
                let response = SCBTestHome.GetSCBTestHome.Response(result: .failure(error))
                self?.presenter?.presentGetSCBTestHomeData(response: response)
            }
        })
    }
    
}
