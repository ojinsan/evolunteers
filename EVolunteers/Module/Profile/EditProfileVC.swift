//
//  EditProfileVC.swift
//  EVolunteers
//
//  Created by derry on 26/05/20.
//  Copyright © 2020 Dedy Yuristiawan. All rights reserved.
//

import UIKit
import CloudKit

class EditProfileVC: UIViewController, UITextFieldDelegate {
    
    var usersRecord: CKRecord?
    
    let privateDatabase = CKContainer.default().publicCloudDatabase
    
    
    @IBOutlet weak var editNama: UITextField!
    @IBOutlet weak var editTempatLahir: UITextField!
    @IBOutlet weak var editTanggalLahir: UITextField!
    @IBOutlet weak var editJabatan: UITextField!
    @IBOutlet weak var editHandphone: UITextField!
    
    @IBOutlet weak var saveChanges: UIButton!
    
    //    var tempNama: String = ""
    //    var tempJabatan: String = ""
    //    var tempTempatLahir: String = ""
    //    var tempNoHandphone: String = ""
    
    var email = PreferenceManager.instance.userEmail
    var nama = PreferenceManager.instance.userName
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveChanges.layer.borderWidth = 1
        saveChanges.layer.cornerRadius = 10
        saveChanges.layer.borderColor = UIColor.init(hex: 0x000000).cgColor
        
        //MARK: HIDE KEYBOARD WHEN TAPPING ON SCREEN
        let tapOnScreen: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        tapOnScreen.cancelsTouchesInView = false
        view.addGestureRecognizer(tapOnScreen)
        
        editNama.text = nama
        editTempatLahir.text = email
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func submitChanges(_ sender: UIButton) {
        
        usersRecord = CKRecord(recordType: "Members")
        
        let predicate = NSPredicate(format: "email == %@", email!)
        Members.query(predicate: predicate, result: { (users) in
            if let users = users {
//                self.users = users
                print(users.count)
            }
        }) { (error) in
            print(error)
        }
        
        //        let predicate = NSPredicate(value: true)
        //
        //        usersRecord = CKRecord(recordType: "Members")
        //
        //        let query = CKQuery(recordType: "Members", predicate: predicate)
        //        query.sortDescriptors = [NSSortDescriptor(key: "modificationDate", ascending: false)]
        //
        //        let operation = CKQueryOperation(query: query)
        //
        ////        titles.removeAll()
        ////        recordIDs.removeAll()
        //
        //        operation.recordFetchedBlock = { record in
        //
        ////            titles.append(record["title"]!)
        ////            recordIDs.append(record.recordID)
        //
        //        }
        //
        //        operation.queryCompletionBlock = { cursor, error in
        //
        //            DispatchQueue.main.async {
        //
        //                let name = record.value(forKeyPath: "Name") as! String
        ////                print("Titles: \(titles)")
        ////                print("RecordIDs: \(recordIDs)")
        //
        //            }
        //
        //        }
        
//        privateDatabase.add(operation)
        
        
//        let editNama = self.editNama.text! as NSString
//        let editJabatan = self.editJabatan.text! as NSString
//        let editTempatLahir = self.editTempatLahir.text! as NSString
//        let editHandphone = self.editHandphone.text! as NSString
//
//        usersRecord = CKRecord(recordType: "Members")
//
//        //Record
//        usersRecord?.setObject(editNama, forKey: "namaLengkap")
//        usersRecord?.setObject(editJabatan, forKey: "jabatan")
//        usersRecord?.setObject(editTempatLahir, forKey: "tempatLahir")
//        usersRecord?.setObject(editHandphone, forKey: "handphone")
        
    }
}
