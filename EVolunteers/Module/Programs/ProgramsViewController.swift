//
//  ProgramsViewController.swift
//  EVolunteers
//
//  Created by Dedy Yuristiawan on 12/05/20.
//  Copyright © 2020 Dedy Yuristiawan. All rights reserved.
//

import UIKit
import CloudKit
import Combine

class ProgramsViewController: UIViewController {
    
    @IBOutlet weak var categoryCollection: UICollectionView!
    @IBOutlet weak var programCollection: UICollectionView!
    
    @IBAction func createProgram(_ sender: Any) {
        //print("hai")
        if let vc = UIStoryboard(name: "NewProgramViewController", bundle: nil).instantiateViewController(withIdentifier: "NewProgramViewController") as? NewProgramViewController
        {
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
    }
    // Data real from CloudKit
    var cetegoryColl: [Category] = []
    var selectedData: Int = 0
    var dataPrograms = [Programs]()
    
    // Data filtered
    var isFiltering: Bool = false
    var programsFiltered = [Programs]()
    
    func setUpNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        self.navigationItem.searchController = search
        self.navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationBar()
        cetegoryColl = CategoryInit()
        
        categoryCollection.dataSource = self
        categoryCollection.delegate = self
        
        programCollection.dataSource = self
        programCollection.delegate = self
        
        getAllPrograms()
    }

    func getUpdateDate() {
        categoryCollection.performBatchUpdates({
            categoryCollection.reloadSections(NSIndexSet(index: 0) as IndexSet)
        }, completion: { (finished:Bool) -> Void in })
    }
    
    func getAllPrograms() {
        let sortByCreation = NSSortDescriptor(key: "creationDate", ascending: false)
        Programs.all(inDatabase: CKContainer.default().publicCloudDatabase, withSortDescriptors: [sortByCreation], result: { (dataProgramsNew) in if let dataProgramsUpdate = dataProgramsNew {
                self.dataPrograms = dataProgramsUpdate
                DispatchQueue.main.async {
                        self.programCollection.reloadData()
                    }
                }
        }) { (Error) in
            print(Error)
        }
    }
    
    func setToFalse() {
        for i in 0..<cetegoryColl.count {
            cetegoryColl[i].isActived = false
        }
    }
}

extension ProgramsViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, !text.isEmpty {
            programsFiltered = dataPrograms.filter({ (dataPrograms) -> Bool in
                return (dataPrograms.judulProgram?.lowercased().contains(text.lowercased()) ?? false)
            })
            
            isFiltering = true
        } else {
            isFiltering = false
            programsFiltered = [Programs]()
        }
        
        programCollection.reloadData()
    }
}

extension ProgramsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == self.categoryCollection {
            return 1
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.categoryCollection {
            return cetegoryColl.count
        } else {
            return isFiltering ? programsFiltered.count : dataPrograms.count
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.categoryCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QRData", for: indexPath) as! CategoryViewCell
            
            
            let data = cetegoryColl[indexPath.row]
            
            cell.categoryCollection = data
            
            return cell
            
        } else {
            let cellPrograms = collectionView.dequeueReusableCell(withReuseIdentifier: "Programs", for: indexPath) as! ProgramsViewCell
            
            let data = isFiltering ? programsFiltered[indexPath.row] : dataPrograms[indexPath.row]
            
            cellPrograms.programsCollection = data
            
            return cellPrograms
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.categoryCollection {
            if selectedData != indexPath.row {
                setToFalse()
                cetegoryColl[indexPath.row].isActived = true
                getUpdateDate()
                selectedData = indexPath.row
            }
        } else {
            
        }
    }
}
