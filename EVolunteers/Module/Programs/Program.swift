//
//  Programs.swift
//  EVolunteers
//
//  Created by Dicky Geraldi on 26/05/20.
//  Copyright ©️ 2020 Dedy Yuristiawan. All rights reserved.
//

import Foundation
import CloudKit
import Combine
import UIKit

class Programs: CloudKitProtocol, Identifiable, Equatable {
    
    public var record: CKRecord?
    var id: CKRecord.ID?
    var name: String?
    var judulProgram: String?
    var penyelenggara: String?
    var kebutuhan: [String]? = []
    var kriteria: String?
    var kategori: [String]? = []
    var lokasi: String?
    var deskripsi: String?
    var startDate: NSDate?
    var endDate:NSDate?
    var image: UIImage?
    
    static var RecordType = "Programs"
    
    
    //from icloud
    public required init(ckRecord: CKRecord) {
        //self.name = ckRecord["name"]
        // Configure Record
        self.judulProgram = ckRecord["judulProgram"]
        self.penyelenggara = ckRecord["namaKomunitas"]
        self.kebutuhan = ckRecord["kebutuhanPekerjaan"] as? [String]
        self.kriteria = ckRecord["kriteria"]
        self.kategori = ckRecord["programCategory"] as? [String]
        self.lokasi = ckRecord["lokasi"]
        self.deskripsi = ckRecord["deskripsi"]
        //rekaman?.setObject(programCreator, forKey: "programCreator")
        
        self.startDate = ckRecord["startDate"] as? NSDate
        self.endDate = ckRecord["endDate"] as? NSDate
        self.image = loadCoverPhoto(photos: ckRecord["photo"] as? CKAsset)
        self.record = ckRecord
        self.id = ckRecord.recordID
    }
    
    func loadCoverPhoto(photos: CKAsset?) -> UIImage {
        var image: UIImage?
        // 2.
        guard
            let coverPhoto = photos,
          let fileURL = coverPhoto.fileURL
          else {
            return image ?? UIImage(named: "Rectangle")!
        }
        let imageData: Data
        do {
          // 3.
          imageData = try Data(contentsOf: fileURL)
        } catch {
          return image ?? UIImage(named: "Rectangle")!
        }
        // 4.
        image = UIImage(data: imageData)
        
        return image ?? UIImage(named: "Rectangle")!
    }
    
    //to icloud
    init(judulProgram: String, penyelenggara:String, kebutuhan:[String],kriteria:String, kategori:[String],lokasi:String, deskripsi:String, startDate: NSDate, endDate:NSDate,url:URL){
        self.judulProgram = judulProgram
        self.penyelenggara = penyelenggara
        self.kebutuhan = kebutuhan
        self.kriteria = kriteria
        self.kategori = kategori
        self.lokasi = lokasi
        self.deskripsi = deskripsi
        //rekaman?.setObject(programCreator, forKey: "programCreator")
        self.startDate = startDate
        self.endDate = endDate
        
        if record == nil {
            record = CKRecord(recordType: Self.recordType)
        }
        
        record?["photo"] = CKAsset(fileURL: url)
        record?["judulProgram"] = judulProgram
        record?["penyelenggara"] = penyelenggara
        record?["kebutuhan"] = kebutuhan
        record?["kriteria"] = kriteria
        record?["kategori"] = kategori
        record?["lokasi"] = lokasi
        record?["deskripsi"] = deskripsi
        //rekaman?.setObject(programCreator, forKey: "programCreator")
        record?["startDate"] = startDate
        record?["endDate"] = endDate
        
        
        
        if let record = self.record {
            self.id = record.recordID
        }
    }
    
    static func == (lhs: Programs, rhs: Programs) -> Bool {
        return lhs.id == rhs.id
    }
}
