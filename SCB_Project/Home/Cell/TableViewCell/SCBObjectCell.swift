//
//  SCBObjectCell.swift
//  CollectionViewListTest
//
//  Created by Dev on 9/1/2562 BE.
//  Copyright © 2562 Dev. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class SCBObjectCell: UITableViewCell {
    var bannerClick: (() -> Void)?
    var likeCLick : (() -> Void)?
    
    @IBOutlet weak var lbDescp: UILabel!
    @IBOutlet var SCBObjectButton: UIButton!
    @IBOutlet var SCBObjectImageView: UIImageView!
    @IBOutlet weak var detailView: UIView!
    
    @IBOutlet weak var pictureView: UIView!
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var lbRating: UILabel!
    
    @IBOutlet weak var likeButton: UIButton!
    
    override func awakeFromNib() {
    }
    
    @IBAction func likeButtonClick(_ sender: Any) {
        likeCLick?()
    }
    
    
    func bindData(SCBObject: SCBObjectArticle) {
    }
    
    @IBAction func SCBObjectClick() {
        bannerClick?()
    }
}
