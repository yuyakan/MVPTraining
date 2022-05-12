//
//  Presenter2.swift
//  iOSEngineerCodeCheck
//
//  Created by 上別縄祐也 on 2022/05/03.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol DetailViewPresenterInput {
    func getImage(owner: Any?)
}

protocol DetailViewPresenterOutput {
    func passImage(data: Data)
}

final class DetailViewPresenter {
    private var output: DetailViewPresenterOutput!
    private var model: DetailViewModelInput
    
    init(output: DetailViewPresenterOutput, model: DetailViewModelInput){
        self.output = output
        self.model = model
    }
}

extension DetailViewPresenter: DetailViewPresenterInput{
    
    func getImage(owner: Any?){
        
        guard let owner = owner as? [String: Any] else { return }
        model.fetchImage(owner: owner) {
           [weak self] data in
            guard let self = self else { return }
            self.output.passImage(data: data)
        }
        
    }
}
