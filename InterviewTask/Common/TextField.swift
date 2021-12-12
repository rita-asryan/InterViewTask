//
//  TextField.swift
//  InterviewTask
//
//  Created by Rita Asryan on 12/10/21.
//  Copyright © 2021 Rita Asryan. All rights reserved.
//

import UIKit

class TextField: UITextField {
    
    // MARK: - View LifeCyle
    override func awakeFromNib() {
        super.awakeFromNib()
        textFieldApearance()
    }
    
    // MARK: - Methods
    private func textFieldApearance() {
        self.layer.cornerRadius = 4
        clipsToBounds = true
    }
}
