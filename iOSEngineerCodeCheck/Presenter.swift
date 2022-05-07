//
//  Presenter.swift
//  iOSEngineerCodeCheck
//
//  Created by 上別縄祐也 on 2022/05/02.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol PresenterInput {
    var numberOfItems: Int { get }
    var showRepository: [String: Any] { get }
    func cancelTask()
    func row(index: Int) -> [String: Any]
    func search(searchBarText: String?)
    func toDetailView(indexPath: IndexPath)
}

protocol PresenterOutput {
    func tableReload()
    func performSegue()
}


final class Presenter {
    private var output: PresenterOutput!
    private var repository: [[String: Any]]
    private var tableIndex: Int!
    private var task: URLSessionDataTask?
    
    init(output: PresenterOutput){
        self.output = output
        self.repository = []
    }
}

extension Presenter: PresenterInput{
    
    var numberOfItems: Int {
        repository.count
    }
    
    var showRepository: [String : Any] {
        repository[tableIndex]
    }
    
    func cancelTask() {
        if let task = task {
            task.cancel()
        }
    }
    
    func row(index: Int) -> [String : Any] {
        repository[index]
    }
    
    func search(searchBarText: String?) {
        guard let inputText = searchBarText else { return }
        if inputText.count == 0 { return }
        
        guard let url = URL(string: "https://api.github.com/search/repositories?q=\(inputText)") else { return }
        task = URLSession.shared.dataTask(with: url) { [weak self] (data, res, err) in
            guard let self = self else { return }
            guard let data = data else { return }
            guard let obj = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else { return }
            
            if let items = obj["items"] as? [[String: Any]] {
                self.repository = items
                self.output.tableReload()
            }
        }
        // これ呼ばなきゃリストが更新されません
        if let task = task {
            task.resume()
        }
    }
    
    func toDetailView(indexPath: IndexPath) {
        tableIndex = indexPath.row
        self.output.performSegue()
    }
}
