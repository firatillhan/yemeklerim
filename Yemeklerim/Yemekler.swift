//
//  Yemekler.swift
//  Yemeklerim
//
//  Created by Fırat İlhan on 24.04.2024.
//

import Foundation


class Yemekler:Codable{
    
    var yemekId:String?
    var yemekAd:String?
    var yemekKisiSayisi:String?
    var yemekAciklama:String?
    var yemekHazirlikSuresi:String?
    var yemekTarif:String?
    var yemekResim:String?
    var yemekPisirmeSuresi:String?
    var yemekMalzemeler:String?
    var kullaniciUid:String?
    var kullaniciEmail:String?
    
    var kategori:String?
  

    

    init(){
        
    }
    init(yemekId:String,yemekAd:String,yemekKisiSayisi:String,yemekAciklama:String,yemekHazirlikSuresi:String,yemekTarif:String,yemekResim:String,yemekPisirmeSuresi:String,yemekMalzemeler:String,kategori:String,kullaniciUid:String,kullaniciEmail:String) {
       
        self.yemekId = yemekId
        self.yemekAd = yemekAd
        self.yemekKisiSayisi = yemekKisiSayisi
        self.yemekAciklama = yemekAciklama
        self.yemekHazirlikSuresi = yemekHazirlikSuresi
        self.yemekTarif = yemekTarif
        self.yemekResim = yemekResim
        self.yemekPisirmeSuresi = yemekPisirmeSuresi
        self.yemekMalzemeler = yemekMalzemeler
        self.kategori = kategori
        self.kullaniciUid = kullaniciUid
        self.kullaniciEmail = kullaniciEmail
    }
}
