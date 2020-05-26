//
//  User.swift
//  EVolunteers
//
//  Created by Dedy Yuristiawan on 25/05/20.
//  Copyright © 2020 Dedy Yuristiawan. All rights reserved.
//

import CloudKit

class CK_User: CloudKitProtocol, Identifiable, Equatable {
    
    public var record: CKRecord?
    var id: CKRecord.ID?
    var name: String?
    
    static var RecordType = "CK_User"
    
    public required init(ckRecord: CKRecord) {
        self.name = ckRecord["name"]
        self.record = ckRecord
        self.id = ckRecord.recordID
    }
    
    init(name: String){
        self.name = name
        
        if record == nil {
            record = CKRecord(recordType: Self.recordType)
        }
        record?["name"] = name
        
        if let record = self.record {
            self.id = record.recordID
        }
    }
    
    static func == (lhs: CK_User, rhs: CK_User) -> Bool {
        return lhs.id == rhs.id
    }

}
