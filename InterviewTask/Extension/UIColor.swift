//
//  UIColor.swift
//  InterviewTask
//
//  Created by Rita Asryan on 12/11/21.
//  Copyright © 2021 Rita Asryan. All rights reserved.
//

import UIKit

extension UIColor {
    static var textFieldColor = UIColor(red: 206/255,
                                        green: 208/255,
                                        blue: 208/255, alpha: 1)
    
    static func gradientColor(bounds: CGRect, gradientLayer :CAGradientLayer) -> UIColor? {
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        //create UIImage by rendering gradient layer.
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        //get gradient UIcolor from gradient UIImage
        return UIColor(patternImage: image!)
    }
}

extension CAGradientLayer {
    static func getGradientLayer(bounds : CGRect) -> CAGradientLayer {
    let gradient = CAGradientLayer()
    gradient.frame = bounds
    //order of gradient colors
        gradient.colors = [UIColor(red: 201/255, green: 121/255, blue: 97/255, alpha: 1).cgColor, UIColor(red: 197/255, green: 141/255, blue: 101/255, alpha: 1).cgColor, UIColor(red: 201/255, green: 121/255, blue: 97/255, alpha: 1).cgColor]
    // start and end points
    gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
    gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
    return gradient
    }
}

extension UILabel {
    func setText(_ text: String, withColorPart colorTextPart: String, color: UIColor) {
        attributedText = nil
        let result = NSMutableAttributedString(string: text)
        result.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: NSString(string: text.lowercased()).range(of: colorTextPart.lowercased()))
        attributedText = result
    }
}
