//
//  ProgramsViewController.swift
//  EVolunteers
//
//  Created by Dedy Yuristiawan on 12/05/20.
//  Copyright © 2020 Dedy Yuristiawan. All rights reserved.
//

import UIKit

class ProgramsViewController: UIViewController {
    
    @IBOutlet weak var categoryCollection: UICollectionView!
    var cetegoryColl: [Category] = []
    
    func setUpNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        self.navigationItem.searchController = search
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationBar()
        cetegoryColl = CategoryInit()
        categoryCollection.dataSource = self
    }

}

extension ProgramsViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}

extension ProgramsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cetegoryColl.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QRData", for: indexPath) as! CategoryViewCell
        
        
        let data = cetegoryColl[indexPath.row]
        
        cell.categoryCollection = data
        
        return cell
    }
}
