//
//  UserActivitiesLog.swift
//  EVolunteers
//
//  Created by Dedy Yuristiawan on 27/05/20.
//  Copyright © 2020 Dedy Yuristiawan. All rights reserved.
//

import CloudKit

class UserActivitiesLog: CloudKitProtocol, Identifiable, Equatable {
    
    public var record: CKRecord?
    var id: CKRecord.ID?
    var deskripsi: String?
    var programId : CKRecord.Reference?
    var relatedUserEmail : CKRecord.Reference?
    var isActiveActive : Bool?
    
    static var RecordType = "UserActivitiesLog"
    
    public required init(ckRecord: CKRecord) {
        self.deskripsi = ckRecord["deskripsi"]
        self.programId = ckRecord["programId"]
        self.isActiveActive = ckRecord["isActiveActive"]
        self.relatedUserEmail = ckRecord["relatedUserEmail"]
        self.record = ckRecord
        self.id = ckRecord.recordID
    }
    
    init(deskripsi: String, programId: CKRecord.Reference, relatedUserEmail: CKRecord.Reference, isActiveActive: Bool){
        self.deskripsi = deskripsi
        self.programId = programId
        self.relatedUserEmail = relatedUserEmail
        self.isActiveActive = isActiveActive
        
        if record == nil {
            record = CKRecord(recordType: Self.recordType)
        }
        record?["deskripsi"] = deskripsi
        record?["programId"] = programId
        record?["relatedUserEmail"] = relatedUserEmail
        record?["isActiveActive"] = isActiveActive
        
        if let record = self.record {
            self.id = record.recordID
        }
    }
    
    static func == (lhs: UserActivitiesLog, rhs: UserActivitiesLog) -> Bool {
        return lhs.id == rhs.id
    }

}
