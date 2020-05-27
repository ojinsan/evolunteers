//
//  CollectionViewCell.swift
//  EVolunteers
//
//  Created by Dedy Yuristiawan on 26/05/20.
//  Copyright © 2020 Dedy Yuristiawan. All rights reserved.
//

import UIKit

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
            self.dateLabel.text = userActivitiesLog?.record?.creationDate?.description
            self.descLabel.text = userActivitiesLog?.deskripsi
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
