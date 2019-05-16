//
//  SCBTestHomeRouter.swift
//  SCB
//
//  Created by Dev on 10/1/2562 BE.
//  Copyright (c) 2562 Chiabro. All rights reserved.
//

import UIKit

protocol SCBTestHomeRoutingLogic {

    func navigateToSCBObjectDetail()
    func routeToViewController(segue: UIStoryboardSegue?, for sender: Any?)

}

protocol SCBTestHomeDataPassing
{
    var dataStore: SCBTestHomeDataStore? { get set }
}

class SCBTestHomeRouter: NSObject, SCBTestHomeRoutingLogic,  SCBTestHomeDataPassing {
    weak var viewController: SCBTestHomeViewController?
    var dataStore: SCBTestHomeDataStore?

    func routeToViewController(segue: UIStoryboardSegue?,for sender: Any?) {
        if let segue = segue {
                if segue.identifier == "SCBObjectArticle" {
                routeToSCBObjectDetail(segue: segue)
            }
        }
    }
    
  
    func navigateToSCBObjectDetail() {
        viewController?.performSegue(withIdentifier: "SCBObjectArticle", sender: nil)
    }
    
    @objc func routeToSCBObjectDetail(segue: UIStoryboardSegue) {
        //Data Passing
        guard let destination = segue.destination as? SCBObjectArticleViewController,
        let articleId  = dataStore?.SCBTestModel?.id else { return }
        destination.articleId = articleId
        destination.SCBTestModel = dataStore?.SCBTestModel
    }


}
