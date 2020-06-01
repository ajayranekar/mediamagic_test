//
//  HomeCollectionViewCell.swift
//  MediaMagicTest
//
//  Created by Ajay Ranekar on 31/05/20.
//  Copyright © 2020 Ajay Ranekar. All rights reserved.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var authorImageView: UIImageView!
    @IBOutlet weak var authorNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.cornerRadius = 5
        
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.6
        containerView.layer.shadowRadius = 3
        containerView.layer.shadowOffset = CGSize.init(width: 0, height: 0)
        
        containerView.clipsToBounds = true
        containerView.layer.masksToBounds = false
        
        authorImageView.contentMode = .scaleAspectFill
        authorImageView.clipsToBounds = true
        
    }
    
    
}
