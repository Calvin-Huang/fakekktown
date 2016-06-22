//
//  CategoryViewModel.swift
//  CarouselPratice
//
//  Created by Calvin on 6/15/16.
//  Copyright © 2016 CapsLock. All rights reserved.
//

import Foundation

import RxSwift

struct CategoryViewModel {
    let categoriesJSON = NSData(contentsOfFile: "Categories.json")
    
//    let categories: Observable<[Category]> =
    
    init() {
        print(categoriesJSON)
    }
}