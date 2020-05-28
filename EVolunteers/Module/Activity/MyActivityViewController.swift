//
//  MyActivityViewController.swift
//  EVolunteers
//
//  Created by Dedy Yuristiawan on 12/05/20.
//  Copyright © 2020 Dedy Yuristiawan. All rights reserved.
//

import UIKit
import CloudKit

class MyActivityViewController: UIViewController {

    var segmentControl: UISegmentedControl!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
            collectionView.delaysContentTouches = false
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.alwaysBounceVertical = true
            if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.minimumLineSpacing = 0
                layout.minimumInteritemSpacing = 0
                layout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
            }
        }
    }
    
    var userActivitiesLogs = [UserActivitiesLog]()
    var activeUserActivitiesLogs = [UserActivitiesLog]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.activityIndicatorView.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.reload()
    }
    
    func reload() {
        let email = PreferenceManager.instance.userEmail ?? ""
        let predicateMembers = NSPredicate(format: "%K == %@", argumentArray: ["email", email])
        Members.query(predicate: predicateMembers, result: { (members) in
            if let member = members?.first, let memberId = member.record?.recordID {
                let predicateRelatedUserEmail = NSPredicate(format: "relatedUserEmail=%@", memberId)
                UserActivitiesLog.query(predicate: predicateRelatedUserEmail, result: { (userActivitiesLogs) in
                    DispatchQueue.main.async {
                         self.activityIndicatorView.isHidden = true
                    }
                    
                    if let userActivitiesLogs = userActivitiesLogs {
                        self.userActivitiesLogs = userActivitiesLogs
                        self.activeUserActivitiesLogs = userActivitiesLogs.filter { ($0.isActiveActive ?? false) }
                        
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                       }
                    }
                }) { (error) in
                    self.activityIndicatorView.isHidden = true
                    print("error \(error.localizedDescription)")
                }
            }
        }) { (error) in
            self.activityIndicatorView.isHidden = true
            print("error \(error.localizedDescription)")
        }
    }
    
    func sampleDeleteAllActivities(){
        UserActivitiesLog.deleteAll {
            print("Success delete UserActivitiesLog")
        }
        
        let predicateMembersTest = NSPredicate(format: "%K == %@", argumentArray: ["email", "test@test.com"])
        Members.delete(predicate: predicateMembersTest, completion: {
            print("Success delete UserActivitiesLog test email")
        })
        
        let programId: CKRecord.ID = CKRecord.ID(recordName: "986E1571-9D26-4AF2-BA0B-5DC98A3DA650")
        let predicatePrograms = NSPredicate(format: "recordID=%@", programId)
        Programs.delete(predicate: predicatePrograms, completion: {
            print("Success delete UserActivitiesLog test email")
        })
    }
    
    func setupView() {
        self.title = "Activities"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        let titles = ["All", "Joined Programs"]
        self.segmentControl = UISegmentedControl(items: titles)
        self.segmentControl.selectedSegmentIndex = 0
        for index in 0...titles.count-1 {
            self.segmentControl.setWidth(130, forSegmentAt: index)
        }
        self.segmentControl.sizeToFit()
        self.segmentControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        self.segmentControl.selectedSegmentIndex = 1
        self.segmentControl.sendActions(for: .valueChanged)
        self.navigationItem.titleView = self.segmentControl
    }
    
    @objc
    func segmentChanged() {
        switch segmentControl.selectedSegmentIndex {
        case 1:
            print("1")
        default:
            print("2")
        }
    }
    
    @objc
    func addActivities() {
    }

}

extension MyActivityViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        switch segmentControl.selectedSegmentIndex {
        case 1:
            cell.userActivitiesLog = self.userActivitiesLogs[indexPath.row]
        default:
            cell.userActivitiesLog = self.activeUserActivitiesLogs[indexPath.row]
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch segmentControl.selectedSegmentIndex {
        case 1:
            return activeUserActivitiesLogs.count
        default:
            return userActivitiesLogs.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.toLogin()
    }
    
    func toLogin() {
        if PreferenceManager.instance.isUserLogin {
            return
        }
        
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.present(vc, animated: true)
    }
}

extension MyActivityViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == collectionView {
            return CGSize(width: self.widthScreen, height: 140)
        }
        
        return CGSize.zero
    }
}

extension ProgramsViewController {
    
    func daftarProgram(programs: Programs) {
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
