//
//  FavoriYemekler.swift
//  Yemeklerim
//
//  Created by Fırat İlhan on 24.04.2024.
//

import Foundation

class FavoriYemekler:Codable {
    var favoriYemekId:String?
    var yemekId:String?
    var users:String?
    init() {
        
    }
    init (favoriYemekId:String,yemekId:String,users:String){
        self.favoriYemekId = favoriYemekId
        self.yemekId = yemekId
        self.users = users
        
    }
}
