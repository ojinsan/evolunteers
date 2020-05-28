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
    @IBOutlet weak var editMobilePhone: UITextField!
    @IBOutlet weak var editJabatan: UITextField!
    @IBOutlet weak var editPendidikan: UITextField!
    @IBOutlet weak var editAlamat: UITextField!
    
    @IBOutlet weak var saveChanges: UIButton!
    
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
                print(users)
                print(users.count)
            }
        }) { (error) in
            print(error)
        }
        
        let editNama = self.editNama.text! as String
        let editJabatan = self.editJabatan.text! as String
        let editMobilePhone = self.editMobilePhone.text! as String
        let editPendidikan = self.editPendidikan.text! as String
        let editAlamat = self.editAlamat.text! as String
        
        update(pendidikan: editPendidikan, jabatan: editJabatan, alamat: editAlamat, namaLengkap: editNama, mobilePhone: editMobilePhone)
    }
    
    func update(pendidikan: String, jabatan: String, alamat: String, namaLengkap: String, mobilePhone: String){
        let email = PreferenceManager.instance.userEmail ?? ""
        let predicate = NSPredicate(format: "%K == %@", argumentArray: ["email", email])
        Members.query(predicate: predicate, result: { (foundMembers) in
            if let foundMember = foundMembers?.first {
                foundMember.record?.setValue("\(alamat)", forKey: "alamat")
                foundMember.record?.setValue("\(jabatan)", forKey: "jabatan")
                foundMember.record?.setValue("\(pendidikan)", forKey: "pendidikan")
                foundMember.record?.setValue("\(namaLengkap)", forKey: "namaLengkap")
                foundMember.record?.setValue("\(mobilePhone)", forKey: "mobilePhone")
                foundMember.save(result: { (foundMembers) in
                    print("Success")
                }) { (error) in
                    print("error")
                }
                
            }
        }) { (error) in
            print(error)
        }
    }
}
