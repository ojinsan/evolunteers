//
//  CollectionViewCell.swift
//  EVolunteers
//
//  Created by Dedy Yuristiawan on 26/05/20.
//  Copyright © 2020 Dedy Yuristiawan. All rights reserved.
//

import UIKit
import CloudKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    @IBOutlet weak var circleView: UIView!{
        didSet{
            circleView.layer.cornerRadius = circleView.frame.size.width/2
            circleView.clipsToBounds = true
        }
    }
    @IBOutlet weak var imageView: UIImageView!{
        didSet{
            imageView.layer.cornerRadius = 16
            imageView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        }
    }
    
    var userActivitiesLog : UserActivitiesLog?{
        didSet{
            
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "MMM dd, yyyy"
            
            self.dateLabel.text = dateFormatterPrint.string(from: userActivitiesLog?.record?.creationDate ?? Date())
            self.descLabel.text = userActivitiesLog?.deskripsi
            
            if let activitiesProgramId = userActivitiesLog?.programId {
                let predicatePrograms = NSPredicate(format: "recordID = %@", activitiesProgramId)
                Programs.query(predicate: predicatePrograms, result: { (foundPrograms) in
                    if let foundProgram = foundPrograms?.first {
                        if let asset = foundProgram.photo, let fileUrl = asset.fileURL, let data = try? Data(contentsOf: fileUrl), let image = UIImage(data: data) {
                            
                            DispatchQueue.main.async {
                                self.imageView.image = image
                            }
                        }
                    }
                }) { (error) in
                    print(error)
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
