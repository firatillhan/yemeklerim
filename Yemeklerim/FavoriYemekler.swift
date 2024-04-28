//
//  FavoriYemekler.swift
//  Yemeklerim
//
//  Created by Fırat İlhan on 24.04.2024.
//

import Foundation

class FavoriYemekler:Codable {
   
    var favoriYemekId:String?
    var yemek:Yemekler?
   
    init() {
        
    }
    
    init (favoriYemekId:String,yemek:Yemekler){
        self.favoriYemekId = favoriYemekId
        self.yemek = yemek
   
        
    }
}
