//
//  SCBObjectArticleViewController.swift
//  SCB_Project
//
//  Created by Dev on 5/14/19.
//  Copyright © 2019 Dev. All rights reserved.
//

import UIKit
import JGProgressHUD
class SCBObjectArticleViewController: UIViewController {

    @IBOutlet weak var lbDetail: UILabel!
    @IBOutlet weak var rightImage: UIImageView!
    @IBOutlet weak var leftImage: UIImageView!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var pictureView: UIView!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var lbRating: UILabel!
    @IBOutlet weak var vTopBanner: UIView!
    var articleId : Int = 0
    var SCBTestModel: SCBTestModel? 
    var SCBAPIWorker = SCBTestsAPIWorker()
    var progressView = JGProgressHUD(style: .dark)
    let myGroup = DispatchGroup()
  
    fileprivate func displayData() {
        myGroup.enter()
        progressView.show(in: self.view, animated: true)
        //// Do your task
        SCBAPIWorker.getSCBObjectData(id: articleId, completion: {
            (result) in
            switch result {
            case .success(let data) :
                if let mUrl = URL(string: data[0].url) {
                    let url = mUrl
                    let data = try? Data(contentsOf: url)
                    self.rightImage.image = UIImage(data: data!)
                }
                
                self.myGroup.leave() //// When your task completes
            case .failure(_) :
                self.progressView.dismiss()
                break
            }
        })
        myGroup.notify(queue: DispatchQueue.main) {
            self.lbDetail.text = self.SCBTestModel?.description
            self.lbPrice.text = "\(self.SCBTestModel?.price ?? 0)"
            self.lbRating.text = "\(self.SCBTestModel?.rating ?? 0)"
            if let mUrl = URL(string: self.SCBTestModel?.thumbImageURL ?? "" ) {
                let url = mUrl
                let data = try? Data(contentsOf: url)
                self.leftImage.image = UIImage(data: data!)
            }
            self.progressView.dismiss()
            ////// do your remaining work
        }
        
      
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = SCBTestModel?.name
        displayData()
    }
    



}
