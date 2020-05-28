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

    let publicDatabase = CKContainer.default().publicCloudDatabase
    
    @IBOutlet weak var editNama: UITextField!
    @IBOutlet weak var editMobilePhone: UITextField!
    @IBOutlet weak var editJabatan: UITextField!
    @IBOutlet weak var editPendidikan: UITextField!
    @IBOutlet weak var editAlamat: UITextField!
    
    @IBOutlet weak var saveChanges: UIButton!
    
    let email = PreferenceManager.instance.userEmail
    let nama = PreferenceManager.instance.userName
    
    
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
        
        get()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func submitChanges(_ sender: UIButton) {
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
    
    func get() {
        let predicate = NSPredicate(format: "%K == %@", argumentArray: ["email", email])
        let query = CKQuery(recordType: "Members", predicate: predicate)
        
        publicDatabase.perform(query, inZoneWith: nil, completionHandler: ({results, error in
            if (error != nil) {
                DispatchQueue.main.async {
                    print("Cloud Error")
                }
            } else {
                if results!.count > 0 {
                    DispatchQueue.main.async {
                        for entry in results! {
                            
                            let alamat = entry["alamat"] as? String
                            if alamat != nil {
                                self.editAlamat.text = alamat
                            }
                            
                            let jabatan = entry["jabatan"] as? String
                            if jabatan != nil {
                                self.editJabatan.text = jabatan
                            }
                            
                            let pendidikan = entry["pendidikan"] as? String
                            if pendidikan != nil {
                                self.editPendidikan.text = pendidikan
                            }
                            
                            let phone = entry["mobilePhone"] as? String
                            if phone != nil {
                                self.editMobilePhone.text = phone
                            }
                        }
                    }
                }
            }
        }))
    }
}
