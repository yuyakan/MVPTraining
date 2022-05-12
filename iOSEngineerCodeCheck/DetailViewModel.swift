//
//  DetailViewModel.swift
//  iOSEngineerCodeCheck
//
//  Created by 上別縄祐也 on 2022/05/12.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol DetailViewModelInput {
    func fetchImage(owner: [String: Any], completion: @escaping (Data)->())
}

class DetailViewModel: DetailViewModelInput {
    func fetchImage(owner: [String : Any], completion: @escaping (Data)->()) {
        guard let imgURL = owner["avatar_url"] as? String else { return }
        guard let existImgURL = URL(string: imgURL) else { return }
        URLSession.shared.dataTask(with: existImgURL) { (data, res, err) in
            guard let data = data else { return }
            completion(data)
            
        }.resume()
    }
}
