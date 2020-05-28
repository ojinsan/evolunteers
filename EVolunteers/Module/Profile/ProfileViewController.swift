//
//  ProfileViewController.swift
//  EVolunteers
//
//  Created by Dedy Yuristiawan on 12/05/20.
//  Copyright © 2020 Dedy Yuristiawan. All rights reserved.
//

import UIKit
import CloudKit

class ProfileViewController: UIViewController {
    
    let publicDatabase = CKContainer.default().publicCloudDatabase
    
    @IBOutlet weak var daftarButton: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var userNama: UILabel!
    @IBOutlet weak var userLokasi: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userPhone: UILabel!
    @IBOutlet weak var userPendidikan: UILabel!
    @IBOutlet weak var userJabatan: UILabel!
    
    @IBOutlet weak var userPrograms: UILabel!
    
    let email = PreferenceManager.instance.userEmail ?? ""
    let nama = PreferenceManager.instance.userName ?? ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        daftarButton.layer.borderWidth = 1
        daftarButton.layer.borderColor = UIColor.init(hex: 0x000000).cgColor
        
        profileImage.layer.cornerRadius = 25
        profileImage.layer.borderWidth = 1
        profileImage.layer.borderColor = UIColor.init(hex: 0x000000).cgColor
        
        userEmail.text = email
        
        get()
        
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
                            let namaLengkap = entry["namaLengkap"] as? String
                            self.userNama.text = namaLengkap!
                            
                            let alamat = entry["alamat"] as? String
                            if alamat != nil {
                                self.userLokasi.text = alamat
                            }
                            
                            let jabatan = entry["jabatan"] as? String
                            if jabatan != nil {
                                self.userJabatan.text = jabatan
                            }
                            
                            let pendidikan = entry["pendidikan"] as? String
                            if pendidikan != nil {
                                self.userPendidikan.text = pendidikan
                            }
                            
                            let phone = entry["mobilePhone"] as? String
                            if phone != nil {
                                self.userPhone.text = phone
                            }
                        }
                    }
                }
            }
        }))
    }
}

extension UIColor {
    convenience init(hex: Int) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
        
    }
    
}
