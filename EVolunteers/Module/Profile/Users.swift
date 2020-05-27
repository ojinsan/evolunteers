//
//  User.swift
//  EVolunteers
//
//  Created by Dedy Yuristiawan on 25/05/20.
//  Copyright © 2020 Dedy Yuristiawan. All rights reserved.
//

import CloudKit

class Users: CloudKitProtocol, Identifiable, Equatable {
    
    public var record: CKRecord?
    var id: CKRecord.ID?
    var namaLengkap: String?
    var pendidikan: String?
    var jabatan: String?
    var email: String?
    var alamat: String?
    
    static var RecordType = "Users"
    
    public required init(ckRecord: CKRecord) {
        self.namaLengkap = ckRecord["namaLengkap"]
        self.pendidikan = ckRecord["pendidikan"]
        self.jabatan = ckRecord["jabatan"]
        self.email = ckRecord["email"]
        self.alamat = ckRecord["alamat"]
        self.record = ckRecord
        self.id = ckRecord.recordID
    }
    
    init(namaLengkap: String, pendidikan: String, jabatan: String, email: String, alamat: String){
        self.namaLengkap = namaLengkap
        self.pendidikan = pendidikan
        self.jabatan = jabatan
        self.email = email
        self.alamat = alamat
        
        if record == nil {
            record = CKRecord(recordType: Self.recordType)
        }
        
        record?["namaLengkap"] = namaLengkap
        record?["pendidikan"] = pendidikan
        record?["jabatan"] = jabatan
        record?["email"] = email
        record?["alamat"] = alamat
        
        if let record = self.record {
            self.id = record.recordID
        }
    }
    
    static func == (lhs: Users, rhs: Users) -> Bool {
        return lhs.id == rhs.id
    }

}
