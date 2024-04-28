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
    var kullaniciFoto:String?
    var kullaniciAciklama:String?
    var kullaniciSifre:String?
    var kullaniciEmail:String?
    
    init() {
        
    }
    init(kullaniciId:String,kullaniciAd:String,kullaniciAdSoyad:String,kullaniciFoto:String,kullaniciAciklama:String,kullaniciSifre:String,kullaniciEmail:String){
        self.kullaniciId = kullaniciId
        self.kullaniciAd = kullaniciAd
        self.kullaniciAdSoyad = kullaniciAdSoyad
        self.kullaniciFoto = kullaniciFoto
        self.kullaniciAciklama = kullaniciAciklama
        self.kullaniciSifre = kullaniciSifre
        self.kullaniciEmail = kullaniciEmail
    }
}
