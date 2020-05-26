//
//  LoginViewController.swift
//  EVolunteers
//
//  Created by Dedy Yuristiawan on 25/05/20.
//  Copyright © 2020 Dedy Yuristiawan. All rights reserved.
//

import UIKit
import Combine
import CloudKit

class LoginViewController: UIViewController {
    
    var users = [CK_User]()
    let privateDatabase = CKContainer.default().privateCloudDatabase
    let publicDatabase = CKContainer.default().publicCloudDatabase
    let sharedDatabase = CKContainer.default().sharedCloudDatabase
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.save()
//        self.get()
//        self.getAll()
//        self.update()
//        self.delete()
//        self.deleteAll()
    }
    
    func save(){
        CK_User(name: "fafa2").save(result: { (users) in
            print("users : \(users?.name ?? "")")
        }) { (error) in
            
        }
    }
    
    func get(){
        let predicate = NSPredicate(format: "%K == %@", argumentArray: ["name", "fafa"])
        CK_User.query(predicate: predicate, result: { (users) in
            if let users = users {
                self.users = users
                print(users.count)
            }
        }) { (error) in
            print(error)
        }
    }
    
    func getAll(){
        let sortCreation = NSSortDescriptor(key: "creationDate", ascending: false)
        CK_User.all(inDatabase: CKContainer.default().publicCloudDatabase, withSortDescriptors : [sortCreation], result: { (users) in
            if let users = users {
                self.users = users
                print(users.count)
            }
        }) { (error) in
            print(error)
        }
    }
    
    func update(){
        let predicate = NSPredicate(format: "%K == %@", argumentArray: ["name", "fafa"])
        CK_User(name: "fofo").update(predicate: predicate, result: { (users) in
            if let users = users {
                
            }
        }) { (error) in
            print("error update")
        }
    }
    
    func delete(){
        let predicate = NSPredicate(format: "%K == %@", argumentArray: ["name", "fafa2"])
        CK_User.delete(predicate: predicate) {
            print("deleted record")
        }
    }
    
    func deleteAll(){
        CK_User.deleteAll {
            print("deleted all records")
        }
    }
}
