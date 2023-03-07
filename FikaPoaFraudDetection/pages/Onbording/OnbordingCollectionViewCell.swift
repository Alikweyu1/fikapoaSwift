//
//  OnbordingCollectionViewCell.swift
//  FikaPoaFraudDetection
//
//  Created by SOFTWARE on 29/03/2023.
//

import UIKit

class OnbordingCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing:OnbordingCollectionViewCell.self)
    @IBOutlet weak var descriptionSlide: UILabel!
    @IBOutlet weak var titleSlide: UILabel!
    @IBOutlet weak var imageSlide: UIImageView!
    func setUp(_ slide:OnbordingSLide){
        imageSlide.image = slide.images
        titleSlide.text = slide.title
        descriptionSlide.text = slide.description
        
    }
}

