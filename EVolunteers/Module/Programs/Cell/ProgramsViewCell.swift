//
//  ProgramsViewCell.swift
//  EVolunteers
//
//  Created by Dicky Geraldi on 26/05/20.
//  Copyright © 2020 Dedy Yuristiawan. All rights reserved.
//

import UIKit

class ProgramsViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageVolunteers: UIImageView!
    @IBOutlet weak var activityName: UILabel!
    @IBOutlet weak var communityName: UILabel!
    @IBOutlet weak var starToWork: UILabel!
    @IBOutlet weak var placement: UILabel!
    
    var programsCollection: Programs! {
        didSet {
            imageVolunteers.image = UIImage(named: "Rectangle")
            activityName.text = programsCollection.judulProgram
            communityName.text = programsCollection.penyelenggara
            starToWork.text = "Minggu"
            placement.text = programsCollection.lokasi
        }
    }
    
    override func layoutSubviews() {
        // cell rounded section
        self.layer.cornerRadius = 15.0
        self.layer.borderWidth = 5.0
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.masksToBounds = true
        
        // cell shadow section
        self.contentView.layer.cornerRadius = 15.0
        self.contentView.layer.borderWidth = 5.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        self.layer.shadowColor = UIColor.white.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0.0)
        self.layer.shadowRadius = 6.0
        self.layer.shadowOpacity = 0.6
        self.layer.cornerRadius = 15.0
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
    
}
