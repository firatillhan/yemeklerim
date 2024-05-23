//
//  Kullanicilar.swift
//  Yemeklerim
//
//  Created by Fırat İlhan on 24.04.2024.
//

import Foundation


class Kullanicilar:Codable {
    var kullaniciId:String?
    var kullaniciAd:String?
    var kullaniciAdSoyad:String?
    var kullaniciResim:String?
    var kullaniciAciklama:String?
    var kullaniciEmail:String?
    
    init() {
        
    }
    
    init(kullaniciId:String,kullaniciAd:String,kullaniciAdSoyad:String,kullaniciResim:String,kullaniciAciklama:String,kullaniciEmail:String){
        self.kullaniciId = kullaniciId
        self.kullaniciAd = kullaniciAd
        self.kullaniciAdSoyad = kullaniciAdSoyad
        self.kullaniciResim = kullaniciResim
        self.kullaniciAciklama = kullaniciAciklama
        self.kullaniciEmail = kullaniciEmail
    }
}
