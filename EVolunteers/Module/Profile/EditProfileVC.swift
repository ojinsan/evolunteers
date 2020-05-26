//
//  EditProfileVC.swift
//  EVolunteers
//
//  Created by derry on 26/05/20.
//  Copyright © 2020 Dedy Yuristiawan. All rights reserved.
//

import UIKit

class EditProfileVC: UIViewController {
    
    @IBOutlet weak var editNama: UITextField!
    @IBOutlet weak var editTempatLahir: UITextField!
    @IBOutlet weak var editTanggalLahir: UITextField!
    @IBOutlet weak var editJabatan: UITextField!
    @IBOutlet weak var editHandphone: UITextField!
    
    @IBOutlet weak var saveChanges: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveChanges.layer.borderWidth = 1
        saveChanges.layer.cornerRadius = 10
        saveChanges.layer.borderColor = UIColor.init(hex: 0x000000).cgColor
        
        //MARK: HIDE KEYBOARD WHEN TAPPING ON SCREEN
        let tapOnScreen: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

        tapOnScreen.cancelsTouchesInView = false
        view.addGestureRecognizer(tapOnScreen)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
