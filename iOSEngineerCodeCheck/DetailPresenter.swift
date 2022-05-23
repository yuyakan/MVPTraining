//
//  Presenter2.swift
//  iOSEngineerCodeCheck
//
//  Created by 上別縄祐也 on 2022/05/03.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol DetailPresenterInput {
    func getImage(owner: Any?)
}

protocol DetailPresenterOutput {
    func passImage(data: Data)
}

final class DetailPresenter {
    private var output: DetailPresenterOutput!
    private var model: DetailModelInput
    
    init(output: DetailPresenterOutput, model: DetailModelInput){
        self.output = output
        self.model = model
    }
}

extension DetailPresenter: DetailPresenterInput{
    
    func getImage(owner: Any?){
        
        guard let owner = owner as? [String: Any] else { return }
        model.fetchImage(owner: owner) {
           [weak self] data in
            guard let self = self else { return }
            self.output.passImage(data: data)
        }
        
    }
}
