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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.sampleSaveActivities()
    }
    
    func reload() {
        let sortCreation = NSSortDescriptor(key: "", ascending: false)
        UserActivitiesLog.all(inDatabase: CKContainer.default().publicCloudDatabase, withSortDescriptors : [sortCreation], result: { (userActivitiesLogs) in
            if let userActivitiesLogs = userActivitiesLogs {
                self.userActivitiesLogs = userActivitiesLogs
            }
        }) { (error) in print(error) }
    }
    
    func sampleSaveActivities(){
        UserActivitiesLog(deskripsi: "Memberikan APD sejumlah 29 juta kepada 3.700 rumah sakit di Papua, Sumatera, dan Nusa Tenggara").save(result: { (users) in
            self.reload()
        }) { (error) in print(error) }
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
        
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addActivities))
//        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.systemOrange
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
//        cell.userActivitiesLog = self.userActivitiesLogs[indexPath.row]
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
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
