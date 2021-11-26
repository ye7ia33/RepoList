//
//  RepoInfoCell.swift
//  RepoList
//
//  Created by Yahia El-Dow on 26/11/2021.
//

import UIKit

class RepoInfoCell: UITableViewCell {

    @IBOutlet private weak var ownerAvatarImage: UIImageView! {
        didSet {
            self.ownerAvatarImage.setCircle()
            self.ownerAvatarImage.setDefaultImage()
        }
    }
    @IBOutlet private weak var repoNameLabel: UILabel! {
        didSet {
            self.repoNameLabel.text = ""
        }
    }
    @IBOutlet private weak var ownerNameLabel: UILabel! {
        didSet {
            self.ownerNameLabel.text = ""
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func config(imgUrl: String, repoName: String, ownerName: String) {
        self.ownerAvatarImage?.downloadImage(from: imgUrl)
        self.repoNameLabel.text = repoName
        self.ownerNameLabel.text = ownerName
    }
    
}
