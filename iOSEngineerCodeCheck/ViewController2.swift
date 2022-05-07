//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    
    @IBOutlet weak var ImageView: UIImageView!
    
    @IBOutlet weak var TitleLabel: UILabel!
    
    @IBOutlet weak var LanguageLabel: UILabel!
    
    @IBOutlet weak var StargazersLabel: UILabel!
    @IBOutlet weak var WachersLabel: UILabel!
    @IBOutlet weak var ForksLabel: UILabel!
    @IBOutlet weak var IssuesLabel: UILabel!
    
    var repository: [String: Any] = [:]
    
    private var input2: Presenter2Input!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        input2 = Presenter2(output2: self)
        LanguageLabel.text = "Written in \(repository["language"] as? String ?? "")"
        StargazersLabel.text = "\(repository["stargazers_count"] as? Int ?? 0) stars"
        WachersLabel.text = "\(repository["wachers_count"] as? Int ?? 0) watchers"
        ForksLabel.text = "\(repository["forks_count"] as? Int ?? 0) forks"
        IssuesLabel.text = "\(repository["open_issues_count"] as? Int ?? 0) open issues"
        getImage()
    }
    
    
    func getImage(){
        TitleLabel.text = repository["full_name"] as? String
        input2.getImage(owner :repository["owner"])
    }
}

extension ViewController2: Presenter2Output {
    func passImage(data: Data) {
        if let img = UIImage(data: data){
            DispatchQueue.main.async {
                self.ImageView.image = img
            }
        }
    }
}
