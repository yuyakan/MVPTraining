//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var SchBr: UISearchBar!
    
    private var input: PresenterInput!
    
    var task: URLSessionTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        input = Presenter(output: self)
        SchBr.text = "GitHubのリポジトリを検索できるよー"
        SchBr.delegate = self
    }
    
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.text = ""
        return true
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        input.cancelTask()
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        input.search(schBrTxt: searchBar.text)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != "Detail"{ return }
        if let dtl = segue.destination as? ViewController2 {
            dtl.repo = input.showRepo
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return input.numberOfItems
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let rp = input.row(idx: indexPath.row)
        cell.textLabel?.text = rp["full_name"] as? String ?? ""
        cell.detailTextLabel?.text = rp["language"] as? String ?? ""
        cell.tag = indexPath.row
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 画面遷移時に呼ばれる
        input.toDetailView(idxPath: indexPath)
    }
}

extension ViewController: PresenterOutput {
    func tableReload(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func performSegue() {
        performSegue(withIdentifier: "Detail", sender: self)
    }
}
