//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

final class SearchViewController: UITableViewController {

    @IBOutlet weak var SearchBar: UISearchBar!
    
    private var input: SearchPresenterInput!
    
    func inject(input: SearchPresenterInput) {
        self.input = input
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let model = SearchModel()
        let input = SearchPresenter(output: self, model: model)
        inject(input: input)
        SearchBar.text = "GitHubのリポジトリを検索できるよー"
        SearchBar.delegate = self
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.text = ""
        return true
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        input.cancelTask()
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        input.search(searchBarText: searchBar.text)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != "Detail"{ return }
        if let detail = segue.destination as? DetailViewController {
            detail.repository = input.showRepository
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return input.numberOfItems
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let repository = input.row(index: indexPath.row)
        cell.textLabel?.text = repository["full_name"] as? String ?? ""
        cell.detailTextLabel?.text = repository["language"] as? String ?? ""
        cell.tag = indexPath.row
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 画面遷移時に呼ばれる
        input.toDetailView(indexPath: indexPath)
    }
}

extension SearchViewController: SearchPresenterOutput {
    func tableReload(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func performSegue() {
        performSegue(withIdentifier: "Detail", sender: self)
    }
}
