//
//  UIScrollView+Rx.swift
//  CarouselPratice
//
//  Created by Calvin on 6/15/16.
//  Copyright © 2016 CapsLock. All rights reserved.
//

import RxSwift
import RxCocoa

extension Reactive where Base: UIScrollView {
    var didEndDragging: Observable<(UIScrollView, Bool)> {
        return delegate
            .observe(#selector(UIScrollViewDelegate.scrollViewDidEndDragging(_:willDecelerate:)))
            .map {
                return ($0[0] as! UIScrollView, $0[1] as! Bool)
            }
    }
    
    var didEndDecelerating: Observable<UIScrollView> {
        return delegate
            .observe(#selector(UIScrollViewDelegate.scrollViewDidEndDecelerating(_:)))
            .map {
                return $0[0] as! UIScrollView
            }
    }
}
