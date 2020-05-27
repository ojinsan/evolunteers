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
//    var delegate:EditProfileVCDelegate?
//    var newData: Bool = true
    
    
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
    
    @IBAction func submitChanges(_ sender: UIButton) {
        let editNama = self.editNama.text! as NSString
        let editJabatan = self.editJabatan.text! as NSString
        let editTempatLahir = self.editTempatLahir.text! as NSString
        let editHandphone = self.editHandphone.text! as NSString
        
        let privateDatabase = CKContainer.default().publicCloudDatabase
        
        usersRecord = CKRecord(recordType: "Users")
        
        //Record
        usersRecord?.setObject(editNama, forKey: "namaLengkap")
        usersRecord?.setObject(editJabatan, forKey: "jabatan")
        usersRecord?.setObject(editTempatLahir, forKey: "tempatLahir")
        usersRecord?.setObject(editHandphone, forKey: "handphone")
        
//        tempNama = self.editNama.text! as String
//        tempJabatan = self.editJabatan.text! as String
//        tempTempatLahir = self.editTempatLahir.text! as String
//        tempNoHandphone = self.editHandphone.text! as String
    }
    
//    private func processResponse(record: CKRecord?, error: Error?) {
//        var message = ""
//
//        if let error = error {
//            print(error)
//            message = "We were not able to update your data."
//
//        } else if record == nil {
//            message = "We were not able to update your data."
//        }
//
//        if !message.isEmpty {
//            // Initialize Alert Controller
//            let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
//
//            // Present Alert Controller
//            present(alertController, animated: true, completion: nil)
//
//        } else {
//            // Notify Delegate
//            if newData {
//                delegate?.controller(controller: self, didAddList: usersRecord!)
//            } else {
//                delegate?.controller(controller: self, didUpdateList: usersRecord!)
//            }
//
//            // Pop View Controller
//            self.dismiss(animated: true, completion: nil)
//
//        }
//    }
}

//protocol EditProfileVCDelegate {
//    func controller(controller: EditProfileVC, didAddList usersRecord: CKRecord)
//    func controller(controller: EditProfileVC, didUpdateList usersRecord: CKRecord)
//}
