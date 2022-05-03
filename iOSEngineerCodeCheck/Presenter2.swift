//
//  Presenter2.swift
//  iOSEngineerCodeCheck
//
//  Created by 上別縄祐也 on 2022/05/03.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol Presenter2Input {
    func getImage(owner: Any?)
}

protocol Presenter2Output {
    func passImage(data: Data)
}

final class Presenter2 {
    private var output2: Presenter2Output!
    
    init(output2: Presenter2Output){
        self.output2 = output2
    }
}

extension Presenter2: Presenter2Input{
    
    func getImage(owner: Any?){
        
        guard let owner = owner as? [String: Any] else { return }
        
        guard let imgURL = owner["avatar_url"] as? String else { return }
        guard let existImgURL = URL(string: imgURL) else { return }
        URLSession.shared.dataTask(with: existImgURL) { [weak self] (data, res, err) in
            guard let self = self else { return }
            guard let data = data else { return }
            self.output2.passImage(data: data)
        }.resume()
    }
}
