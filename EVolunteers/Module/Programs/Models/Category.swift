//
//  Category.swift
//  EVolunteers
//
//  Created by Dicky Geraldi on 19/05/20.
//  Copyright © 2020 Dedy Yuristiawan. All rights reserved.
//

import UIKit

struct Category {
    
    var categoryContent: String
    var colorMask: UIColor
    var isActived: Bool
    
    init(categoryContent: String, colorMask: UIColor, isActived: Bool) {
        self.categoryContent = categoryContent
        self.colorMask = colorMask
        self.isActived = isActived
    }
}

func CategoryInit() -> [Category] {
    let colorCollection: [UIColor] =  [#colorLiteral(red: 0.8862745098, green: 0.6431372549, blue: 0.6431372549, alpha: 1), #colorLiteral(red: 0.5058823529, green: 0.5960784314, blue: 0.8862745098, alpha: 1), #colorLiteral(red: 0.3725490196, green: 0.6549019608, blue: 0.7607843137, alpha: 1), #colorLiteral(red: 0.6549019608, green: 0.4431372549, blue: 0.4431372549, alpha: 1)]
    var temp: [Category] = []
    
    let category_1 = Category.init(categoryContent: "All", colorMask: colorCollection[0], isActived: true)
    let category_2 = Category.init(categoryContent: "Pendidikan", colorMask: colorCollection[1], isActived: false)
    let category_3 = Category.init(categoryContent: "Kebudayaan", colorMask: colorCollection[2], isActived: false)
    let category_4 = Category.init(categoryContent: "Kesehatan", colorMask: colorCollection[3], isActived: false)
    
    temp = [category_1, category_2, category_3, category_4]
    
    return temp
}
