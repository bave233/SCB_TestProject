//
//  SCBTestHomeModels.swift
//  SCB
//
//  Created by Dev on 10/1/2562 BE.
//  Copyright (c) 2562 Chiabro. All rights reserved.
//

import UIKit
import Result

enum SCBTestHome {
    // MARK: Use cases
    
    enum GetSCBTestHome {
        struct Request {}
        struct Response {
            var result: Result<[SCBTestModel], APIError>
        }
        struct ViewModel {
            var result: Result<[SCBTestModel], APIError>
        }
    }
}
