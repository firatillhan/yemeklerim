//
//  Yemekler.swift
//  Yemeklerim
//
//  Created by Fırat İlhan on 24.04.2024.
//

import Foundation


class Yemekler:Codable{
    
    
    var yemekAd:String?
    var yemekKisiSayisi:String?
    var yemekAciklama:String?
    var yemekHazirlikSuresi:String?
    var yemekTarif:String?
    var yemekResim:String?
    var yemekPisirmeSuresi:String?
    var yemekMalzemeler:String?
    var kategori:String?
   
    var kullaniciEmail:String?

    

    init(){
        
    }
    init(yemekAd:String,yemekKisiSayisi:String,yemekAciklama:String,yemekHazirlikSuresi:String,yemekTarif:String,yemekResim:String,yemekPisirmeSuresi:String,yemekMalzemeler:String,kategori:String,kullaniciEmail:String) {
       
        self.yemekAd = yemekAd
        self.yemekKisiSayisi = yemekKisiSayisi
        self.yemekAciklama = yemekAciklama
        self.yemekHazirlikSuresi = yemekHazirlikSuresi
        self.yemekTarif = yemekTarif
        self.yemekResim = yemekResim
        self.yemekPisirmeSuresi = yemekPisirmeSuresi
        self.yemekMalzemeler = yemekMalzemeler
        self.kategori = kategori
        self.kullaniciEmail = kullaniciEmail
    }
}
