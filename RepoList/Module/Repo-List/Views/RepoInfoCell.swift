//
//  RepoInfoCell.swift
//  RepoList
//
//  Created by Yahia El-Dow on 26/11/2021.
//

import UIKit

final class RepoInfoCell: UITableViewCell {
    
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
        self.selectionStyle = .none
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.ownerAvatarImage.image = nil
    }
    /**
     configration cell with data like image url, Repository name and owner name
     
     **data**
     
     1- imgUrl: String
     
     2-  repoName: String
     
     3- ownerName: String
     */
    func config(imgUrl: String, repoName: String, ownerName: String) {
        self.ownerAvatarImage.setDefaultImage()
        self.ownerAvatarImage?.downloadImage(from: imgUrl)
        self.repoNameLabel.text = repoName
        self.ownerNameLabel.text = ownerName
    }
}
