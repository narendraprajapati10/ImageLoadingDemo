//
//  NewsCollectionViewCell.swift
//  ImageLoadingDemo
//
//  Created by WhyQ on 15/04/24.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: CustomImageView!
    
    func setupImage(data:NewsModel) {
        if let url = URL(string: data.coverageURL) {
            imageView.loadImage(from: url)
        }else {
            // use placeholder for the spinner which is loading if image not found
        }
    }
}
