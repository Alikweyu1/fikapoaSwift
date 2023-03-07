//
//  textfieldCustomize.swift
//  FikaPoaFraudDetection
//
//  Created by SOFTWARE on 02/03/2023.
//

import Foundation
import UIKit
class CustomeFeldText:UITextField{
    
    
    required init?(coder: NSCoder) {
        super .init(coder: coder)
        setupUnderlineField()
    }
    func setupUnderlineField(){
        let bottomLayer = CALayer()
        bottomLayer.frame = CGRect(x: 0, y: self.frame.height, width: self.frame.width - 8, height: 10)
        bottomLayer.backgroundColor = UIColor.red.cgColor
        self.layer.addSublayer(bottomLayer)
    }
}
