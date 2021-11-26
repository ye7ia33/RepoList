//
//  RepoListViewController.swift
//  RepoList
//
//  Created by Yahia El-Dow on 26/11/2021.
//

import UIKit

class RepoListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private var viewDelegate: RepoListViewProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.viewDelegate?.viewDidLoad()
    }
    
    func config(delegate: RepoListViewProtocol) {
        self.viewDelegate = delegate
    }
    
    private func setupTableView() {
        self.tableView.registerCellType(RepoInfoCell.self)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension RepoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewDelegate?.numOfRepo ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.repoViewCell(indexPath: indexPath) {
            return cell
        }
        return UITableViewCell()
    }
    
    private func repoViewCell(indexPath: IndexPath) -> RepoInfoCell? {
        guard let cell: RepoInfoCell = self.tableView.dequeueCell(indexPath: indexPath) else { return nil }
        if let repoModel = self.viewDelegate?.repoList?[safe: indexPath.row],
           let repoName = repoModel.name,
           let ownerName = repoModel.fullName,
           let avatarUrl = repoModel.owner?.avatarURL {
            cell.config(imgUrl: avatarUrl, repoName: repoName, ownerName: ownerName)
        }
        return cell
    }
    
    
}
extension RepoListViewController: RepoListPresenterProtocol {
    func reloadData() {
        self.tableView.reloadData()
    }
}
