//
//  ProgramsDetails.swift
//  EVolunteers
//
//  Created by Dicky Geraldi on 27/05/20.
//  Copyright © 2020 Dedy Yuristiawan. All rights reserved.
//

import UIKit

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
    
    var data: Programs?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    func setupView() {
        if let data = data {
            communityName.text = data.judulProgram
            imageCover.image = data.image
            profileImage.image = data.image
            volunteryJoined.text = "100+ Relawan Tergabung"
            dayToJoin.text = "Minggu"
            placement.text = data.lokasi
            dueDate.text = "Periode Pendaftaran \(String(describing: data.startDate)) - \(String(describing: data.endDate))"
            volunteryJobs.text = data.deskripsi
            volunteryJoined.text = data.kriteria
        }
    }
}
