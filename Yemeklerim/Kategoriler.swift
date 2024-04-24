//
//  Kategoriler.swift
//  Yemeklerim
//
//  Created by Fırat İlhan on 24.04.2024.
//

import Foundation


class Kategoriler:Codable {
    var kategoriId:String?
        var kategoriAd:String?
        init() {
            
        }
        init(kategoriId:String,kategoriAd:String){
            self.kategoriId = kategoriId
            self.kategoriAd = kategoriAd
        }
}
