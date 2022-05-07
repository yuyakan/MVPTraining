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
    
    var repository: [String: Any] = [:]
    
    private var input2: Presenter2Input!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        input2 = Presenter2(output2: self)
        
        LangLbl.text = "Written in \(repository["language"] as? String ?? "")"
        StrsLbl.text = "\(repository["stargazers_count"] as? Int ?? 0) stars"
        WchsLbl.text = "\(repository["wachers_count"] as? Int ?? 0) watchers"
        FrksLbl.text = "\(repository["forks_count"] as? Int ?? 0) forks"
        IsssLbl.text = "\(repository["open_issues_count"] as? Int ?? 0) open issues"
        getImage()
    }
    
    func getImage(){
        TtlLbl.text = repository["full_name"] as? String
        input2.getImage(owner :repository["owner"])
    }
}

extension ViewController2: Presenter2Output {
    func passImage(data: Data) {
        if let img = UIImage(data: data){
            DispatchQueue.main.async {
                self.ImgView.image = img
            }
        }
    }
}
