//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    
    @IBOutlet weak var ImgView: UIImageView!
    
    @IBOutlet weak var TtlLbl: UILabel!
    
    @IBOutlet weak var LangLbl: UILabel!
    
    @IBOutlet weak var StrsLbl: UILabel!
    @IBOutlet weak var WchsLbl: UILabel!
    @IBOutlet weak var FrksLbl: UILabel!
    @IBOutlet weak var IsssLbl: UILabel!
    
    var repo: [String: Any] = [:]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LangLbl.text = "Written in \(repo["language"] as? String ?? "")"
        StrsLbl.text = "\(repo["stargazers_count"] as? Int ?? 0) stars"
        WchsLbl.text = "\(repo["wachers_count"] as? Int ?? 0) watchers"
        FrksLbl.text = "\(repo["forks_count"] as? Int ?? 0) forks"
        IsssLbl.text = "\(repo["open_issues_count"] as? Int ?? 0) open issues"
        getImage()
    }
    
    
    func getImage(){
        
        TtlLbl.text = repo["full_name"] as? String
        
        let owner = repo["owner"] as? [String: Any]
        if owner == nil {
            return;
        }
        
        guard let imgURL = owner?["avatar_url"] as? String else { return }
        guard let existImgURL = URL(string: imgURL) else { return }
        URLSession.shared.dataTask(with: existImgURL) { [weak self] (data, res, err) in
            guard let self = self else { return }
            guard let data = data else { return }
            if let img = UIImage(data: data){
                DispatchQueue.main.async {
                    self.ImgView.image = img
                }
            }
        }.resume()
    }
}
