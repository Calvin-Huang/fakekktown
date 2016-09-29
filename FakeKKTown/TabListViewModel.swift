//
//  TabListViewModel.swift
//  FakeKKTown
//
//  Created by Calvin on 6/16/16.
//  Copyright © 2016 CapsLock. All rights reserved.
//

import Foundation
import RxSwift
import ObjectMapper

struct TabListViewModel {
    let categories: Variable<[Category]> = {
        guard
            let configFilePath = Bundle.main.path(forResource: "Categories", ofType: "json"),
            let categoryModels = Mapper<Category>().mapArray(JSONString: try! String(contentsOfFile: configFilePath))
            else {
                return Variable([Category]())
        }
        
        return Variable(categoryModels)
    }()
    
    var activedCategory: Variable<Category?> = Variable(nil)
}
