//
//  ProgramsDetails.swift
//  EVolunteers
//
//  Created by Dicky Geraldi on 27/05/20.
//  Copyright © 2020 Dedy Yuristiawan. All rights reserved.
//

import UIKit
import CloudKit

class ProgramsDetails: UIViewController {

    @IBOutlet weak var imageCover: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var communityName: UILabel!
    @IBOutlet weak var volunteryJoined: UILabel!
    @IBOutlet weak var dayToJoin: UILabel!
    @IBOutlet weak var placement: UILabel!
    @IBOutlet weak var dueDate: UILabel!
    @IBOutlet weak var volunteryCriteria: UILabel!
    @IBOutlet weak var volunteryJobs: UILabel!
    @IBOutlet weak var neededCollection: UICollectionView!
    @IBOutlet weak var buttonBecomeVoluntery: UIButton!
    @IBOutlet weak var categoryCV: UICollectionView!
    
    var data: Programs?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        
        neededCollection.delegate = self
        neededCollection.dataSource = self
        
        categoryCV.delegate = self
        categoryCV.dataSource = self
    }
    
    func setupView() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        buttonBecomeVoluntery.layer.cornerRadius = 15.0
        
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        profileImage.clipsToBounds = true
        
        if let data = data {
            communityName.text = data.judulProgram
            imageCover.image = data.image
            profileImage.image = data.image
            volunteryJoined.text = "100+ Relawan Tergabung"
            dayToJoin.text = "Minggu"
            placement.text = data.lokasi
            dueDate.text = "Periode Pendaftaran \(dateFormatter.string(from: data.startDate as! Date)) - \(dateFormatter.string(from: data.endDate as! Date))"
            volunteryJobs.text = data.deskripsi
            volunteryCriteria.text = data.kriteria
        }
    }
    
    
    @IBAction func becomeVoluntery(_ sender: Any) {
        daftarProgram(programs: data!)
    }
}

extension ProgramsDetails: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.neededCollection {
            return data?.kebutuhan?.count ?? 0
        } else {
            return data?.kategori?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.neededCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DataNeed", for: indexPath) as! NeedCollectionView
            
            let dataNeed = data?.kebutuhan?[indexPath.row]
            cell.neededName = dataNeed
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCV", for: indexPath) as! CategoryVC
            
            let dataNeed = data?.kategori?[indexPath.row]
            cell.categoryNames = dataNeed
            
            return cell
        }
    }
    
    
}

extension ProgramsDetails {
    
    func toLogin() {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.present(vc, animated: true)
    }
    
    func daftarProgram(programs: Programs) {
        
        if !PreferenceManager.instance.isUserLogin {
            toLogin()
            return
        }
        
        let email = PreferenceManager.instance.userEmail ?? ""
        let programId: CKRecord.ID = CKRecord.ID(recordName: "\(programs.record?.recordID.recordName ?? "")")
        let predicateMembers = NSPredicate(format: "%K == %@", argumentArray: ["email", email])
        let predicatePrograms = NSPredicate(format: "recordID=%@", programId)
        Members.query(predicate: predicateMembers, result: { (foundMembers) in
            if let foundMember = foundMembers?.first, let foundMemberRecord = foundMember.record {
                let foundMemberReference: CKRecord.Reference = CKRecord.Reference(record: foundMemberRecord, action: .none)
                Programs.query(predicate: predicatePrograms, result: { (foundPrograms) in
                    if let foundProgram = foundPrograms?.first, let foundProgramRecord = foundProgram.record {
                        
                        // already registered programs
                        if self.checkVolunteersAndProgramsIsRegistered(foundProgram: foundProgram, foundMember: foundMember) {
                            return
                        }
                        
                        // save reference volunteers
                        let foundProgramReference: CKRecord.Reference = CKRecord.Reference(record: foundProgramRecord, action: .none)
                        var listRegisteredVolunteers = foundProgram.registeredVolunteers
                        listRegisteredVolunteers?.append(foundMemberReference)
                        foundProgram.record?.setValue(listRegisteredVolunteers, forKey: "registeredVolunteers")
                        foundProgram.save(result: { (savedPrograms) in
                            
                            
                        }) { (error) in
                        }
                        
                        // save UserActivitiesLog
                        UserActivitiesLog(deskripsi: "\(foundProgram.deskripsi ?? "")", programId: foundProgramReference, relatedUserEmail: foundMemberReference, isActiveActive: true).save(result: { (savedLog) in
                            
                        }) { (error) in
                            
                        }
                        
                    }
                }) { (error) in
                    print(error)
                }
            }
        }) { (error) in
            print(error)
        }
    }
    
    func checkVolunteersAndProgramsIsRegistered(foundProgram: Programs, foundMember: Members) -> Bool {
        var isRegistered = false
        if let registeredVolunteers = foundProgram.registeredVolunteers {
            for i in registeredVolunteers {
                if i.recordID == foundMember.record?.recordID {
                    isRegistered = true
                }
            }
        }
        
        return isRegistered
    }
}
