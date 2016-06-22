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
        var returnCategories = Variable([Category]())
        
        if let configFilePath = NSBundle.mainBundle().pathForResource("Categories", ofType: "json"), let categoryModels = Mapper<Category>().mapArray(try! String(contentsOfFile: configFilePath)) {
            returnCategories.value = categoryModels
        }
        
        return returnCategories
    }()
    
    var activedCategory: Variable<Category!> = Variable(nil)
}