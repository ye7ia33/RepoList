//
//  DetailsViewController.swift
//  RepoList
//
//  Created by Yahia El-Dow on 26/11/2021.
//

import UIKit

class DetailsViewController: UIViewController {
    private var viewDelegate: DetailsViewProtocol?
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var repoDescription: UILabel!
    @IBOutlet weak var repoStatus: UILabel!
    @IBOutlet weak var openRepoButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewDelegate?.viewDidLoad()
    }
    
    func config(delegate: DetailsViewProtocol) {
        self.viewDelegate = delegate
    }
    
    @IBAction func dismissMe(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func openRepoButtonAction(_ sender: Any) {
        if let strUrl = self.viewDelegate?.repoURL,
           let url = URL(string: strUrl) {
            UIApplication.shared.open(url)
        }
    }
    
    func hiddenOpenRepoButton() {
        self.openRepoButton.isHidden = true
    }
}

extension DetailsViewController: DetailsPresenterProtocol {
    func reloadData() {
        self.bindData()
    }
    func bindData() {
        if let url = self.viewDelegate?.avatarUrl {
            self.avatarImage.downloadImage(from: url)
        }
        self.repoNameLabel.text = self.viewDelegate?.repoName
        self.ownerNameLabel.text = self.viewDelegate?.ownerName
        self.typeLabel.text = self.viewDelegate?.repoType?.title
        self.typeLabel.textColor = self.viewDelegate?.repoType?.labelColor
        self.repoDescription.text = self.viewDelegate?.repoDescription
        self.repoStatus.text = self.viewDelegate?.repoStatus
    }
}
 
