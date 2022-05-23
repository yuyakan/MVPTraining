//
//  Presenter.swift
//  iOSEngineerCodeCheck
//
//  Created by 上別縄祐也 on 2022/05/02.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol SearchPresenterInput {
    var numberOfItems: Int { get }
    var showRepository: [String: Any] { get }
    func cancelTask()
    func row(index: Int) -> [String: Any]
    func search(searchBarText: String?)
    func toDetailView(indexPath: IndexPath)
}

protocol SearchPresenterOutput {
    func tableReload()
    func performSegue()
}


final class SearchPresenter {
    private var output: SearchPresenterOutput!
    private var model: SearchModelInput
    private var repository: [[String: Any]]
    private var tableIndex: Int!
    
    init(output: SearchPresenterOutput, model: SearchModelInput){
        self.output = output
        self.model = model
        self.repository = []
    }
}

extension SearchPresenter: SearchPresenterInput{
    
    var numberOfItems: Int {
        repository.count
    }
    
    var showRepository: [String : Any] {
        repository[tableIndex]
    }
    
    func cancelTask() {
        model.cancelTask()
    }
    
    func row(index: Int) -> [String : Any] {
        repository[index]
    }
    
    func search(searchBarText: String?) {
        guard let inputText = searchBarText else { return }
        if inputText.count == 0 { return }
        model.fetchRepository(inputText: inputText) {
            [weak self] items in
            guard let self = self else { return }
            self.repository = items
            self.output.tableReload()
        }
    }
    
    func toDetailView(indexPath: IndexPath) {
        tableIndex = indexPath.row
        self.output.performSegue()
    }
}
