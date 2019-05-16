//
//  SCBTestHomePresenter.swift
//  SCB
//
//  Created by Dev on 10/1/2562 BE.
//  Copyright (c) 2562 Chiabro. All rights reserved.
//

import UIKit

protocol SCBTestHomePresentationLogic {
    func presentGetSCBTestHomeData(response: SCBTestHome.GetSCBTestHome.Response)
}

class SCBTestHomePresenter: SCBTestHomePresentationLogic {
    weak var viewController: SCBTestHomeDisplayLogic?
    
    func presentGetSCBTestHomeData(response: SCBTestHome.GetSCBTestHome.Response) {
        
        let viewModel = SCBTestHome.GetSCBTestHome.ViewModel(result: response.result)
        viewController?.displaySCBTestHomeData(viewModel: viewModel)
    }
}
