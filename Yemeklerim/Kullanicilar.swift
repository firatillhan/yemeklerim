//
//  Kullanicilar.swift
//  Yemeklerim
//
//  Created by Fırat İlhan on 24.04.2024.
//

import Foundation


class Kullanicilar:Codable {
    var kullaniciAd:String?
    var sifre:String?
    var email:String?
    
    init() {
        
    }
    init(kullaniciAd:String,sifre:String,email:String){
        self.kullaniciAd = kullaniciAd
        self.sifre = sifre
        self.email = email
    }
}
