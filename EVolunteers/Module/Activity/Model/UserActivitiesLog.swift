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
    
    static var RecordType = "UserActivitiesLog"
    
    public required init(ckRecord: CKRecord) {
        self.deskripsi = ckRecord["deskripsi"]
        self.record = ckRecord
        self.id = ckRecord.recordID
    }
    
    init(deskripsi: String){
        self.deskripsi = deskripsi
        
        if record == nil {
            record = CKRecord(recordType: Self.recordType)
        }
        record?["deskripsi"] = deskripsi
        
        if let record = self.record {
            self.id = record.recordID
        }
    }
    
    static func == (lhs: UserActivitiesLog, rhs: UserActivitiesLog) -> Bool {
        return lhs.id == rhs.id
    }

}
