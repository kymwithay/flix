//
//  MovieCell.swift
//  flix
//
//  Created by Kymberlee Hill on 2/3/18.
//  Copyright © 2018 Kymberlee Hill. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!

    override func layoutSubviews() {
        super.layoutSubviews()
        overviewLabel.sizeToFit()
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
