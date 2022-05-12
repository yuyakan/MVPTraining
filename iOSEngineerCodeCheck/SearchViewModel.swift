//
//  SearchViewModel.swift
//  iOSEngineerCodeCheck
//
//  Created by 上別縄祐也 on 2022/05/12.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol SearchViewModelInput {
    func cancelTask()
    func fetchRepository(inputText: String, completion: @escaping ([[String: Any]]) -> ())
}

final class SearchViewModel: SearchViewModelInput {
    private var task: URLSessionDataTask?
    
    func cancelTask() {
        if let task = task {
            task.cancel()
        }
    }
    
    func fetchRepository(inputText: String, completion: @escaping ([[String: Any]]) -> ()){
        guard let url = URL(string: "https://api.github.com/search/repositories?q=\(inputText)") else { return }
        task = URLSession.shared.dataTask(with: url) { (data, res, err) in
            guard let data = data else { return }
            guard let obj = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else { return }
            
            if let items = obj["items"] as? [[String: Any]] {
                completion(items)
            }
        }
        // これ呼ばなきゃリストが更新されません
        if let task = task {
            task.resume()
        }
    }
}
