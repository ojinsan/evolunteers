//
//  ProfileViewController.swift
//  EVolunteers
//
//  Created by Dedy Yuristiawan on 12/05/20.
//  Copyright © 2020 Dedy Yuristiawan. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var daftarButton: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var userNama: UILabel!
    @IBOutlet weak var userStatus: UILabel!
    @IBOutlet weak var userLokasi: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userPhone: UILabel!
    @IBOutlet weak var userTTL: UILabel!
    
    @IBOutlet weak var userPrograms: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        daftarButton.layer.borderWidth = 1
        daftarButton.layer.borderColor = UIColor.init(hex: 0x000000).cgColor
        
        profileImage.layer.cornerRadius = 25
        profileImage.layer.borderWidth = 1
        profileImage.layer.borderColor = UIColor.init(hex: 0x000000).cgColor
        
        usersView()
    }
    
    func usersView(){
        userNama.text = "Derry Antonio"
        userStatus.text = "Students"
        userLokasi.text = "Jakarta"
        userEmail.text = "derryantonio01@gmail.com"
        userPhone.text = "08988913800"
        userTTL.text = "Jakarta, 13 Juni 1992"
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
