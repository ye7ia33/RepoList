//
//  RepoListViewController.swift
//  RepoList
//
//  Created by Yahia El-Dow on 26/11/2021.
//

import UIKit

class RepoListViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
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
        return viewDelegate?.repoList?.count ?? 0
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

extension RepoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewDelegate?.tableViewDidSelectItem(indexPath: indexPath)
    }
}

extension RepoListViewController: RepoListPresenterProtocol {
    func didOpenDetailsScreen(repoModel: Repository) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController {
            let detailsPresenter = DetailsPresenter(delegate: vc, repoModel: repoModel)
            vc.config(delegate: detailsPresenter)
            self.present(vc, animated: true)
        }
    }
    
    func reloadData() {
        self.tableView.reloadData()
    }
    
}

extension RepoListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewDelegate?.didStartSearchWith(str: searchText)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        self.viewDelegate?.didEndSearch()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(searchBar.text ?? "")
        self.view.endEditing(true)
        self.viewDelegate?.didEndSearch()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.returnKeyType == .search {
            //                self.getResultFromServer(searchKey: searchTextField.text!)
            self.view.endEditing(true)
        }
        if textField.returnKeyType == .default {
            self.viewDelegate?.didEndSearch()
        }
        return true
    }
    
}
