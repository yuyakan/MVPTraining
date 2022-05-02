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
    var showRepo: [String: Any] { get }
    func cancelTask()
    func row(idx: Int) -> [String: Any]
    func search(schBrTxt: String?)
    func toDetailView(idxPath: IndexPath)
}

protocol PresenterOutput {
    func tableReload()
    func performSegue()
}


final class Presenter {
    private var output: PresenterOutput!
    private var repo: [[String: Any]]
    private var tblIdx: Int!
    private var task: URLSessionDataTask?
    
    init(output: PresenterOutput){
        self.output = output
        self.repo = []
    }
}

extension Presenter: PresenterInput{
    
    var numberOfItems: Int {
        repo.count
    }
    
    var showRepo: [String : Any] {
        repo[tblIdx]
    }
    
    func cancelTask() {
        if let task = task {
            task.cancel()
        }
    }
    
    func row(idx: Int) -> [String : Any] {
        repo[idx]
    }
    
    func search(schBrTxt: String?) {
        guard let inpTxt = schBrTxt else { return }
        if inpTxt.count == 0 { return }
        
        guard let url = URL(string: "https://api.github.com/search/repositories?q=\(inpTxt)") else { return }
        task = URLSession.shared.dataTask(with: url) { [weak self] (data, res, err) in
            guard let self = self else { return }
            guard let data = data else { return }
            guard let obj = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else { return }
            
            if let items = obj["items"] as? [[String: Any]] {
                self.repo = items
                self.output.tableReload()
            }
        }
        // これ呼ばなきゃリストが更新されません
        if let task = task {
            task.resume()
        }
    }
    
    func toDetailView(idxPath: IndexPath) {
        tblIdx = idxPath.row
        self.output.performSegue()
    }
}
