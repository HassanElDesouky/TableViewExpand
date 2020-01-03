//
//  Extensions.swift
//  TableViewExpand
//
//  Created by Hassan El Desouky on 1/3/20.
//  Copyright © 2020 Hassan El Desouky. All rights reserved.
//

import UIKit


extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }
   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}


extension UIColor {
  // ff595e-ffca3a-8ac926-1982c4-6a4c93
  static let SUNSET_ORANGE = UIColor(rgb: 0xff595e)
  static let SUNGLOW = UIColor(rgb: 0xffca3a)
  static let YELLOW_GREEN = UIColor(rgb: 0x8ac926)
  static let CYAN_CORNFLOWER_BLUE = UIColor(rgb: 0x1982c4)
  static let DARK_LAVENDER = UIColor(rgb: 0x6a4c93)
}
