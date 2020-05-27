//
//  NewProgramViewController.swift
//  EVolunteers
//
//  Created by Fauzan Ramadhan on 18/05/20.
//  Copyright © 2020 Dedy Yuristiawan. All rights reserved.
//

import UIKit
import CloudKit
import Combine


class NewProgramViewController: UIViewController, UITextFieldDelegate{
    
    let privateDatabase = CKContainer.default().privateCloudDatabase
    let publicDatabase = CKContainer.default().publicCloudDatabase
    let sharedDatabase = CKContainer.default().sharedCloudDatabase
    
    
    var programs = [Programs]()
    var rekaman: CKRecord?
    var delegate:NewProgramViewControllerDelegate?
    var newList: Bool = true
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var startDate: UITextField!
    @IBOutlet weak var endDate: UITextField!
    
    let datePickerStart = UIDatePicker()
    let datePickerEnd = UIDatePicker()
    
    @IBOutlet weak var judulProgram: UITextField!
    @IBOutlet weak var penyelenggara: UITextField!
    @IBOutlet weak var Kategori: UITextField!
    @IBOutlet weak var Lokasi: UITextField!
    @IBOutlet weak var kebutuhan: UITextField!
    @IBOutlet weak var deskripsi: UITextField!
    @IBOutlet weak var kriteria: UITextField!
    
    
    @IBOutlet weak var gambar: UIImageView!
    
    @IBAction func openCameraAndLibrary(_ sender: UIButton) {
        openCameraAndLibrary()
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
        deskripsi.delegate = self
        kebutuhan.delegate = self
        kriteria.delegate = self
        // Do any additional setup after loading the view.
        
        //scrollView.setContentOffset(CGPoint(x: 0, y: 300), animated: true)
        
        //MARK: HIDE KEYBOARD WHEN TAPPING ON SCREEN
        let tapOnScreen: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        tapOnScreen.cancelsTouchesInView = false
        view.addGestureRecognizer(tapOnScreen)
        
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("up up")
        if (textField == deskripsi) {
            print("its desc")
            scrollView.setContentOffset(CGPoint(x: 0, y: 240), animated: true)
        } else if (textField == kebutuhan) {
            print("its desc")
            scrollView.setContentOffset(CGPoint(x: 0, y: 240), animated: true)
        } else if (textField == kriteria){
            print("its desc")
            scrollView.setContentOffset(CGPoint(x: 0, y: 240), animated: true)
        }
            
        else {
            scrollView.setContentOffset(CGPoint(x: 0, y: 300), animated: true)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        scrollView.setContentOffset(CGPoint(x:0, y:0), animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func createDatePicker()  {
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //bar button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        
        //assign toolbar
        startDate.inputAccessoryView = toolbar
        endDate.inputAccessoryView = toolbar
        startDate.inputView = datePickerStart
        endDate.inputView = datePickerEnd
        
        datePickerStart.datePickerMode = .date
        datePickerEnd.datePickerMode = .date
    }
    
    
    
    @IBAction func submitBtn(_ sender: UIButton) {
        let judulProgram = self.judulProgram.text! as String
        let penyelenggara = self.penyelenggara.text! as String
        let kategori:[String] = [self.Kategori.text! as String]
        let lokasi = self.Lokasi.text! as String
        let kebutuhan:[String] = [self.kebutuhan.text! as String]
        let deskripsi = self.deskripsi.text! as String
        let kriteria = self.kriteria.text! as String
        //let programCreator = "B76C2ADB-083F-6C4F-8744-AFC4E570AAC7" as RecordID
        
        let datePickerEnd = self.datePickerEnd.date as NSDate
        let datePickerStart = self.datePickerStart.date as NSDate
        //
        //
        //        // Fetch Private Database
        //        let privateDatabase = CKContainer.default().publicCloudDatabase
        //
        //        rekaman = CKRecord(recordType: "Programs")
        //
        //        // Configure Record
        //        rekaman?.setObject(judulProgram, forKey: "namaProgram")
        //        rekaman?.setObject(penyelenggara, forKey: "namaKomunitas")
        //        rekaman?.setObject(kebutuhan as __CKRecordObjCValue, forKey: "kebutuhanPekerjaan")
        //        rekaman?.setObject(kriteria, forKey: "kriteria")
        //        rekaman?.setObject(kategori as __CKRecordObjCValue, forKey: "programCategory")
        //        rekaman?.setObject(lokasi, forKey: "lokasi")
        //        rekaman?.setObject(deskripsi, forKey: "deskripsi")
        //        //rekaman?.setObject(programCreator, forKey: "programCreator")
        //
        //        rekaman?.setObject(datePickerStart, forKey: "startDate")
        //        rekaman?.setObject(datePickerEnd, forKey: "endDate")
        //
        //
        //
        //
        //        privateDatabase.save(rekaman!) { (record, error) -> Void in
        //            DispatchQueue.main.sync {
        //                // Process Response
        //                self.processResponse(record: record, error: error)
        //            }
        //        }
        
        //processResponse(record: <#T##CKRecord?#>, error: <#T##Error?#>)
        
        let data = gambar.image!.pngData(); // UIImage -> NSData, see also UIImageJPEGRepresentation
        let url = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(NSUUID().uuidString+".dat")
        do {
            try data!.write(to: url!, options: [])
        } catch let e as NSError {
            print("Error! \(e)");
            //return
        }
        
        
        
        Programs(judulProgram: judulProgram, penyelenggara:penyelenggara, kebutuhan:kebutuhan, kriteria:kriteria, kategori:kategori, lokasi:lokasi, deskripsi:deskripsi, startDate: datePickerStart, endDate:datePickerEnd, url:url!).save(result: { (users) in
            print("users : \(users?.name ?? "")")
            
            DispatchQueue.main.sync {
                self.dismiss(animated: true, completion: nil)
                
                // Delete the temporary file
                do {
                    try FileManager.default.removeItem(at: url!)
                }
                catch let e {
                    print("Error deleting temp file: \(e)")
                }

                // ...
            }
            
        }){
            (error) in
            print(error)
            let message = "Error while submiting the Program"
            let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                
            // Present Alert Controller
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    
    
    @objc func donePressed() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        startDate.text = formatter.string(from: datePickerStart.date)
        endDate.text =  formatter.string(from: datePickerEnd.date)
        self.view.endEditing(true)
    }
    
    
    private func processResponse(record: CKRecord?, error: Error?) {
        var message = ""
        
        if let error = error {
            print(error)
            message = "We were not able to save your list."
            
        } else if record == nil {
            message = "We were not able to save your list."
        }
        
        if !message.isEmpty {
            // Initialize Alert Controller
            let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            
            // Present Alert Controller
            present(alertController, animated: true, completion: nil)
            
        } else {
            // Notify Delegate
            if newList {
                delegate?.controller(controller: self, didAddList: rekaman!)
            } else {
                delegate?.controller(controller: self, didUpdateList: rekaman!)
            }
            
            // Pop View Controller
            self.dismiss(animated: true, completion: nil)
            
        }
    }
}


protocol NewProgramViewControllerDelegate {
    func controller(controller: NewProgramViewController, didAddList rekaman: CKRecord)
    func controller(controller: NewProgramViewController, didUpdateList rekaman: CKRecord)
}



// MARK: Function to trigger open camera and library
extension NewProgramViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func openCameraAndLibrary() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        let actionAlert = UIAlertController(title: "Browse Attachment", message: "Choose Source", preferredStyle: .alert)
        actionAlert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action: UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true,completion: nil)
            } else {
                print("ga ada kamera")
            }
        })) //give the first option in alert controller to open camera
        
        actionAlert.addAction(UIAlertAction(title: "Photo Gallery", style: .default, handler: { (action: UIAlertAction) in
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = ["public.image", "public.movie"]
            self.present(imagePicker, animated: true,completion: nil)
        })) //give the second option in alert controller to open gallery
        
        actionAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil)) //last option to cancel the form
        
        self.present(actionAlert,animated: true, completion: nil)
    }
    func imagePickerController(_ picker:UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        if let imageTaken = info[.originalImage] as? UIImage {
            picker.dismiss(animated: true) {
                self.gambar.image = imageTaken
                //disini
                //self.convertImageToAnalysed(image:imageTaken)
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}


