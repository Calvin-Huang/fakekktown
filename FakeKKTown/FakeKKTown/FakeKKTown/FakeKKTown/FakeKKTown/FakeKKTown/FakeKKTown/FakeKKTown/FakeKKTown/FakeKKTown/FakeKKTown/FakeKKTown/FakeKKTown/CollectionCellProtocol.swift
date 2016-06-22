//
//  CollectionCellProtocol.swift
//  CarouselPratice
//
//  Created by Calvin on 6/14/16.
//  Copyright © 2016 CapsLock. All rights reserved.
//

import UIKit

protocol CollectionCellProtocol {
    static var itemSize: CGSize { get }
    static var reuseIdentifier: String { get }
}