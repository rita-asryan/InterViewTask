//
//  UITextField.swift
//  InterviewTask
//
//  Created by Rita Asryan on 12/10/21.
//  Copyright © 2021 Rita Asryan. All rights reserved.
//

import UIKit

extension UITextField {
    func setPlaceholder(text: String, color: UIColor) {
        self.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: UIFont(name: "Roboto-Regular", size: 17) ?? UIFont.systemFont(ofSize: 17)]
        )
    }
}

