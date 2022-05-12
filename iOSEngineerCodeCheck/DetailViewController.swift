//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var ImageView: UIImageView!
    
    @IBOutlet weak var TitleLabel: UILabel!
    
    @IBOutlet weak var LanguageLabel: UILabel!
    
    @IBOutlet weak var StargazersLabel: UILabel!
    @IBOutlet weak var WatchersLabel: UILabel!
    @IBOutlet weak var ForksLabel: UILabel!
    @IBOutlet weak var IssuesLabel: UILabel!
    
    var repository: [String: Any] = [:]
    
    private var input: DetailViewPresenterInput!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let model = DetailViewModel()
        input = DetailViewPresenter(output: self, model: model)
        LanguageLabel.text = "Written in \(repository["language"] as? String ?? "")"
        StargazersLabel.text = "\(repository["stargazers_count"] as? Int ?? 0) stars"
        WatchersLabel.text = "\(repository["watchers_count"] as? Int ?? 0) watchers"
        ForksLabel.text = "\(repository["forks_count"] as? Int ?? 0) forks"
        IssuesLabel.text = "\(repository["open_issues_count"] as? Int ?? 0) open issues"
        getImage()
    }
    
    
    func getImage(){
        TitleLabel.text = repository["full_name"] as? String
        input.getImage(owner :repository["owner"])
    }
}

extension DetailViewController: DetailViewPresenterOutput {
    func passImage(data: Data) {
        if let img = UIImage(data: data){
            DispatchQueue.main.async {
                self.ImageView.image = img
            }
        }
    }
}
