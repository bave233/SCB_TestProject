//
//  SCBTestModel.swift
//  CollectionViewListTest
//
//  Created by Dev on 10/1/2562 BE.
//  Copyright © 2562 Dev. All rights reserved.
//

import Foundation

class SCBTestModel: Decodable {
    var id: Int?
    var name: String?
    var brand: String?
    var price: Float?
    var rating : Float?
    var thumbImageURL : String?
    var description : String?
    var scbObject : SCBObjectArticle?
    var hasFav : Bool?
    init() {
        id = 0
        scbObject = nil
        name = nil
        brand = nil
        price = nil
        rating = nil
        thumbImageURL = nil
        description = nil
        hasFav = false
    }
}

struct likeStruct {
    var hasFav : Bool
}




class likedSCBTestModel: SCBTestModel {
    var likeid: Int?
    var likename: String?
    var likebrand: String?
    var likeprice: Float?
    var likerating : Float?
    var likethumbImageURL : String?
    var likedescription : String?
    var likeFlag : Bool?
    
    override init() {
        super.init()
        self.likeid = id
        self.likename = name
        self.likebrand = brand
        self.likeprice = price
        self.likerating = rating
        self.likethumbImageURL = thumbImageURL
        self.likedescription = description
    }
    

    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}
